module Rise
  class LocalesController < ApplicationController
    def index
      result = Rise::Locales::Index.new(**transformed_params).call

      render json: result
    end

  end
end