class OrganisationSetting < ApplicationRecord
  belongs_to :company, optional: true
end
