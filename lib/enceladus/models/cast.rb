class Enceladus::Cast < Enceladus::ApiResource
  RESOURCE_ATTRIBUTES = [:cast_id, :character, :credit_id, :id, :name, :order, :profile_path].map(&:freeze).freeze
  attr_accessor *RESOURCE_ATTRIBUTES

  def profile_urls
    Enceladus::Configuration::Image.instance.url_for("profile", profile_path)
  end
end