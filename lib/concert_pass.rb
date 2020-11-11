class ConcertPass
  attr_accessor :sell_in, :quality

  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end

  def update
    self.sell_in -= 1
    self.quality += 1 unless quality >= 50
    if sell_in < 10
      self.quality += 1 unless quality >= 50
    end
    if sell_in < 5
      self.quality += 1 unless quality >= 50
    end
    if sell_in < 0
      self.quality = 0
    end
  end
end
