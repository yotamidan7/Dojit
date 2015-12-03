require 'rails_helper'

describe Vote do
  describe "validations" do
    describe "value validation" do

      it "only allows -1 or 1 as values" do
        # value = -1 -> true
        vote = Vote.new(value: -1)
        expect(vote.valid?).to eq(true)

        # value = 1 --> true
        vote.value = 1
        expect(vote.valid?).to eq(true)    

        # value = 2 --> false
        vote.value = 2
        expect(vote.valid?).to eq(false)
      end
    end
  end
end