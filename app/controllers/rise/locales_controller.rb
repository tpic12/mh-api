module Rise
  class LocalesController < ApplicationController
    def index
      result = Rise::Locales::Index.new(params).call

      render json: result
    end

  end
end