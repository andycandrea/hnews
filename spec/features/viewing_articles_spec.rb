require 'spec_helper'

describe "viewing articles" do
  let!(:old_article) { create(:article, :has_url) }
  let!(:new_article) { create(:article, :has_url, title: "Title 2") }
  
  before { visit '/articles' }

  it "should display new entry" do
    page.should have_content('Such title')
    page.should have_content('Title 2')
    page.should have_content('http://www.much.url')
  end
  
  it "should be sorted by descending time of creation" do
    page.body.index(new_article.title).should < page.body.index(old_article.title)
  end
end
