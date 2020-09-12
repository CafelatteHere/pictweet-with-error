class Tweet < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments

  # мы это вынесли в отдельный файл в папке services
  # def self.search(search)
  #   if search != ""
  #     Tweet.where('text LIKE(?)', "%#{search}")
  #   else 
  #     Tweet.all
  #   end
  # end
end
