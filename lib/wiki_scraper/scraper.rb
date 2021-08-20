class WikiScraper::Scraper
  def get_page(search_term = "Cat")
    url = "https://en.wikipedia.org/wiki/#{search_term}"
    unparsed_page = HTTParty.get(url)
    Nokogiri::HTML(unparsed_page.body) #Returns parsed page
  end
end
