require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:name) {RandomData.random_sentence}
  let(:description) {RandomData.random_paragraph}
  let(:title) {RandomData.random_sentence}
  let(:body) {RandomData.random_paragraph}
  
  let(:topic) {Topic.create!(name: name, description: description)}
  let(:post) {topic.posts.create!(title: title, body: body)}
  let(:comment) {Comment.create!(body: "Comment Body", post: post)}

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "Comment Body")
    end
  end
end
