class Regard < ApplicationRecord
  belongs_to :question

  has_one_attached :pic

  validates :name, presence: true
  validates :pic, presence: true
end
