module World
  class LocalesController < ApplicationController
    def index
      result = World::Locales::Index.new(params).call

      render json: result
    end

  end
end