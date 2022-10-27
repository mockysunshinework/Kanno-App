class Request < ApplicationRecord
  belongs_to :user
  validates :request_name, presence: true
  validates :request_description, presence: true  
end
