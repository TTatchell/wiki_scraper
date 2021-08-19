class WikiScraper::WikiDisplay
  def line
    puts "----------------------------------------------"
  end

  def blank
    puts "\e[2J\e[f"
  end

  def initialize(page)
    blank
    @page = page
    @title = @page.css("#firstHeading").text
    get_summary
    create_headings_and_paragraphs
    print_title
    print_summary
    print_subheadings
  end

  def get_summary
    paragraphs = @page.css("p")
    @summary = paragraphs.find { |para| para.text.length > 50 }.text
  end

  def create_headings_and_paragraphs
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

  def clean_headings_and_paragraphs
    bad_headings = ["Contents", "See also", "References", "Bibliography", "External links", "Navigation menu", "Notes"]
  end

  def print_title
    puts "#{@title}"
    line
  end

  def print_summary
    puts @summary
    line
  end

  def print_subheadings
    puts "Topics:"
  end
end
