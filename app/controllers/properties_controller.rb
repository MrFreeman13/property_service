class PropertiesController < ApplicationController
  def index
    @properties = Property.similar(properties_params)
    json_response(@properties)
  end

  private

  def properties_params
    params.permit(:lng, :lat, :property_type, :marketing_type).to_h.symbolize_keys
  end
end
