class Company < ActiveRecord::Base
  belongs_to :jobs
  belongs_to :users
  validates :name, :location, presence: true
end
