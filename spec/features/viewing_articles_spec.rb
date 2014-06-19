require 'spec_helper'

describe "viewing articles" do
  let!(:old_article) { create(:article) }
  let!(:new_article) { create(:article, title: "Title 2") }
  
  before { visit '/articles' }

  it "should display new entry" do
    expect(page).to have_content('Such title')
    expect(page).to have_content('http://www.much.url')
    expect(page).to have_content('Wow.')
  end
  
  it "should have the content 'Title'" do
    expect(page).to have_content('Title')
  end

  it "should have the content 'Created At'" do
    expect(page).to have_content('Created At')
  end

  it "should be sorted by descending time of creation" do
    page.body.index(new_article.title).should < page.body.index(old_article.title)
  end
end