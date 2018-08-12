class PropertiesController < ApplicationController
  def index
    @properties = Property.similar(properties_params)
    if @properties.any?
      json_response(@properties)
    else
      json_response(@properties, :no_content)
    end
  end

  private

  def properties_params
    params.permit(:lng, :lat, :property_type, :marketing_type).to_h.symbolize_keys
  end
end
