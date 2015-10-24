class Job < ActiveRecord::Base
  has_and_belongs_to_many :users
  # belongs_to :user
  # has_many :companies
  # has_many :users, through: :companies
  validates :title, :description, presence: true
  validates :description, uniqueness: true
  # use scope or this class method to query



end


