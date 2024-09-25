module Rise
  class MonstersController < ApplicationController
    def index
      if params["name"].present?
        @monsters = RiseMonster.where(name: /#{params["name"]}/i)
      else
        @monsters = RiseMonster.all
      end
      render json: @monsters
    end
  
    def show
      @monster = RiseMonster.find(params["id"])
      render json: @monster
    end
  end
end