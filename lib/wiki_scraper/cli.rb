class WikiScraper::CLI
  def blank
    puts "\e[2J\e[f"
  end

  def line
    puts "##############################################"
  end

  def time #This is for testing to speed things up
    0.5
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
    WikiScraper::Scraper.new.get_page()
  end
end
