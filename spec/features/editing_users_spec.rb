require 'spec_helper'

describe 'editing users' do
  let(:created_users) { create_pair(:user) }

  context 'when not signed in' do
    it 'should redirect to the sign in page and display an error' do
      visit "/users/#{created_users[0].id}/edit"
      current_path.should == signin_path
      page.should have_content('You must sign in to perform this action')
    end
  end

  context 'when signed in' do
    before do
      sign_in(created_users[0])
    end

    it 'should redirect to the root path and display an error if wrong user' do
      visit "/users/#{created_users[1].id}/edit"
      current_path.should == root_path
      page.should have_content('You do not have access to that action')
    end

    it 'should allow editing and update the user if correct user' do
      visit "/users/#{created_users[0].id}/edit"
      new_password = 'wololo'

      %w(user_password user_password_confirmation).each do |attr|
        fill_in attr, with: new_password
      end
      
      click_button 'Submit'

      page.should have_content('Profile successfully updated')
      current_path.should == root_path

      click_link 'Sign out'
      click_link 'Sign in'
      fill_in 'session_name', with: created_users[0].name
      fill_in 'session_password', with: new_password

      click_button 'Submit'

      page.should have_content('Sign out')
      current_path.should == root_path
    end
  end
end
