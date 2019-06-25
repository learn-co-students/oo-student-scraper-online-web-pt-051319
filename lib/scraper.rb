require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

    def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    projects = []
    doc.css("div.roster-cards-container div.student-card").each do |profile|
      projects << {
        :name => profile.css("h4.student-name").text,
        :location => profile.css("p.student-location").text,
        :profile_url => profile.css("a").attribute("href").value
      }
    end
    projects
  end

  def self.scrape_profile_page(profile_url)
      html = File.read(profile_url)
        doc = Nokogiri::HTML(html)
        profile = {}
              doc.css("div.vitals-container div.social-icon-container a").each do |item|
                if item.css("img").attr("src").value == "../assets/img/twitter-icon.png"
                  profile[:twitter] = item.attr("href")
                elsif item.css("img").attr("src").value == "../assets/img/linkedin-icon.png"
                    profile[:linkedin] = item.attr("href")
                elsif item.css("img").attr("src").value  == "../assets/img/github-icon.png"
                    profile[:github] = item.attr("href")
                elsif item.css("img").attr("src").value == "../assets/img/rss-icon.png"
                    profile[:blog] = item.attr("href")
                    end 
                    end 
                    
                  profile[:profile_quote] = doc.css("div.vitals-container div.vitals-text-container div.profile-quote").text
                  profile[:bio] = doc.css("div.details-container div.description-holder p").text

                 profile
       end


end