# frozen_string_literal: true

require_relative "lib/bella/version"

Gem::Specification.new do |spec|
  spec.name = "bella"
  spec.version = Bella::VERSION
  spec.authors = ["HolyWalley"]
  spec.email = ["yakau@hey.com"]

  spec.summary = "Latinizer for Belarusian language."
  spec.homepage = "https://github.com/HolyWalley/bella"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/HolyWalley/bella"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
