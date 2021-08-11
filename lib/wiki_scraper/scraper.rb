class WikiScraper::Scraper
  def get_page
    url = "https://en.wikipedia.org/wiki/Human"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page.body)
    #get_title(parsed_page)
    #get_first_p(parsed_page)
    get_subheadings(parsed_page)
  end

  def get_title(page)
    title = page.css("#firstHeading").text
    puts title
  end

  def get_first_p(page)
    paragraphs = page.css("p")
    puts paragraphs.find { |para| para.text.length > 50 }.text
  end

  def get_subheadings(page)
    bad_headings = ['Contents', 'See also', 'References', 'Bibliography', 'External links', 'Navigation menu', 'Notes']
    headings = page.css("h2")
    index = 1
    headings.each do |heading|
      if bad_headings.any? {|bad| bad == heading.text}
        next
      end
      puts "#{index}. #{heading.text}"
      index += 1
    end
  end
end