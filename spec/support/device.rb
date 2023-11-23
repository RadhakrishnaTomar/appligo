require '/home/mj/appligo/spec/support/controller_macros.rb'

RSpec.configure do |config|
	config.include Devise::Test::ControllerHelpers, :type => :controller
end