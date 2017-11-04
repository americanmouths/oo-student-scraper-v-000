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
    scraped_profiles = {}
    binding.pry
    
    scraped_profiles[:twitter] = doc.css('a[href*="twitter"]').attribute('href').value unless
    doc.css('a[href*="twitter"]').attribute('href').value == []

    scraped_profiles[:linkedin] = profile.css(".vitals-container .social-icon-container a + a").attribute("href").value unless
    profile.css(".vitals-container .social-icon-container a + a").attribute("href").value == []

    scraped_profiles[:github] = profile.css(".vitals-container .social-icon-container a + a + a").attribute("href").value unless
    profile.css(".vitals-container .social-icon-container a + a + a").attribute("href").value == []

    scraped_profiles[:blog] = profile.css(".vitals-container .social-icon-container a + a + a + a").attribute("href").value unless
    profile.css(".vitals-container .social-icon-container a + a + a + a").attribute("href").value == []

    scraped_profiles[:profile_quote] = profile.css(".vitals-text-container .profile-quote").text unless
    profile.css(".vitals-text-container .profile-quote").text == []

    scraped_profiles[:bio] = profile.css(".description-holder p").first.text unless
    profile.css(".description-holder p").first.text == []

   scraped_profiles
  end


end
