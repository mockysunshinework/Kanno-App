class Request < ApplicationRecord
  belongs_to :user
  
  validates :request_name, presence: true
  validates :request_description, presence: true  

  # リクエスト新規作成の際、期日が本日よりも前の日付の場合に無効
  validate :request_time_check

  # リクエスト編集の際、期日が作成日よりも前の日付の場合に日付の場合に

  def request_time_check
    errors.add(:request_deadline, "は本日以降を選択してください。") if self.request_deadline.nil? || self.request_deadline.blank? || (self.request_deadline < Date.current)
  end
  
end
