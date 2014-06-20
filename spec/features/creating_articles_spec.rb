require 'spec_helper'

describe "creating articles" do
  context "when given invalid parameters" do
    let(:params) do
      {
        title: '',
        url: '',
        content: ''
      }
    end

    before do
      visit '/articles/new'

      params.each do |attr, value|
        fill_in "article_#{attr}", with: value
      end

      click_button 'Submit'
    end

    it "displays errors on title" do
      page.should have_content('Title can\'t be blank')
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
      visit '/articles/new'

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

    before do
      visit '/articles/new'
      fill_in "article_title", with: "Much title, wow" 
    end

    it "creates a new Article with URL and displays success" do
      fill_in "article_url", with: "http://dogecoin.com/"
      click_button 'Submit'

      article = Article.last

      article.title.should == 'Much title, wow'
      article.url.should == 'http://dogecoin.com/'
      article.content.should == ''

      page.should have_content('Article successfully created.')
    end

    it "creates a new Article with content and displays success" do
      fill_in "article_content", with: "Such success, much test, wow."
      click_button 'Submit'

      article = Article.last

      article.title.should == 'Much title, wow'
      article.url.should == ''
      article.content.should =='Such success, much test, wow.'

      page.should have_content('Article successfully created.')
    end
  end
end
