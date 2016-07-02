require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_post) { create(:post) }
  let(:my_comment) { Comment.create!(body: RandomData.random_paragraph, post: my_post, user: my_user) }

  context "unauthenticated user" do
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, id: my_comment.id
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "unauthorized user" do
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, id: my_comment.id
        expect(response).to have_http_status(:success)
      end
    end
  end

end
