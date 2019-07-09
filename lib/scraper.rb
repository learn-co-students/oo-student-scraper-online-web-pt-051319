require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    
  doc = Nokogiri::HTML(open(index_url))
  new_array = []
  
  doc.css('div.roster-cards-container').each do |student_info|
    student_info.css('div.student-card a').each do |student|
      
      student_name = student.css('h4.student-name').text
      student_location = student.css('p.student-location').text
      student_url = student.attr('href')
      
      student_hash = {:name => student_name, :location => student_location, :profile_url => student_url}
      
      new_array << student_hash
  end 
  end 
  new_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    
    
    container = doc.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      container.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?(".com")
          student[:blog] = link
        end
      end
      student[:profile_quote] = doc.css(".profile-quote").text
      student[:bio] = doc.css("div.description-holder p").text
      student
  end

end

# doc.css('div.social-icon-container').each do |social|
#     social.css('a').attr('href').value

  # twitter_link = doc.css('div.social-icon-container').css('a')[0].attr('href')
    # linkedin_link = doc.css('div.social-icon-container').css('a')[1].attr('href')
    # github_link = doc.css('div.social-icon-container').css('a')[2].attr('href')
    # blog = doc.css('div.social-icon-container').css('a')[3].attr('href')
    # bio = doc.css('div.description-holder').css('p').text
    # quote = doc.css('div.vitals-text-container').css('div.profile-quote').text
    
    # student_hash = {:twitter_link => profile.css('div.social-icon-container').css('a')[0].attr('href'),
      # :linkedin_link => profile.css('div.social-icon-container').css('a')[1].attr('href'),
      # :github_link => profile.css('div.social-icon-container').css('a')[2].attr('href'),
      # :blog => profile.css('div.social-icon-container').css('a')[3].attr('href'),
      # :profile_quote => profile.css('div.vitals-text-container').css('div.profile-quote').text,
      # :bio => profile.css('div.vitals-text-container').css('div.profile-quote').text}
    
