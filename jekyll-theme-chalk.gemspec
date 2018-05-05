# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "jekyll-theme-chalk"
  spec.version       = "0.1.1"
  spec.authors       = ["Nielsen Ramon", "Pavel Tsurbeleu"]
  spec.email         = ["hello@nielsenramon.com", "pavel.tsurbeleu@me.com"]

  spec.summary       = %q{Chalk is a high quality, completely customizable, performant and 100% free blog template for Jekyll by Nielsen Ramon.}
  spec.homepage      = "http://chalk.nielsenramon.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select {
    |f| f.match(%r{^(_assets|_layouts|_includes|LICENSE|README|404.html|about.html|index.html|favicon.ico|feed.xml|robots.txt)}i)
  }

  spec.add_runtime_dependency "jekyll", ">= 3.0", "~> 3.1"
  spec.add_runtime_dependency "jekyll-assets", "2.2.8"
  spec.add_runtime_dependency "jekyll-paginate", "1.1.0"
  spec.add_runtime_dependency "jekyll-sitemap", "1.1.1"
  spec.add_runtime_dependency "jekyll-theme-pages", "0.1.0"
  spec.add_runtime_dependency "jekyll-theme-assets", "0.1.2"
  spec.add_runtime_dependency "jemoji", "0.8.0"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "jekyll-theme-specs", "0.1.2"
  spec.add_development_dependency "rake", "~> 10.0"
end
