require 'spec_helper'

describe 'commenting' do
  let(:article) { create(:article, :has_url) }
  let(:user) { create(:user) }

  context 'when not signed in' do
    it 'does not allow commenting' do
      visit "/articles/#{article.id}"
      page.should_not have_css('textarea#comment_body')
    end
  end

  context 'when signed in' do
    before do
      visit '/signin'
      %w(name password).each do |attr|
        fill_in "session_#{attr}", with: user.send(attr)
      end

      click_button 'Submit'

      visit "/articles/#{article.id}"
    end

    it 'does not allow an empty comment' do
      click_button 'Submit'
      page.should have_content("Body can't be blank")
    end

    it 'adds the comment to the page if valid' do
      page.should have_css('textarea#comment_body')

      fill_in 'comment_body', with: 'da comment'
      click_button 'Submit'

      page.should have_content('da comment')
    end
  end
end
