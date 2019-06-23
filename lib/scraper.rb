require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  #index_url = "./fixtures/student-site/index.html"
  
  def self.scrape_index_page(index_url)
    # url = open(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_list = doc.css(".student-card")
    students = []                             # wants an array
  
    student_list.map do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr("href").value
      } 
    end
    students
  end

# profile_url == "./fixtures/student-site/students/joe-burgess.html"
# Not everyone will not have a twitter or some other social link
# Needs twitter, linkedin, github, blog, profile_quote, bio 
  def self.scrape_profile_page(profile_url)
    # binding.pry
    # url = open(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    profile_quote = doc.css(".profile-quote").text 
    bio = doc.css(".bio-content .description-holder p").text.strip 
    students = {:bio => bio, :profile_quote => profile_quote}                             # wants a hash
    
    student_profile = doc.css("div.social-icon-container a")
    student_profile.map do |student|
       info_link = student.attr("href")
        if info_link.include?("twitter")
          students[:twitter] = info_link
        elsif info_link.include?("linkedin")
          students[:linkedin] = info_link
        elsif info_link.include?("github")
          students[:github] = info_link
        else info_link.include?("blog")
          students[:blog] = info_link
        end
      end
       students
  end
end

