class MonstersController < ApplicationController
  def index
    if params["name"].present?
      @monsters = Monster.where(name: /#{params["name"]}/i)
    else
      @monsters = Monster.all
    end
    render json: @monsters
  end

  def show
    @monster = Monster.find(params["id"])
    render json: @monster
  end
end
