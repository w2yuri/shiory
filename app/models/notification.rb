class Notification < ApplicationRecord
  belongs_to :customer
  belongs_to :notifiable, polymorphic: true
end
