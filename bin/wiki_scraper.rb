#This will be the executable that will requuire environment and will call /lib/wiki_scraper/CLI

require_relative "../config/environment.rb"

WikiScraper::CLI.new.cli
