class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable,
  :omniauthable, omniauth_providers: [:github, :vkontakte]

  has_many :questions


  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destrda

  has_many :authorizations, dependent: :destroy

  def author?(resource)
    id == resource.user_id
  end

  def available_reward
    answers.where(reward: true)
  end

  def self.find_for_oauth(auth)
    FindForOauthService.new(auth).call
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end
