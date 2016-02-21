class ExternalAuthentication < ActiveRecord::Base
  serialize :json

  belongs_to :user
end
