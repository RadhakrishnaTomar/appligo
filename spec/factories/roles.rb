# spec/factories/roles.rb

FactoryBot.define do
  factory :role do
    # Define the name attribute with a default value
    name { "Default Role" }

    # Add any additional attributes as needed

    # Example of using a sequence for generating unique names
    # sequence(:name) { |n| "Role #{n}" }
  end
end
