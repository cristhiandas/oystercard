require 'oystercard'

describe Oystercard do
  it 'Initialise a new Oystercard with a balance of 0' do
    expect(subject.balance).to eq 0
  end
  describe '#top_up' do
    it 'tops up oyster card balance with £20' do
      subject.top_up(20)
      expect(subject.balance).to eq(20)
    end
    it 'Will not allow a card\'s balance to exceed the given maximum' do
      expect { subject.top_up(100) }.to raise_error('Sorry, the balance on'\
      " your Oyster card can not exceed #{subject.maximum_amount}.")
    end
  end
  describe '#deduct' do
    it "Deducts the a given amount from the card's balance" do
      expect(subject.deduct(20)).to eq -20
    end
  end
  describe '#in_journey?' do
    it 'oystercard is not in journey by default' do
      expect(subject.in_journey).to eq(false)
    end
  end
  describe '#touch_in' do
    it "Updates a card's @in_journey attribute to be true" do
      expect(subject.touch_in).to eq(true)
    end
  end
  describe '#touch_out' do
    it 'updates card\'s @in_journey attribute to be false' do
      subject.touch_in
      expect(subject.touch_out).to eq(false)
    end
    it "Raises error if the card has insufficent funds for a single journey" do
      expect { subject.touch_out }.to raise_error('Insufficient funds available. Please top up your card.')
    end
  end
end
