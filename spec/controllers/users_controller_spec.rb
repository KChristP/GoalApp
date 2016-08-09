require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders the new user form" do
      get :new
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "fails to validate the username and passowrd" do
        post :create, user: {username: "bob", password: "bob"}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "creates a new user and redirects correctly" do
        post :create, user: {username: "kdog", password: "password"}
        expect(response).to render_template(:new)
      end
    end

  end


end
