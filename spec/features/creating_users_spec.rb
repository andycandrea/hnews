require 'spec_helper'

describe 'creating users' do

  before do
    visit '/signup'
  end

  let(:params) do
    {
      name: 'picard',
      email: 'picard@borg.co',
      password: 'fourlights',
      password_confirmation: 'fourlights' 
    }
  end

  context 'when given valid parameters' do
    it 'creates a new User and signs them in' do
       params.each do |attr, val|
        fill_in "user_#{attr}", with: val
      end

      click_button 'Submit'
      page.should have_content('Sign out')
    end
  end

  context 'when given invalid parameters' do
    before do
       params.each do |attr, val|
        fill_in "user_#{attr}", with: val
      end
    end

    it 'rejects a username longer than 20 characters' do
      fill_in 'user_name', with: 'a' * 21
      click_button 'Submit'
      page.should have_content('Name is too long (maximum is 20 characters)')
    end

    it 'rejects a password shorter than 6 characters' do
      %w(user_password user_password_confirmation).each do |attr|
        fill_in attr, with: 'hello'
      end

      click_button 'Submit'
      page.should have_content('Password is too short (minimum is 6 characters)')
    end

    it 'returns an error when the password and password confirmation do not match' do
      fill_in 'user_password', with: 'fivelights'
      click_button 'Submit'
      page.should have_content("Password confirmation doesn't match Password")
    end

    it 'rejects an improperly formed email address' do
      fill_in 'user_email', with: 'cat'
      click_button 'Submit'
      page.should have_content('Email is invalid')
    end
  end
end
