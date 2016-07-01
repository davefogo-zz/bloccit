require 'rails_helper'
include SessionsHelper

RSpec.describe VotesController, type: :controller do
  let(:my_user) {create(:user)}
  let(:other_user) {create(:user)}
  let(:my_topic) {create(:topic)}
  let(:user_post) {create(:post, topic: my_topic, user: other_user)}
  let(:my_vote) {Vote.create!(value: 1)}

  context "guest" do
    describe "POST up_vote" do
      it "redirects the user to the sign in view" do
        post :up_vote, format: :js, post_id: user_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST down_vote" do
      it "redirects the user to the sign in view" do
        post :down_vote, format: :js, post_id: user_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "signed in user" do
    before do
      create_session(my_user)
      request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
    end

    describe "POST up_vote"  do
      it "increases the number of post votes by 1 with a users first vote" do
        votes = user_post.votes.count
        post :up_vote, format: :js, post_id: user_post.id
        expect(user_post.votes.count).to eq(votes + 1)
      end

      it "doesn't increase the post's vote count with a second vote" do
        post :up_vote, format: :js, post_id: user_post.id
        votes = user_post.votes.count
        expect(user_post.votes.count).to eq(votes)
      end

      it "increases the sum of post votes by one" do
        points = user_post.points
        post :up_vote, format: :js, post_id: user_post.id
        expect(user_post.points).to eq(points + 1)
      end

      it "returns http success" do
        post :up_vote, format: :js, post_id: user_post.id
        expect(response).to have_http_status(:success)
      end

    end

    describe "POST down_vote" do
      it "increases the number of votes with a users first vote" do
        votes = user_post.votes.count
        post :down_vote, format: :js, post_id: user_post.id
        expect(user_post.votes.count).to eq(votes + 1)
      end

      it "doesn't increase the number of votes with a users second vote" do
        post :down_vote, format: :js, post_id: user_post.id
        votes = user_post.votes.count
        post :down_vote, format: :js, post_id: user_post.id
        expect(user_post.votes.count).to eq(votes)
      end

      it "decreases the sum of post votes by 1" do
        points = user_post.points
        post :down_vote, format: :js, post_id: user_post.id
        expect(user_post.points).to eq(points - 1)
      end

      it "returns http success" do
        post :down_vote, format: :js, post_id: user_post.id
        expect(response).to have_http_status(:success)
      end
    end
  end

end
