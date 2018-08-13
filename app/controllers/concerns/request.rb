module Request
  def validate_params
    request_params = properties_params
    required_params.each do |required_param|
      if !request_params.has_key?(required_param)
        return json_response({}, :unprocessable_entity, "Request param '#{required_param}' is required")
      end
    end

    if allowed_property_types.include?(request_params[:property_type])
      if !allowed_marketing_types.include?(request_params[:marketing_type])
        json_response({}, :unprocessable_entity, "Request param 'marketing_type' has invalid value")
      end
    else
      json_response({}, :unprocessable_entity, "Request param 'property_type' has invalid value")
    end
  end

  def allowed_property_types
    %w(apartment single_family_house)
  end

  def allowed_marketing_types
    %w(rent sell)
  end
end
