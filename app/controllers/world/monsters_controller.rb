module World
  class MonstersController < ApplicationController
    def index
      result = World::Monsters::Index.new(**transformed_params).call
      render json: result
    end
  
    def show
      @monster = WorldMonster.find(params["id"])
      render json: @monster
    end
  end
end