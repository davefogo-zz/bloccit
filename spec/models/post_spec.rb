require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:name) {RandomData.random_sentence}
  let(:description) {RandomData.random_paragraph}
  let(:title) {RandomData.random_sentence}
  let(:body) {RandomData.random_paragraph}
  let(:topic) {Topic.create!(name: name, description: description)}
  let(:user) {User.create!(name: "David Forero", email: "david@email.com", password: "password")}
  let(:post) {topic.posts.create!(title: title, body: body, user: user)}

  it {is_expected.to have_many(:comments)}
  it {is_expected.to have_many(:labelings)}
  it {is_expected.to have_many(:labels).through(:labelings)}
  it {is_expected.to have_many(:votes)}
  it {is_expected.to have_many(:favorites)}

  it {is_expected.to belong_to(:topic)}
  it {is_expected.to belong_to(:user)}

  it {is_expected.to validate_presence_of(:title)}
  it {is_expected.to validate_presence_of(:body)}
  it {is_expected.to validate_presence_of(:topic)}
  it {is_expected.to validate_presence_of(:user)}

  it {is_expected.to validate_length_of(:title).is_at_least(5)}
  it {is_expected.to validate_length_of(:body).is_at_least(20)}

  describe "attributes" do
    it "has title, body and user attributes" do
      expect(post).to have_attributes(title: title, body: body, user: user)
    end
  end

  describe "voting" do
    before do
      2.times { post.votes.create!(value: 1)}
      3.times { post.votes.create!(value: -1)}
      @up_votes = post.votes.where(value: 1).count
      @down_votes = post.votes.where(value: -1).count
    end

    describe "#up_votes" do
      it "count the number of votes with value = 1" do
        expect(post.up_votes).to eq(@up_votes)
      end
    end

    describe "#down_votes" do
      it "counts the number of votes with value = -1" do
        expect(post.down_votes).to eq(@down_votes)
      end
    end

    describe "#update_rank" do
      it "calculates the correct rank" do
        post.update_rank
        expect(post.rank).to eq(post.points + (post.created_at - Time.new(1970,1,1))/1.day.seconds)
      end

      it "updates the rank when an up vote is created" do
        old_rank = post.rank
        post.votes.create!(value: 1)
        expect(post.rank).to eq(old_rank + 1)
      end

      it "update the rank when a down vote is created" do
        old_rank = post.rank
        post.votes.create!(value: - 1)
        expect(post.rank).to eq(old_rank - 1)
      end
    end
  end

  describe "#after_create callback" do
    before do
      @new_post = Post.new(title: RandomData.random_sentence, body: RandomData.random_paragraph, topic: topic, user: user)
    end
    it "triggers favorite_post callback on save" do
      expect(@new_post).to receive(:favorite_post).at_least(:once)
      @new_post.save!
    end

    it "favorites the post for the user" do
      expect(@new_post.favorites).not_to be_nil
      @new_post.save!
    end

    it "sends an email to the user that the post has been favorited." do
      expect(FavoriteMailer).to receive(:new_post).with(user, @new_post).and_return(double(deliver_now: true))
      @new_post.save!
    end
  end

end
