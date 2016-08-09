class Goal < ActiveRecord::Base
  validates :title, :user_id, :body, presence: true

  belongs_to :user

end
