# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# company = Comapny(name: "Throughout Technologies", location: "Y.N. Road") 
# TO DO: Roles need to create


%w(Admin Moderator HR).each do |role_name|
  Role.find_or_create_by(name: role_name)
end

[{name: "Basic", active_features: Permission.all_models , price_per_year: 0.00 ,description: "Basic plan have not any advanced features."}].each do |plan_details|
  plan = Plan.find_or_initialize_by(name: plan_details[:name])
  plan.active_features = plan_details[:active_features]
  plan.price_per_year = plan_details[:price_per_year]
  plan.description = plan_details[:description]

  plan.save
end

# Department.create!([
#   {name:"Development", company_id: company.id}, 
#   {name: "Designing", company_id: company.id}, 
#   {name: "Sales", company_id: company.id}, 
#   {name: "Human Resource", company_id: company.id}, 
#   {name: "Marketing", company_id: company.id}, 
#   {name: "IT", company_id: company.id}
#  ])

# Create AdminUser for SuperAdmin
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
