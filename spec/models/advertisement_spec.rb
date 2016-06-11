require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:ad) {Advertisement.create!(title: "New iPhone", body: "The new iPhone 7 has arrived", price: 649)}

  describe "attributes" do
    it "has a title, body and price attributes" do
      expect(ad).to have_attributes(title: "New iPhone", body: "The new iPhone 7 has arrived", price: 649)
    end
  end
end
