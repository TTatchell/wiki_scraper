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
    input = gets.strip
    if input == "y"
      true
    elsif input == "n"
      false
    else
      puts "Invalid input. Try Again"
      read_more
    end
  end

  def get_subheading_choice
    puts "Alright, make a selection: (0-#{@article.subheading_count + 1})"
    input = gets.strip.to_i
  end

  def return_to_menu
    puts "Press enter to return"
    gets
  end

  def exit_message
    blank
    line
    line
    puts "             Have a great day!"
    line
    line
    sleep(3)
  end

  def program_loop
    while @running
      blank
      @article.print_trio
      input = get_subheading_choice
      if input == @article.subheading_count + 1
        exit_message
        break
      end
      @article.print_topic(input)
      return_to_menu
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
    @running = true
    program_loop
  end
end
