class User < ApplicationRecord
  has_secure_password

  has_many :articles
  has_many :comments
  has_many :favoriters
  has_many :favorites, through: :favoriters, source: :article
  has_many :followers

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 5, maximum: 120 }, on: :create
  validates :password, length: { minimum: 5, maximum: 120 }, on: :update, allow_blank: true
end
