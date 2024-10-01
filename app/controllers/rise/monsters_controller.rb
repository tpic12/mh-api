require 'fuzzy_match'

module Rise
  class MonstersController < ApplicationController
    def index
      if params["name"].present?
        @monsters = get_monster_by_name(params["name"])
      else
        @monsters = RiseMonster.all
      end
      render json: @monsters
    end
  
    def show
      @monster = RiseMonster.find(params["id"])
      render json: @monster
    end
    
    private

    def get_monster_by_name(name)
      match = RiseMonster.where(name: name.downcase)
      return match unless match.empty?

      fz = FuzzyMatch.new(RiseMonster.all, :read => :name)
      [fz.find(name)]
    end
  end
end