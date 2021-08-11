class WikiScraper::Scraper
  def get_page
    puts "made it"
    html = "https://en.wikipedia.org/wiki/Dog"
    html = "https://www.rubyguides.com/2012/01/parsing-html-in-ruby/"

    
    parsed_data = Nokogiri::HTML.parse(html)

    puts parsed_data.title
    
  end
end
