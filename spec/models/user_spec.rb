require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    User.create(username: "bobby", password: "password")
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_presence_of(:session_token)}
    it {should validate_uniqueness_of(:username)}
  end

  describe "associations" do
    it {should have_many(:goals)}
  end

end
