module Rise
  class LocalesController < ApplicationController
    def index
      input = transformed_params.merge(**params[:filter].to_h.symbolize_keys)
      result = Rise::Locales::Index.new(**input).call

      render json: result
    end

  end
end