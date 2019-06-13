require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []

    student_cards = doc.css("div.student-card")

    student_cards.each do |student|
      students << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value
        }
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student = {
      profile_quote: doc.css(".profile-quote").text,
      bio: doc.css(".bio-content .description-holder p").text
      }

    student_socials = doc.css(".social-icon-container a")

    student_socials.each do |social|
      platform = social.css("img").attribute("src").value.gsub(/.+\//, "").gsub("-icon.png", "")
      platform = "blog" if platform == "rss"
      url = social.attribute("href").value
      if platform == "blog" || platform == "twitter" || platform == "linkedin" || platform == "github"
        student[platform.to_sym] = url
      end
    end

    student

  end

end
