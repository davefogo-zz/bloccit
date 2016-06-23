require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:topic) {Topic.create!(name: name, description: description)}
  let(:user) {User.create!(name: "David Forero", email: "david@email.com", password: "password")}
  let(:post) {topic.posts.create!(title: title, body: body, user: user)}
  let(:comment) {Comment.create!(body: "Comment Body", post: post, user: user)}

  it {is_expected.to belong_to(:post)}
  it {is_expected.to belong_to(:user)}

  it {is_expected.to validate_presence_of(:body)}
  it {is_expected.to validate_length_of(:body).is_at_least(5)}

  let(:name) {RandomData.random_sentence}
  let(:description) {RandomData.random_paragraph}
  let(:title) {RandomData.random_sentence}
  let(:body) {RandomData.random_paragraph}



  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "Comment Body")
    end
  end
end
