class WikiScraper::CLI
  def blank
    puts "\e[2J\e[f"
  end

  def line
    puts "----------------------------------------------"
  end

  def time #This is for testing to speed things up
    1
  end

  def loading
    3.times do |index|
      puts "Loading#{"." * index}"
      blank
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
    blank
    loading
    page = WikiScraper::Scraper.new.get_page
    WikiScraper::WikiDisplay.new.first(page)
  end
end
