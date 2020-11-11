class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if sulfuras?(item)
        item.quality
      elsif generic?(item)
        if item.quality > 0
          item.quality -= 1
        end
      else
        if item.quality < 50
          item.quality += 1
          if backstage_pass?(item)
            if item.sell_in < 11 && item.quality < 50
              item.quality += 1
            end
            if item.sell_in < 6 && item.quality < 50
              item.quality += 1
            end
          end
        end
      end
      if !sulfuras?(item)
        item.sell_in -= 1
      end
      if item.sell_in < 0
        if !aged_brie?(item)
          if !backstage_pass?(item)
            if item.quality > 0 && !sulfuras?(item)
              item.quality -= 1
            end
          else
            item.quality = 0
          end
        else
          if item.quality < 50
            item.quality += 1
          end
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
