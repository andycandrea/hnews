require 'spec_helper'

describe 'commenting' do
  let(:user) { create(:user) }
  let(:article) { create(:article, :has_url, user_id: user.id) }

  context 'when not signed in' do
    it 'does not allow commenting' do
      visit "/articles/#{article.id}"
      page.should_not have_css('textarea#comment_body')
    end
  end

  context 'when signed in' do
    before do
      sign_in(user)
      visit "/articles/#{article.id}"
    end

    it 'does not allow an empty comment' do
      click_button 'Submit'
      page.should have_content('Comment cannot be blank.')
    end

    it 'adds the comment to the page if valid' do
      page.should have_css('textarea#comment_body')

      fill_in 'comment_body', with: 'da comment'
      click_button 'Submit'

      page.should have_content('da comment')
    end

    context 'on comments' do
      it "display the new comment and add it to the first comment's comments" do
        fill_in 'comment_body', with: 'yo dawg'
        click_button 'Submit'

        within('.comment:first-child') do
          click_button 'Reply'
          fill_in 'comment[body]', with: 'i heard you like comments'
          click_button 'Submit'

          page.should have_content('i heard you like comments')
        end
      end
    end
  end
end
