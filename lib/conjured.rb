class Conjured
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def update
    self.sell_in -= 1
    self.quality -= 2 if quality > 0
  end
end
