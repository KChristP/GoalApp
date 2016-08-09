require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content("sign up")
  end

  feature "signing up a user" do
      visit new_user_url
      fill_in 'username', with: "bobby"
      fill_in 'password', with: "password"
      click_on 'Sign up'
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content("bobby")
    end

  end

end

feature "logging in" do
  before(:each) do
    User.create(username: "bobby", password: "password")
    visit new_session_url
    fill_in 'username', with: "bobby"
    fill_in 'password', with: "password"
    click_on 'Sign in'
  end

  scenario "shows username on the homepage after login" do
    expect(page).to have_content("bobby")
  end

end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit(new_session_url)
    save_and_open_page
    expect(page).to have_button("signin")
    expect(page).to have_button("signup")
    expect(page).to_not have_content("Logged in")
    expect(page).to_not have_content("sign out")
  end

  scenario "doesn't show username on the homepage after logout" do
    User.create(username: "bobby", password: "password")
    visit new_session_url
    fill_in 'username', with: "bobby"
    fill_in 'password', with: "password"
    click_on 'Sign in'
    click_on 'sign out'
    expect(page).to_not have_content("bobby")
  end

end
