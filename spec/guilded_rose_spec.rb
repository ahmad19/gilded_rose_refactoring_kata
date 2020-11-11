require File.join(File.dirname(__FILE__), '../lib/gilded_rose')

describe GildedRose do
  context 'generic item' do
    it 'degrades the quality and sell_in' do
      item = Item.new('foo', 15, 40)
      items = [Generic.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(39)
      expect(items[0].sell_in).to eq(14)
    end

    it 'does not degrades the quality less than 0' do
      item = Item.new('foo', 1, 1)
      items = [Generic.new(item.name, item.sell_in, item.quality)]
      3.times { GildedRose.new(items).update_quality }
      expect(items[0].quality).to eq(0)
    end

    it 'degrades the quality twice as fast when sell by date has passed' do
      item = Item.new('foo', 0, 10)
      items = [Generic.new(item.name, item.sell_in, item.quality)]
      3.times { GildedRose.new(items).update_quality }
      expect(items[0].quality).to eq(4)
    end
  end

  context 'aged brie' do
    it 'increases the quality as older it gets' do
      item = Item.new('Aged Brie', 15, 40)
      items = [AgedBrie.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(41)
      expect(items[0].sell_in).to eq(14)
    end

    it 'does not increases the quality more than 50' do
      item = Item.new('Aged Brie', 4, 48)
      items = [AgedBrie.new(item.name, item.sell_in, item.quality)]
      4.times { GildedRose.new(items).update_quality }
      expect(items[0].quality).to eq(50)
      expect(items[0].sell_in).to eq(0)
    end
  end

  context 'concert pass' do
    it 'increases the quality as older it gets' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 40)
      items = [ConcertPass.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(41)
      expect(items[0].sell_in).to eq(14)
    end

    it 'increases the quality twice when there are 10 days or less' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 40)
      items = [ConcertPass.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(42)
      expect(items[0].sell_in).to eq(9)
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 42)
      items = [ConcertPass.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(44)
      expect(items[0].sell_in).to eq(8)
    end

    it 'increases the quality thrice when there are 5 days or less' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 40)
      items = [ConcertPass.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(43)
      expect(items[0].sell_in).to eq(4)
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 4, 43)
      items = [ConcertPass.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(46)
      expect(items[0].sell_in).to eq(3)
    end

    it 'degrades the quality to zero after the sell in becomes zero' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 1, 40)
      items = [ConcertPass.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(43)
      expect(items[0].sell_in).to eq(0)
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 43)
      items = [ConcertPass.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(0)
      expect(items[0].sell_in).to eq(-1)
    end

    it 'does not do anything if quality is equals to 50' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 2, 48)
      items = [ConcertPass.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(50)
      expect(items[0].sell_in).to eq(1)
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 1, 50)
      items = [ConcertPass.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(50)
      expect(items[0].sell_in).to eq(0)
    end
  end

  context 'sulfuras' do
    it 'does not change the quality' do
      item = Item.new("Sulfuras, Hand of Ragnaros", 2, 10)
      items = [Sulfuras.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(2)
      expect(items[0].quality).to eq(10)
    end
  end

  context 'conjured' do
    it 'degrades the quality twice as fast as normal times' do
      item = Item.new('Conjured Item', 2, 6)
      items = [Conjured.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(4)
      expect(items[0].sell_in).to eq(1)
      item = Item.new('Conjured Item', 1, 4)
      items = [Conjured.new(item.name, item.sell_in, item.quality)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(2)
      expect(items[0].sell_in).to eq(0)
    end
  end
end
