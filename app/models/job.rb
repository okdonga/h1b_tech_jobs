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

  # def get_info
  #   searchTerm = searchTerm || 'tech jobs'
  #   location = location || 'San Francisco'
  #   limit = limit || 100

  #   response = 'https://api.indeed.com/ads/apisearch?'
  #   response += 'publisher=' + publisherKey + '&q='
  #   response += searchTerm
  #   response += '&l='
  #   response += location
  #   response += '&sort=&radius=&st=&jt=&start='
  #   response += '&limit='
  #   response +=  limit
  #   response += '&fromage=&filter=&latlong=1&co=us&chnl=&v=2&format=json'
  #   response
  # end

  # def API
  #   response = HTTParty.get(respone)
  # end
end

