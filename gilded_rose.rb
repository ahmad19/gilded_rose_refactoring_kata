class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if sulfuras?(item)
      if aged_brie?(item)
        item.sell_in -= 1
        item.quality += 1 unless item.quality >= 50
      elsif backstage_pass?(item)
        item.sell_in -= 1
        item.quality += 1 unless item.quality >= 50
        if item.sell_in < 10
          item.quality += 1 unless item.quality >= 50
        end
        if item.sell_in < 5
          item.quality += 1 unless item.quality >= 50
        end
        if item.sell_in < 0
          item.quality = 0
        end
      elsif generic?(item)
        item.sell_in -= 1
        item.quality -= 1 if item.quality > 0
        if item.sell_in < 0
          item.quality -= 1 if item.quality > 0
        end
      end
    end
  end

  private

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def backstage_pass?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def generic?(item)
    !(sulfuras?(item) || backstage_pass?(item) || aged_brie?(item))
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
