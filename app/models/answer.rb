class Answer < ApplicationRecord
  include Voteable
  include Commentable

  has_many :links, dependent: :destroy, as: :linkable

  belongs_to :question, touch: true
  belongs_to :user

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, presence: true
end
