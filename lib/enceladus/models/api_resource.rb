class Enceladus::ApiResource
private
  def rebuild_single_resource(resource_from_response)
    self.class::RESOURCE_ATTRIBUTES.each do |resource_attr|
      self.public_send("#{resource_attr}=", resource_from_response.public_send(resource_attr)) if resource_from_response.respond_to?(resource_attr)
    end
    self
  end

  def self.build_single_resource(resource_from_response)
    resource = self.new
    self::RESOURCE_ATTRIBUTES.each do |resource_attr|
      resource.public_send("#{resource_attr}=", resource_from_response.public_send(resource_attr)) if resource_from_response.respond_to?(resource_attr)
    end
    resource
  end

  def self.build_collection(resources_from_response)
    resources = []
    resources_from_response.each do |resource_from_response|
      resources << self.build_single_resource(resource_from_response)
    end
    resources
  end
end