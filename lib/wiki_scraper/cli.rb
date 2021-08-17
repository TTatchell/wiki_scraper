class WikiScraper::CLI
  def blank
    puts "\e[2J\e[f"
  end

  def line
    puts "----------------------------------------------"
  end

  def time #This is for testing to speed things up
    2
  end

  def loading
    3.times do |index|
      blank
      puts "Loading#{"." * (index + 1)}"
      sleep(time)
    end
  end

  def read_more
    puts "Would you like to read more? (Y/N)"
    input = gets
    if input[0] == "y"
      puts "yes"
      true
    elsif input[0] == "n"
      puts "no"
      false
    else
      puts "Invalid input. Try Again"
      sleep(2)
      blank
      @article.print_subheadings
      read_more
    end
  end

  def cli
    blank
    line
    puts "           Welcome To WikiScraper!            "
    line
    sleep(time)
    blank
    line
    puts "Let's check out an article:"
    line
    sleep(time)
    loading
    page = WikiScraper::Scraper.new.get_page
    @article = WikiScraper::WikiDisplay.new(page)
    puts
    read_more
  end
end
