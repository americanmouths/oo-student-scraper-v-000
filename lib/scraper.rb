require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".roster-cards-container .student-card").each do |student|
      scraped_students = {
        :name => student.css(".card-text-container").first.css("h4").text,
        :location => student.css(".card-text-container").first.css("p").text,
        :profile_url => student.css("a").attribute("href").value
      }
        students << scraped_students
    end
        students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profiles = {}
    doc.css(".main-wrapper").each do |profile|
      scraped_profiles= {
        if :twitter == profile.css(".vitals-container .social-icon-container a").attribute("href").value
        :twitter => profile.css(".vitals-container .social-icon-container a").attribute("href").value
      end
        :linkedin => profile.css(".vitals-container .social-icon-container a + a").attribute("href").value,
        :github => profile.css(".vitals-container .social-icon-container a + a + a").attribute("href").value,
        :blog => profile.css(".vitals-container .social-icon-container a + a + a + a").attribute("href").value,
        :profile_quote => profile.css(".vitals-text-container .profile-quote").text,
        :bio => profile.css(".description-holder p").first.text
      }
        profiles = scraped_profiles
  end
        profiles

  end

end
