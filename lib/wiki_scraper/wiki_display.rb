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
    @h = Hash.new
    @heading_array = []

    @page.css(".mw-parser-output").children.map do |thing|
      if thing.name == "h2"
        @heading_array << thing.text.strip
      else
        if !@heading_array.empty?
          @h[@heading_array.last] ||= []
          @h[@heading_array.last] << thing.text
        end
      end
    end
    clean_headings_and_paragraphs
  end

  def clean_headings_and_paragraphs
    bad_headings = ["Contents", "See also", "References", "Bibliography", "External links", "Navigation menu", "Notes"]
    @heading_array.each_with_index do |heading|
      if bad_headings.any? { |bad| bad == heading }
        @heading_array = @heading_array - [heading]
        @h.delete(heading.to_s)
      end
    end
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
    line
    @heading_array.each_with_index do |heading, index|
      puts "#{index}. #{heading}"
    end
  end
end
