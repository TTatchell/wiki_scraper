class WikiScraper::Scraper
  def get_page
    url = "https://en.wikipedia.org/wiki/Cat"
    unparsed_page = HTTParty.get(url)
    Nokogiri::HTML(unparsed_page.body) #Returns parsed page
  end
end
