class WikiScraper::WikiDisplay
  def line
    puts "----------------------------------------------"
  end

  def blank
    puts "\e[2J\e[f"
  end

  def first(page)
    get_title(page)
    get_first_p(page)
    get_subheadings(page)
  end

  def get_title(page)
    title = page.css("#firstHeading").text
    puts "#{title}"
    line
  end

  def get_first_p(page)
    paragraphs = page.css("p")
    puts paragraphs.find { |para| para.text.length > 50 }.text
    line
  end

  def get_subheadings(page)
    bad_headings = ["Contents", "See also", "References", "Bibliography", "External links", "Navigation menu", "Notes"]
    headings = page.css("h2")
    index = 1
    sorted_headings = []
    puts "Topics:"
    headings.each do |heading|
      if bad_headings.any? { |bad| bad == heading.text }
        next
      end
      sorted_headings << heading.text
      puts "#{index}. #{heading.text}"
      index += 1
    end
  end
end
