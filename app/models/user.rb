require 'bcrypt'

class User < ActiveRecord::Base

  has_and_belongs_to_many :jobs
  # has_many :jobs
  # has_many :companies
  # has_many :jobs, through: :companies

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :hashed_password, length: { :minimum => 6 }

  include BCrypt

  def password
    p "password method"
    @password ||= Password.new(hashed_password)
  end

  def password=(new_password)
    p "password= method"
    @password = Password.create(new_password)
    self.hashed_password = @password
  end

  def self.admin(current_user)
    if User.find(current_user).admin == 1
      return true
    end
  end

  def self.jobs_for_admin(admins)
    # in the case there are multiple admins
    aggregate = []
    admins.each do |admin|
      unless admin.jobs.empty?
        admin.jobs.each do |job|
          aggregate << job
        end
      end
    end
  aggregate
  end
end
