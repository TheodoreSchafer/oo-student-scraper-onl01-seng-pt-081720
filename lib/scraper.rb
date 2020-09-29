require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_hash = []
   html = Nokogiri::HTML(open(index_url))
   html.css(".student-card").collect do |student|
     hash = {
       name: student.css("h4.student-name").text,
       location: student.css("p.student-location").text,
       profile_url: "http://students.learn.co/" + student.css("a").attribute("href")
     }
     students_hash << hash
   end
   students_hash



  end

  def self.scrape_profile_page(profile_url)
    student = {}
    html = open(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css(".social-icon-container").children.css("a").map {|e| e.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end

    student[:profile_quote] = profile_page.css(".profile_quote").text if profile_page.css(".profile_quote")
    student[:bio] = profile_page.css("div.bio-content.content-holder").text if profile_page.css("div.bio-content.content-holder")
    student
  end






end
