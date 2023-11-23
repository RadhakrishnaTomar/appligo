FactoryBot.define do
  factory :team_member, class: TeamMember do
    name {"Ravi Shekhar Thakur"}
    email {"xygts@gmail.com"}
    role_id {1}
    company_id {107}
    contact_number {"7974054406"}
    password {123456}
  end
end