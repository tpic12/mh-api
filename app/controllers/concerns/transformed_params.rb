module TransformedParams
  extend ActiveSupport::Concern

  def transformed_params
    Rails.logger.info "Params before transformation: #{params.inspect}"
    params.permit!.to_h.symbolize_keys
  end
end
