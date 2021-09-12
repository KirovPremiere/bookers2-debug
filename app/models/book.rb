class Book < ApplicationRecord
	belongs_to :user #1:nの関係の逆側

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
