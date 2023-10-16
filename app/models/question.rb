class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user
  belongs_to :best_answer, class_name: 'Answer', optional: true

  has_many_attached :files

  validates :body, :title, presence: true

  def mark_as_best(answer)
    update(best_answer_id: answer.id)
  end
end
