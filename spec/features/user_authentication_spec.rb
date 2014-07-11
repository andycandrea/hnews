require 'spec_helper'

describe 'authenticating users' do
  let(:user) { create(:user) }

  context 'with invalid information' do
    it 'should not allow non-existent users to log in' do
      bad_user = build(:user)

      sign_in(bad_user)

      page.should have_content('Invalid username or password')
      page.should have_link('Sign in')
      current_path.should == signin_path
    end

    it 'should not allow a user to log in with an incorrect password' do
      bad_user = user
      bad_user.password = 'hi'

      sign_in(bad_user)

      page.should have_content('Invalid username or password')
      page.should have_link('Sign in')
      current_path.should == signin_path
    end
  end

  context 'with valid information' do
    before do
      sign_in(user)
    end

    it 'should allow the user to log in' do
      page.should have_link('Sign out')
      current_path.should == root_path
    end

    it 'should allow a signed-in user to log out' do
      click_link 'Sign out'
      page.should have_link('Sign in')
    end

    it 'should automatically redirect a signed-in user away from the signup and signin pages' do
      visit '/signin'
      current_path.should == root_path
      visit '/signup'
      current_path.should == root_path
    end
  end
end
