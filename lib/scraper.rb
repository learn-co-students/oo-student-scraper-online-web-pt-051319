require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    
    
    page = Nokogiri::HTML(open(index_url))
    
    students = []
    
    student_list = page.css('.roster-cards-container')
    
    student_list.css('div.student-card').each do |student| 
    
     name = student.css('h4').text
     location = student.css('a p').text
     profile_url = student.css('a').attribute('href').text
     
     student_card = {:location => location, :name => name, :profile_url => profile_url}
     students << student_card
     
    end
    students
  end
  
  #twitter_url = 
  #linkedin_url = 
  #github_url = 
  #blog_url = 
  #profile_quote = 
  #bio = 
  
  
  def self.scrape_profile_page(profile_url)
    
   student_hash = {}
    student_page = Nokogiri::HTML(open(profile_url))
    
    student_links = student_page.css('.social-icon-container').css('a').map{ |link| link.attribute('href').value}
    
      student_links.each do |student|
      
      if student.include?("twitter")
        student_hash[:twitter] = student
        
      elsif student.include?("linkedin")
        student_hash[:linkedin] = student
      elsif student.include?("github")
        student_hash[:github] = student
      else 
       student_hash[:blog] = student
      end
      student_hash[:profile_quote] = student_page.css('.profile-quote').text
      student_hash[:bio] = student_page.css('.description-holder p').text
    end
      student_hash
  end
  
end