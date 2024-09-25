module World
  class MonstersController < ApplicationController
    def index
      if params["name"].present?
        @monsters = WorldMonster.where(name: /#{params["name"]}/i)
      else
        @monsters = WorldMonster.all
      end
      render json: @monsters
    end
  
    def show
      @monster = WorldMonster.find(params["id"])
      render json: @monster
    end
  end
end