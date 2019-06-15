#https://htmlpreview.github.io/?https://github.com/fbohz/oo-student-scraper-online-web-pt-051319/blob/master/fixtures/student-site/index.html

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    roster_container = doc.css(".roster-cards-container")
     roster_container.css(".student-card").collect do |student|
       {
      :name => student.css("div>h4").text,
      :location => student.css("div>p").text,
      :profile_url => student.css('a').attribute('href').value
       }
    end 
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    
    
  end

end

