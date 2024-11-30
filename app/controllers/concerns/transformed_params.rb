module TransformedParams
  extend ActiveSupport::Concern

  def transformed_params
    params.permit!.to_h.symbolize_keys
  end
end
