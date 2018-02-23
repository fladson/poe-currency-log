require "rails_helper"

feature "logout" do
  after :each do
    Warden.test_reset!
  end

  describe "redirect" do
    it "to home after logout" do
      user = create(:user)
      visit new_user_session_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Log in"
      click_link "Logout"

      expect(page).to have_current_path("/")
    end
  end
end
