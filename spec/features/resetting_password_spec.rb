require 'spec_helper'

describe 'resetting a user password' do
  let(:user) { create(:user) }
  let(:bad_email) { 'thisemailsux@aol.com' }
  let(:new_password) { 'wololo' }

  before do
    visit '/reset'
    ActionMailer::Base.deliveries = []
  end

  context 'with a nonexistent email' do
    it 'displays success but sends no email' do
      fill_in 'password_reset_email', with: bad_email
      click_button 'Submit'
      page.should have_content('Email sent with reset instructions')
      ActionMailer::Base.deliveries.count.should == 0
    end
  end

  context 'with a valid email' do
    it 'displays success and sends an email' do
      fill_in 'password_reset_email', with: user.email
      click_button 'Submit'
      
      user.reload

      page.should have_content('Email sent with reset instructions')
      ActionMailer::Base.deliveries.count.should == 1
      # Mail should include a link to the appropriate edit password URL
      ActionMailer::Base.deliveries.last.should have_content(edit_password_reset_url(user.password_reset_token))
    end

    it 'allows the user to reset their password and log in with the new password' do
      user = create(:user, password_reset_token: 'emu', password_reset_sent_at: Time.now)
      visit edit_password_reset_path(user.password_reset_token)

      %w(user_password user_password_confirmation).each do |attr|
        fill_in attr, with: new_password
      end
      
      click_button 'Submit'

      user.password = new_password
      user.reload

      current_path.should == root_path
      page.should have_content('Password has been reset!')
      
      visit '/signin'

      %w(name password).each do |attr|
        fill_in "session_#{attr}", with: user.send(attr)
      end

      click_button 'Submit'

      current_path.should == root_path
      page.should have_content('Sign out')
    end
  end
end
