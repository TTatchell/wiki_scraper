require_relative "lib/wiki_scraper/version"

Gem::Specification.new do |spec|
  spec.name = "wiki_scraper"
  spec.version = WikiScraper::VERSION
  spec.authors = ["TTatchell"]
  spec.email = ["tim.tatchell24@gmail.com"]

  spec.summary = "A simple CLI built using Ruby that scrapes information off Wikipedia and displays to the user in an easy to read format."
  spec.homepage = "https://github.com/TTatchell/wiki_scraper"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/TTatchell/wiki_scraper"
  spec.metadata["changelog_uri"] = "https://github.com/TTatchell/wiki_scraper/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "config"]

  spec.add_dependency "Nokogiri", "~> 1.12.3"
  spec.add_dependency "HTTParty", "~> 0.18.1"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
