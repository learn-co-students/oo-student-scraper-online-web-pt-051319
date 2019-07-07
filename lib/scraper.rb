require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card").each do |profile|
      students << {
        location: profile.css(".card-text-container p.student-location").text,
        name: profile.css(".card-text-container h4.student-name").text,
        profile_url: profile.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    doc.css("div.social-icon-container a").each_with_index do |a, i|
      case a.css("img.social-icon").attribute("src").value
      when "../assets/img/twitter-icon.png"
        student[:twitter] = a.attribute("href").value
      when "../assets/img/linkedin-icon.png"
        student[:linkedin] = a.attribute("href").value
      when "../assets/img/github-icon.png"
        student[:github] = a.attribute("href").value
      when "../assets/img/rss-icon.png"
        student[:blog] = a.attribute("href").value
      end
      student[:profile_quote] = doc.css(".vitals-text-container div.profile-quote").text
      student[:bio] = doc.css(".details-container div.bio-block div.bio-content div.description-holder p").text
    end
    student
  end
end
