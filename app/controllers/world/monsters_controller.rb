require 'fuzzy_match'

module World
  class MonstersController < ApplicationController
    def index
      if params["name"].present?
        @monsters = get_monster_by_name(params["name"])
      else
        @monsters = WorldMonster.all
      end
      render json: @monsters
    end
  
    def show
      @monster = WorldMonster.find(params["id"])
      render json: @monster
    end

    private

    def get_monster_by_name(name)
      match = WorldMonster.where(name: /#{name}/i)
      return match unless match.empty?

      fz = FuzzyMatch.new(WorldMonster.all, :read => :name)
      fz.find(name)
    end
  end
end