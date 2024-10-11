require "fuzzy_match"

module World
  module Locales
    class Index

      def initialize(params)
        @locale = params["locale"]
        @by_threat_level = params&.[]("filter")&.[]("by_threat_level")
        # @species = params["filter"]["species"]
      end

      def call
        monsters = build_query
        return if monsters.blank?

        monster_list = apply_filters(monsters)
        locale_object = reduce_locale_object(monsters)

        {monsterList: monster_list, localeObject: locale_object}
      end

      private

      def build_query
        return [] if @locale.blank?

        monsters_by_locale
      end

      def apply_filters(monsters)
        filtered_monsters = reduce_by_threat_level(monsters) if @by_threat_level

        filtered_monsters
      end

      def monsters_by_locale
        # fz = FuzzyMatch.new(WorldMonster.all, :read => :locations.name)
        WorldMonster.where("locations.name": /#{@locale.downcase}/i)
      end
  
      def reduce_by_threat_level(monsters)
        threat_hash = Hash.new
  
        monsters.each do |monster|
          monster_block = {
            name: monster.name,
            tempered: monster.is_tempered(@locale)
          }
          if threat_hash[monster.threat_level]
            threat_hash[monster.threat_level].push(monster_block)
          else
            threat_hash[monster.threat_level] = [monster_block]
          end
        end
  
        threat_hash
      end
  
      def reduce_locale_object(monsters)
        fz = FuzzyMatch.new(monsters[0].locations, :read => :name)
        locale_name = fz.find(@locale).name
          # Iterate over the monsters
        # Rails.logger.info "#{locale_name}"
        final_location = Hash.new
        monsters.each do |monster|
          monster["locations"].each do |location|
            # Rails.logger.info "location | #{location}"
            # Only process the location if the name matches the location_name provided
            if location["name"] == locale_name
              final_location["name"] = location["name"] unless location["name"].nil?
              final_location["color"] = location["color"] unless location["color"].nil?
              final_location["icon"] = location["icon"] unless location["icon"].nil?
            end
          end
        end
        final_location
      end
    end
  end
end