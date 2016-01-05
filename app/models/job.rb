require 'httparty'

class Job < ActiveRecord::Base
  include HTTParty

  has_and_belongs_to_many :users
  # belongs_to :user
  # has_many :companies
  # has_many :users, through: :companies
  validates :title, :description, presence: true
  validates :description, uniqueness: true
  # use scope or this class method to query


  # response =
  # HTTParty.get("http://api.indeed.com/ads/apisearch?publisher=4019886558740498&q=tech&l=SF &sort=&radius=&st=&jt=&start=&limit=15&fromage=&filter=&latlong=1&co=us&chnl=&v=2&format=json")

  # def API
  #   response = HTTParty.get(respone)
  # end
end
