class WikiScraper::CLI
  def blank
    puts "\e[2J\e[f"
  end

  def line
    puts "----------------------------------------------"
  end

  def time #This is for testing to speed things up
    2.5
  end

  def welcome
    blank
    line
    puts "           Welcome To WikiScraper! " #Be cool to add the version here
    line
    sleep(1.5)
    blank
    line
    puts "Let's search for an article:"
    line
    sleep(1.5)
  end

  def loading
    3.times do |index|
      blank
      puts "Loading#{"." * (index + 1)}"
      sleep(0.5)
    end
  end

  def page_search
    puts "Enter a term and we will attempt to retrieve the page"
    gets
  end

  def get_subheading_choice
    puts "Make a selection: (1-#{@article.subheading_count + 2})"
    input = gets.strip.to_i - 1
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
    sleep(time)
  end

  def program_loop
    while @running
      blank
      @article.print_trio
      input = get_subheading_choice
      if input == @article.subheading_count + 1
        exit_message
        @running = false
        @search_again = false
      elsif input == @article.subheading_count
        @running = false
        @search_again = true
      elsif input > @article.subheading_count + 1 or input < 0
        puts "Invalid Input. Try Again"
        sleep(1)
      else
        @article.print_topic(input)
        return_to_menu
      end
    end
  end

  def cli
    welcome
    search_term = page_search.strip.gsub(" ", "_")
    loading
    page = WikiScraper::Scraper.new.get_page(search_term)
    @article = WikiScraper::WikiDisplay.new(page)
    puts
    @running = true
    program_loop
    if @search_again
      cli
    end
  end
end
