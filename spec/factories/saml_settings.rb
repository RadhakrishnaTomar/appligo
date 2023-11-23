FactoryBot.define do
  factory :saml_setting do
    sso_url { "MyString" }
    slo_url { "MyString" }
    password_url { "MyString" }
    certificate { "MyText" }
    app_uuid { "MyString" }
    org_uuid { "MyString" }
  end
end
