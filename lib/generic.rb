class Generic
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def update
    self.sell_in -= 1
    self.quality -= 1 if quality > 0
    if sell_in < 0
      self.quality -= 1 if quality > 0
    end
  end
end
