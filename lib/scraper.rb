require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []



  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css(".social-icon-container").children.css("a").map (|e| e.attribute('href').value)
    links.each do |link|
      

  end

end
