class WikiScraper::Scraper
  def get_page
    url = "https://en.wikipedia.org/wiki/Dog"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    get_title(parsed_page)
  end

  def get_title(page)
    title = page.css('#firstHeading').text
    puts title
  end


end
