class Subscription < ApplicationRecord
	 belongs_to :plan
	 belongs_to :company
end
