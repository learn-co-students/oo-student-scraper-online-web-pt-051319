require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    binding.pry
    #doc.search("h4").text <= name list
      
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

