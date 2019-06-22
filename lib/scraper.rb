require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :students
  
  def self.scrape_index_page(index_url)

    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_list = doc.css(".student-card")
    students = []

    student_list.collect do |item|
      students << {
        :name => item.css("h4.student-name").text,
        :location => item.css("p.student-location").text,
        :profile_url => item.css("a").attribute("href").value
      }

    end
    students
  end

  def self.scrape_profile_page(profile_url)

    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_profile = doc.css(".social-icon-container a")
    student_bio = doc.css(".bio-content .description-holder").text.strip
    student_quote = doc.css(".profile-quote").text
    profile_info = {:bio => student_bio,
      :profile_quote => student_quote}

      student_profile.collect do |profile|
        profile.attribute("href").value

        if profile.attribute("href").value.include? "twitter"
          profile_info[:twitter] = profile.attribute("href").value

        elsif profile.attribute("href").value.include? "github"
          profile_info[:github] = profile.attribute("href").value

        elsif profile.attribute("href").value.include? "linkedin"
          profile_info[:linkedin] = profile.attribute("href").value

        else profile_info[:blog] = profile.attribute("href").value

        end
      end
      profile_info
    end

  end
