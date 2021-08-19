class WikiScraper::CLI
  def blank
    puts "\e[2J\e[f"
  end

  def line
    puts "----------------------------------------------"
  end

  def time #This is for testing to speed things up
    0.2
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
      true
    elsif input[0] == "n"
      false
    else
      puts "Invalid input. Try Again"
      read_more
    end
  end

  def get_subheading_choice
    puts "Alright, pick a topic: (0-#{@article.subheading_count})"
    input = gets
  end

  def exit_message
    puts "Have a great day!"
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
    if read_more
      get_subheading_choice
    else
      exit_message
    end
  end
end
