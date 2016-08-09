require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  describe "GET #new" do
    it "render new goal form" do
      get :new
      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #create" do

    before(:each) do
      bobby = User.create(username: "bobby", password: "password")
    end

    context "with valid params" do
      it "add a new goal to logged in user" do
        post :create, goal: {title: "go to space", body: "get spaceship, leave atmosphere", private: false, user_id: User.last.id}
        expect(response).to redirect_to goals_url
      end
    end

    context "with invalid params" do
      it "should show errors and render new goal form again" do
        post :create, goal: {title: "", body: "get spaceship, leave atmosphere", private: false, user_id: User.last.id}
        expect(flash[:errors]).to be_present
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #index" do
    context "when logged in" do
      it "should display a users' goals" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "when logged out" do
      it "redirect you to login page" do
        get :index
        expect(response).to_not render_template(:index)
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "DELETE #destroy" do
    it "redirects to users goal index page" do
      delete :destroy
      expect(response).to redirect_to(goals_url)
    end
  end

end
