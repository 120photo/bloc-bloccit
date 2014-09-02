describe Vote do
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        expect( Vote.new(value: 2) ).to eq(false) # your expectations here
      end
    end
  end
end
