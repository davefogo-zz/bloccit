require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {User.create!(name: "David Forero", email: "david@email.com", password: "password")}

  #Shoulda tests for name
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to validate_length_of(:name).is_at_least(1)}

  #Shoulda tests for email
  it{is_expected.to validate_presence_of(:email)}
  it{is_expected.to validate_uniqueness_of(:email)}
  it{is_expected.to validate_length_of(:email).is_at_least(3)}
  it{is_expected.to allow_value("david@email.com").for(:email)}

  #Shoulda tests for password
  it{is_expected.to validate_presence_of(:password)}
  it{is_expected.to have_secure_password}
  it{is_expected.to validate_length_of(:password).is_at_least(6)}

  describe "attributes" do
    it "should have name, email and password attributes" do
      expect(user).to have_attributes(name: "David Forero", email: "david@email.com", password: "password")
    end
  end

  describe "invalid user" do
    let(:user_with_invalid_name) {User.new(name: "", email: "david@email.com")}
    let(:user_with_invalid_email) {User.new(name: "David Forero", email: "")}

    it "is an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "is an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  describe "#format_name" do
    let(:new_user) {User.create!(name: "david forero", email: "david@email.com", password: "password")}

    it "formats name correctly" do
      expect(new_user.name).to eq("David Forero")
    end
  end
end
