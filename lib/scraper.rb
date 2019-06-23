require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_array = []
    student_index = doc.css(".student-card")
    student_index.each do |student|
      student_array << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").text
      }
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    student_hash = {}
    
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".bio-block .description-holder p").text.strip
    
    social_media_root = doc.css(".social-icon-container a")
    
    social_media_root.each do |social_media|
      url = social_media.attribute("href").value
      #binding.pry
      if url.include?("twitter")
        student_hash[:twitter] = url
      elsif url.include?("linkedin")
        student_hash[:linkedin] = url
      elsif url.include?("github")
        student_hash[:github] = url
      elsif url.include?("facebook")
        student_hash[:facebook] = url
      else
        student_hash[:blog] = url
      end
      #binding.pry
    end
    student_hash
  end

end