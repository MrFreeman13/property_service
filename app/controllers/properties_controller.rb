class PropertiesController < ApplicationController
  before_action :validate_params

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
    params.permit(*required_params).to_h.symbolize_keys
  end

  def required_params
    [:lng, :lat, :property_type, :marketing_type]
  end
end
