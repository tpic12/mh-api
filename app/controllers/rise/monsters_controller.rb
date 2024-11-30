module Rise
  class MonstersController < ApplicationController

    def index
      result = Rise::Monsters::Index.new(**transformed_params).call
      render json: result
    end
  
    def show
      @monster = RiseMonster.find(params["id"])
      render json: @monster
    end
  end
end