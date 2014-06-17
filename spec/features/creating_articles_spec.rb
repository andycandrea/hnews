require 'spec_helper'

describe "creating articles" do
  context "when given invalid parameters" do
    let(:params) { { title: '', url: '', content: '' }}

    before do
      visit '/articles/new'

      params.each do |attr, value|
        fill_in "article_#{attr}", with: value
      end

      click_button 'Submit'
    end

    it "displays errors on title" do
      expect(page).to have_content('Title cannot be blank')
    end
  end

  context "when given valid parameters" do
    let(:params) { { title: 'Wow. Such Read', url: 'http://example.com', content: 'Check it' }}

    before do
      visit '/articles/new'

      params.each do |attr, value|
        fill_in "article_#{attr}", with: value
      end

      click_button 'Submit'
    end

    it "creates a new Article" do
      article = Article.last

      article.title.should == 'Wow. Such Read'
      article.url.should == 'http://example.com'
      article.content.should == 'Check it'
    end

    it "displays success message" do
      expect(page).to have_content('Article successfully created.')
    end
  end
end
