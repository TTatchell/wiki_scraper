class WikiScraper::WikiDisplay
  def line
    puts "----------------------------------------------"
  end

  def blank
    puts "\e[2J\e[f"
  end

  def initialize(page) #Displays title, short desc and subheadings
    blank
    @page = page
    print_title()
    print_summary()
    print_subheadings()
    create_paragraphs
  end

  def print_title
    @title = @page.css("#firstHeading").text
    puts "#{@title}"
    line
  end

  def print_summary
    paragraphs = @page.css("p")
    @summary = paragraphs.find { |para| para.text.length > 50 }.text
    puts @summary
    line
  end

  def print_subheadings
    bad_headings = ["Contents", "See also", "References", "Bibliography", "External links", "Navigation menu", "Notes"]
    headings = @page.css(".mw-headline")
    index = 1
    @sorted_headings = []
    puts "Topics:"
    headings.each do |heading|
      if bad_headings.any? { |bad| bad == heading.text }
        next
      end
      @sorted_headings << heading.text
      puts "#{index}. #{heading.text}"
      index += 1
    end
  end

  def create_paragraphs
    h = Hash.new
    heading_array = []

    @page.css(".mw-parser-output").children.map do |thing|
      if thing.name == "h2"
        heading_array << thing.text.strip
      else
        if !heading_array.empty?
          h[heading_array.last] ||= []
          h[heading_array.last] << thing.text
        end
      end
    end
  end
end
