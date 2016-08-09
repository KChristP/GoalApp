require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:good_user) { User.create(username: "good_user", password: "goodperson")}

  context "with invalid params" do
    it "not log in user, redirect to login" do
      post :create, user: { username: "bad_user", password: "badperson"}
      expect(response).to render_template("new")
      expect(flash[:errors]).to be_present
    end
  end

  context "with valid params" do
    it "log in user, redirec to goals" do
      post :create, user: {username: "good_user", password: "goodperson"}
      expect(response).to redirect_to(new_user_url)
    end
  end

end
