class Chat < ApplicationRecord
belongs_to :room

validates :message, presence: { message: "を入力してください" }
validates :message,    length: { minimum: 1 }    

end
