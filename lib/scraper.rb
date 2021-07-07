require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_index_array = []
    page = Nokogiri::HTML(open(index_url))
    page.css("div.student-card").each do |student|
      student_hash = {} ##{:name, :location, :profile_url}
      student_hash[:name] = student.css("h4.student-name").text
      student_hash[:location] =student.css("p.student-location").text
      student_hash[:profile_url]= student.css("a").attribute("href").value
      
      student_index_array << student_hash
      
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    profile_hash ={} #{:twitter_url, :linkedin_url, :github_url, :blog_url, :profile_quote, :bio}
    
    page.css("div.social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        profile_hash[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        profile_hash[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        profile_hash[:github] = social.attribute("href").value
      else
        profile_hash[:blog] = social.attribute("href").value
        end
      end
      profile_hash[:profile_quote] = page.css("div.profile-quote").text
      profile_hash[:bio] = page.css("div.description-holder p").text
      
      profile_hash
    
  end
    

end

