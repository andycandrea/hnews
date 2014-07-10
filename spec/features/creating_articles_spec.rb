require 'spec_helper'

describe "creating articles" do

  before do
    user = create(:user)
    visit '/signin'

    %w(name password).each do |attr|
      fill_in "session_#{attr}", with: user.send(attr)
    end

    click_button 'Submit'
    visit '/submit'
  end

  context "when given invalid parameters" do
    let(:params) do
      {
        title: '',
        url: '',
        content: ''
      }
    end

    before do
      params.each do |attr, value|
        fill_in "article_#{attr}", with: value
      end

      click_button 'Submit'
    end

    it "displays errors on title" do
      page.should have_content("Title can't be blank")
    end

    it "displays errors on content and url" do
      page.should have_content('URL or content must have a value.')
    end
  end

  context "When given too many parameters" do
    let(:params) do
      {
        title: 'Wow. Such Read',
        url: 'http://example.com',
        content: 'Check it'
      }
    end

    before do
      params.each do |attr, val|
        fill_in "article_#{attr}", with: val
      end

      click_button 'Submit'
    end

    it "displays an error when passed a URL and content" do
      page.should have_content('Article cannot contain both a URL and text content.')
    end

  end

  context "when given valid parameters" do 
    let (:article_title) { 'Much title, wow' }
    let (:article_url) { 'http://dogecoin.com' }
    let (:article_content) { 'Such success, much test, very wow.' }

    before do
      fill_in "article_title", with: article_title 
    end

    it "creates a new Article with URL" do
      fill_in "article_url", with: article_url
      click_button 'Submit'
     
      page.should have_content(article_title)
      page.should have_link("(#{URI(article_url).host})")
    end

    it "creates a new Article with content" do
      fill_in "article_content", with: article_content 
      click_button 'Submit'

      page.should have_content(article_title)
      page.should have_content(article_content)
    end
  end

  context 'when attempting to submit an article when not signed in' do
    it 'should redirect to sign in and display an error' do
      click_link 'Sign out'
      visit '/submit'
      page.should have_content('You must sign in to perform this action')
      current_path.should == signin_path
    end
  end 
end
