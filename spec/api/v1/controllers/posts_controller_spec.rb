require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:my_post) { create(:post) }

  context "unauthenticated user" do
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, id: my_post.id
      end
    end
  end

  context "unauthorized user" do
    describe "GET index" do
      it "returns http succes" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, id: my_post.id
        expect(response).to have_http_status(:success)
      end
    end
  end

end
