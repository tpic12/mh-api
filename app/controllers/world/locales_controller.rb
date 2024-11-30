module World
  class LocalesController < ApplicationController
    def index
      result = World::Locales::Index.new(**transformed_params).call

      render json: result
    end
  end
end