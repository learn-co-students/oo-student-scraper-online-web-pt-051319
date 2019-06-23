require 'open-uri'
require 'pry'
# require "awesome_print"

class Scraper

  def self.scrape_index_page(index_url)
    data = Nokogiri::HTML(open(index_url))
    data.css(".student-card").map do |student|
    	{
    		:name => student.css("h4.student-name").text,
    		:location => student.css("p.student-location").text,
    		:profile_url => student.css("a[href]").first["href"]
    	}
    end
  end

  def self.scrape_profile_page(profile_url)
    data = Nokogiri::HTML(open(profile_url))
    student_info = {}
    student_info[:bio] = data.css("div.description-holder > p").text
    student_info[:profile_quote] = data.css("div.profile-quote").text
    data.css("div.social-icon-container > a").each do |link|
    	url = link['href']
    	if url.include? "twitter"
    		student_info[:twitter] = url
    	elsif url.include? "facebook"
    		student_info[:facebook] = url
    	elsif url.include? "github"
    		student_info[:github] = url
    	elsif url.include? "linkedin"
    		student_info[:linkedin] = url
    	else
    		student_info[:blog] = url
    	end
    end
    student_info
  end

end



=begin
<div class="vitals-container">
        <div class="profile-photo" id="joe-burgess-card"></div>
        <div class="social-icon-container">
          <a href="https://twitter.com/jmburges"><img class="social-icon" src="../assets/img/twitter-icon.png"/></a>
          <a href="https://www.linkedin.com/in/jmburges"><img class="social-icon" src="../assets/img/linkedin-icon.png"/></a>
          <a href="https://github.com/jmburges"><img class="social-icon" src="../assets/img/github-icon.png"/></a>
          <a href="http://joemburgess.com/"><img class="social-icon" src="../assets/img/rss-icon.png"/></a>
        </div>
        <div class="vitals-text-container">
          <h1 class="profile-name">Joe Burgess</h1>
          <h2 class="profile-location">New York, NY</h2>
          <div class="profile-quote">"Reduce to a previously solved problem"</div>
        </div>
      </div>
      <div class="details-container">
        <div class="bio-block details-block">
          <div class="bio-content content-holder">
            <div class="title-holder">
              <h3>Biography</h3>
            </div>
            <div class="description-holder">
              <p>I grew up outside of the Washington DC (NoVA!) and went to college at Carnegie Mellon University in Pittsburgh. After college, I worked as an Oracle consultant for IBM for a bit and now I teach here at The Flatiron School.</p>
            </div>
          </div>
        </div>
=end