require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    
    doc.css("div.roster-cards-container").each do |item|
      item.css(".student-card a").each do |card|
        student_name = card.css(".student-name").text
        student_location = card.css(".student-location").text
        student_profile_url = "#{card.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
    
      # card.css(".student-name").text
      # card.css(".student-location").text
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    doc.css(".social-icon-container").each do |item|
    binding.pry
    end  
  end

end

