require "rails_helper"

feature "sign in" do
  after :each do
    Warden.test_reset!
  end

  before do
    User.any_instance.stub :check_credentials
  end

  describe "home links" do
    context "signed out" do
      it "shows a sign in link" do
        visit root_path

        expect(page).to have_link("Login", href: "/users/sign_in")
      end
    end

    context "signed in" do
      it "shows a sign out link" do
        login_as(create(:user))
        visit root_path

        expect(page).to have_link("Logout", href: "/users/sign_out")
      end
    end
  end

  describe "redirect" do
    it "to dashboard after sign in" do
      user = create(:user)
      visit new_user_session_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Log in"

      expect(page).to have_current_path("/dashboard")
    end
  end
end
