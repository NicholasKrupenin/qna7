class Regard < ApplicationRecord
  belongs_to :question
  belongs_to :answer

  has_one_attached :pic

  validates :name, presence: true
end
