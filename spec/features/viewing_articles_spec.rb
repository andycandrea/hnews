require 'spec_helper'

describe "viewing articles" do
  let(:params) do
    {
      title: 'Such sort.',
      url: 'http://www.example.com',
      content: 'Much database.'
    }
  end

  before do
    #Decided to use the new article page rather than Article.create for further testing of my code
    visit '/articles/new'

    params.each do |attr, val|
      fill_in "article_#{attr}", with: val
    end

    click_button 'Submit'
  end

  it "should display new entry" do
    visit '/articles'
    expect(page).to have_content('Such sort.')
    expect(page).to have_content('http://www.example.com')
    expect(page).to have_content('Much database.')
  end
  
  it "should have the content 'Title'" do
    visit '/articles'
    expect(page).to have_content('Title')
  end

  it "should have the content 'Date'" do
    visit '/articles'
    expect(page).to have_content('Date')
  end

end
