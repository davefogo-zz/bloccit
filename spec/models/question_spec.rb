require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question){Question.create!(title: "New question title", body: "New question body")}

  describe "attributes" do
    it "has title and body attributes" do
      expect(question).to have_attributes(title: "New question title", body: "New question body")
    end
  end
end
