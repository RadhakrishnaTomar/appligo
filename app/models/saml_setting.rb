class SamlSetting < ApplicationRecord
  belongs_to :company


 def sso_url
    "#{ENV["IDP_HOST"]}/app/#{self.app_uuid}/saml/auth"
  end
  
  def slo_url
    "#{ENV["IDP_HOST"]}/app/#{self.app_uuid}/saml/logout"
  end

  def password_url
    "#{ENV["IDP_HOST"]}/app/#{self.app_uuid}/saml/auth"
  end
end