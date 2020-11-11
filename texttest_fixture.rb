#!/usr/bin/ruby -w

require File.join(File.dirname(__FILE__), 'lib/gilded_rose')

def item_klass(name, sell_in, quality)
  Item.new(name, sell_in, quality)
end

def initialize_item_as(klass, name, sell_in, quality)
  item = item_klass(name, sell_in, quality)
  klass.new(item.name, item.sell_in, item.quality)
end

puts "OMGHAI!"
items = [
  initialize_item_as(Generic, "+5 Dexterity Vest", 10, 20),
  initialize_item_as(AgedBrie, "Aged Brie", 2, 0),
  initialize_item_as(Generic, "Elixir of the Mongoose", 5, 7),
  initialize_item_as(Sulfuras, "Sulfuras, Hand of Ragnaros", 0, 80),
  initialize_item_as(Sulfuras, "Sulfuras, Hand of Ragnaros", 1, 80),
  initialize_item_as(ConcertPass, "Backstage passes to a TAFKAL80ETC concert", 15, 20),
  initialize_item_as(ConcertPass, "Backstage passes to a TAFKAL80ETC concert", 10, 49),
  initialize_item_as(ConcertPass, "Backstage passes to a TAFKAL80ETC concert", 5, 49),
  # This Conjured item does not work properly yet
  # initialize_item_as(, { name: "Conjured Mana Cake", sell_in: 3, quality: 6), # <-- :O
]

days = 2
if ARGV.size > 0
  days = ARGV[0].to_i + 1
end

gilded_rose = GildedRose.new items
(0...days).each do |day|
  puts "-------- day #{day} --------"
  puts "name, sellIn, quality"
  items.each do |item|
    puts item_klass(item.name, item.sell_in, item.quality)
  end
  puts ""
  gilded_rose.update_quality
end
