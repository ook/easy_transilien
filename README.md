# Transilien Microservices made EASY!

Ruby wrapper for transilien_microservices ruby gem: make data easy to fetch.

The original gem: http://rubygems.org/gems/transilien_microservices

[![Build Status](https://travis-ci.org/ook/easy_transilien.svg?branch=master)](https://travis-ci.org/ook/easy_transilien)

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
val_arg_station = EasyTransilien::Station.find('val d\'argenteuil') # Access by name
# => [#<EasyTransilien::Station:0x007fd23dc9b398 @access_time=2013-11-19 13:03:07 +0100, @external_code="DUA8738179", @name="VAL D'ARGENTEUIL">]
val_arg_station = EasyTransilien::Station.find('val d\'arg') # Access by fragment
# => [#<EasyTransilien::Station:0x007fd23dcab0f8 @access_time=2013-11-19 13:03:07 +0100, @external_code="DUA8738179", @name="VAL D'ARGENTEUIL">]
val_arg_station = EasyTransilien::Station.find('DUA8738179') # Access by external_code
# => [#<EasyTransilien::Station:0x007fd23dce0fb0 @access_time=2013-11-19 13:03:07 +0100, @external_code="DUA8738179", @name="VAL D'ARGENTEUIL">]
# Note via @access_time that the Stations are cached

trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare')
# => [#<EasyTransilien::Trip …>, #<EasyTransilien::Trip …>…]
# Note: by default trips are fetch from Time.new to Time.new + 1.hour

# Maybe you want it at a certain time?
now = Time.new
trips = EasyTransilien::Trip.find('val d\'arg', 'paris sain', Time.local(now.year, now.month, now.day, 14, 42)) # you can search by fragment, exact match not required.
# => [<EasyTransilien::Trip:70166657121040 @access_time=2013-11-19 13:18:10 +0100 @mission=PACA @from_stop=VAL D'ARGENTEUIL@15:40, @to_stop=PARIS SAINT-LAZARE@15:55>, <EasyTransilien::Trip:70166657847860 @access_time=2013-11-19 13:18:10 +0100 @mission=PUCA @from_stop=VAL D'ARGENTEUIL@15:55, @to_stop=PARIS SAINT-LAZARE@16:10>, <EasyTransilien::Trip:70166663321140 @access_time=2013-11-19 13:18:10 +0100 @mission=POCI @from_stop=VAL D'ARGENTEUIL@16:09, @to_stop=PARIS SAINT-LAZARE@16:24>, <EasyTransilien::Trip:70166662894960 @access_time=2013-11-19 13:18:10 +0100 @mission=PUCA @from_stop=VAL D'ARGENTEUIL@16:25, @to_stop=PARIS SAINT-LAZARE@16:40>]
# End boundary not given, so it's "from"+1h
```

Easy isn't it?

But you know, they are called Lines.

```ruby
EasyTransilien::Line.find('J')
# => [<EasyTransilien... >]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

NOTA: you're a beginner gem dev? This command may help you: 

    pry -Ilib -reasy_transilien 

(you can replace pry with irb if you're not a good person…)
