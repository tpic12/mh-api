module World
  class LocalesController < ApplicationController
    def index
      return unless params["locale"]
      @monsters = get_monsters_by_locale(params["locale"])
      monster_list = reduce_by_threat_level(@monsters)

      render json: monster_list
    end

    private

    def get_monsters_by_locale(locale)
      # fz = FuzzyMatch.new(WorldMonster.all, :read => :locations.name)
      WorldMonster.where("locations.name": /#{locale.downcase}/i)
    end

    def reduce_by_threat_level(monsters)
      threat_hash = Hash.new

      monsters.each do |monster|
        monster_block = {
          name: monster.name,
          tempered: monster.is_tempered(params["locale"])
        }
        if threat_hash[monster.threat_level]
          threat_hash[monster.threat_level].push(monster_block)
        else
          threat_hash[monster.threat_level] = [monster_block]
        end
      end

      threat_hash
    end

  end
end