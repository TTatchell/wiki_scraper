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
  end

  def get_summary
    paragraphs = @page.css("p")
    if paragraphs.text.strip == "Other reasons this message may be displayed:"
      @summary = "Wikipedia does not have an article with this exact name."
    else
      @summary = paragraphs.find { |para| para.text.length > 50 }.text.gsub(/\[\d\d?\d?\]/, "")
    end
  end

  def create_headings_and_paragraphs
    @h = Hash.new
    @heading_array = []

    @page.css(".mw-parser-output").children.map do |thing|
      if thing.name == "h2"
        @heading_array << thing.text.gsub("[edit]", "").strip
      else
        if !@heading_array.empty? && thing.name == "p"
          @h[@heading_array.last] ||= []
          @h[@heading_array.last] << thing.text.gsub(/\[\d\d?\d?\]/, "")
          @h[@heading_array.last] << "\n"
        end
      end
    end
    clean_headings_and_paragraphs
  end

  def clean_headings_and_paragraphs
    bad_headings = ["Contents", "See also", "References", "Bibliography", "External links", "Navigation menu", "Notes", "Further reading", "Cited sources"]
    @heading_array.each_with_index do |heading|
      if bad_headings.any? { |bad| bad == heading } || @h[heading].nil?
        @heading_array = @heading_array - [heading]
        @h.delete(heading.to_s)
      end
    end
  end

  def print_trio #Prints title, summary, subheadings
    print_title
    print_summary
    print_subheadings
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
    if @heading_array.length > 0
      index = 0
      puts "Topics:"
      line
      @heading_array.each do |heading|
        puts "#{index + 1}. #{heading}"
        index += 1
      end
      puts "\n"
      puts "#{index + 1}. To make another search"
      puts "#{index + 2}. To exit"
      line
    else
      puts "There are no topics to display."
      puts "Type '1' to search again or '2' to exit."
      line
    end
  end

  def print_topic(number)
    blank
    line
    line
    puts "Topic #{number + 1}/#{subheading_count}: #{@heading_array[number]}"
    line
    line
    puts @h["#{@heading_array[number]}"]
    line
  end

  def subheading_count
    @heading_array.count
  end
end
