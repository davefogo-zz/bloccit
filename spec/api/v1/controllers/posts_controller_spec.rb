require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:my_post) {create(:post)}

    context "unauthenticated and unauthorized users" do
      before do
        @new_post = build(:post)
      end

      describe "PUT update" do
        before {put :update, id: my_post.id, post: {title: @new_post.title, body: @new_post.body, user: @new_post.user, topic: @new_post.topic}}

        it "returns http success" do
          expect(response).to have_http_status(:success)
        end

        it "returns json content type" do
          expect(response.content_type).to eq 'application/json'
        end

        it "updates the post with the correct attributes" do
          updated_post = Post.find(my_post.id)
          expect(response.body).to eq(updated_post.to_json)
        end
      end

      describe "POST create" do
        before { post :create, post: {title: @new_post.title, body: @new_post.body, user: @new_post.user, topic: @new_post.topic}}

        it "returns http success" do
          expect(response).to have_http_status(:success)
        end

        it "returns json content type" do
          exepct(response.content_type).to eq 'application/json'
        end

        it "creates a post with the correct attributes" do
          hashed_json = JSON.parse(response.body)
          expect(hashed_json["name"]).to eq(@new_post.title)
          exepct(hashed_json["body"]).to eq(@new_post.body)
          expect(hashed_json["user"]).to eq(@new_post.user)
          expect(hashed_json["topic"]).to eq(@new_post.topic)
        end
      end

      describe "DELETE destroy" do
        before  { delete :destroy, id: my_post.id}

        it "returns http success" do
          expect(response).to have_http_status(:success)
        end

        it "returns json content type" do
          expect(response.content_type).to eq "application/json"
        end

        it "returns the correct json success message" do
          expect(response.body).to eq({message: "Posts destroyed.", status: 200}.to_json)
        end

        it "deletes the post" do
          expect{Post.find(my_post.id)}.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end
    end

end
