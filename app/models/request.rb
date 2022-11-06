class Request < ApplicationRecord
  belongs_to :user
  
  validates :request_name, presence: true
  validates :request_description, presence: true  

  validate :request_time_check

  def request_time_check
    errors.add(request_deadline, "は本日以降を選択してください。") if self.request_deadline < DateTime.now
  end
  
end
