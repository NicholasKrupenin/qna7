class Question < ApplicationRecord
  include Voteable
  include Commentable

  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable

  has_one :regard, dependent: :destroy

  belongs_to :user
  belongs_to :best_answer, class_name: 'Answer', optional: true

  has_many_attached :files

  accepts_nested_attributes_for :links, :regard, reject_if: :all_blank

  validates :body, :title, presence: true

  after_create :calculate_reputation

  def mark_as_best(answer)
    update(best_answer_id: answer.id)
    answers.find_by(reward: true)&.update(reward: false)
    answer.update(reward: true) if regard.present?
  end

  private

  def calculate_reputation
    ReputationJob.perform_later(self)
  end
end
