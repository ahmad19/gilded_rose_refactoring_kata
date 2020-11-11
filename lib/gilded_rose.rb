Dir[File.join(__dir__, '*.rb')].each { |file| require file }

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if sulfuras?(item)
        product = Sulfuras.new(item.sell_in, item.quality)
        product.update
        update_item(item, product)
      elsif aged_brie?(item)
        product = AgedBrie.new(item.sell_in, item.quality)
        product.update
        update_item(item, product)
      elsif backstage_pass?(item)
        product = ConcertPass.new(item.sell_in, item.quality)
        product.update
        update_item(item, product)
      elsif generic?(item)
        product = Generic.new(item.sell_in, item.quality)
        product.update
        update_item(item, product)
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

  def update_item(item, product)
    item.sell_in = product.sell_in
    item.quality = product.quality
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
