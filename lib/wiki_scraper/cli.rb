class WikiScraper
  def initialize
    cli
  end

  def blank
    puts "\e[2J\e[f"
  end

  def line
    puts "##############################################"
  end

  def cli
    blank
    line
    puts "           Welcome To WikiScraper!            "
    line
    sleep(3)
    blank
    line
    puts "Let's check out an article:"
    line
    sleep(3)
  end
end

WikiScraper.new
