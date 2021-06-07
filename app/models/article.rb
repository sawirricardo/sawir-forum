class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :comments
  has_many :favoriters
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :body, presence: true
  accepts_nested_attributes_for :tags
end
