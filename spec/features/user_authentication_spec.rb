require 'spec_helper'

describe 'authenticating users' do

  before do
    visit '/signin'
  end

  let(:user) { create(:user) }

  context 'with invalid information' do
    it 'should not allow non-existent users to log in' do
      bad_user = build(:user)

      %w(name password).each do |attr|
        fill_in "session_#{attr}", with: bad_user.send(attr)
      end

      click_button 'Submit'
      
      page.should have_content('Invalid username or password')
      page.should have_link('Sign in')
      current_path.should == sessions_path
    end

    it 'should not allow a user to log in with an incorrect password' do
      bad_user = user
      bad_user.password = 'hi'

      %w(name password).each do |attr|
        fill_in "session_#{attr}", with: bad_user.send(attr)
      end

      click_button 'Submit'

      page.should have_content('Invalid username or password')
      page.should have_link('Sign in')
      current_path.should == sessions_path
    end
  end

  context 'with valid information' do
    before do
      %w(name password).each do |attr|
        fill_in "session_#{attr}", with: user.send(attr)
      end

      click_button 'Submit'
    end

    it 'should allow the user to log in' do
      page.should have_link('Sign out')
      current_path.should == root_path
    end

    it 'should allow a signed-in user to log out' do
      click_link 'Sign out'
      page.should have_link('Sign in')
    end
  end
end
