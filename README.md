# Transilien Microservices made EASY!

Ruby wrapper for transilien_microservices ruby gem: make data easy to fetch.

The original gem: http://rubygems.org/gems/transilien_microservices

## Installation

Gem developped with ruby 2.0.0, should work with ruby 1.9.3

Add this line to your application's Gemfile:

    gem 'easy_transilien'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_transilien

## Usage

- What do we want?

- Train times!

- How do we want them?

- Easily!

```ruby
# Transposition from TransilienMicroservices usage examples:
require 'easy_transilien'

stations = EasyTransilien::Station.find
val_arg_station = EasyTransilien::Station.find('val d\'argenteuil')
# => "#<EasyTransilien::Station>"
val_arg_station = 

trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare')

# Maybe you want it at a certain time?
now = Time.new
trips = EasyTransilien::Trop.find('val d\'arg', 'paris sain', Time.local(now.year, now.month, now.day, 14, 42)) # you can search by fragment, exact match not required.

```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

NOTA: you're a beginner gem dev? This command may help you: 

    pry -Ilib -rtransilien_easy_microservices 

(you can replace pry with irb if you're not a good person…)
