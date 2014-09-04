require 'spec_helper'

describe 'Voting' do
  let!(:article) { create(:article, :has_url) }
  let!(:upvotes) { create_list(:vote, 5, votable: article) }
  let!(:downvotes) { create_list(:vote, 2, is_up: false, votable: article) }

  context 'when signed out' do
    it 'shows scores but does not allow voting' do
      visit '/'

      expect(page).to have_content('3')
      expect(page).to_not have_css('a.upvote-link')
      expect(page).to_not have_css('a.downvote-link')
    end
  end

  context 'when signed in' do
    let!(:user) { create(:user) }

    before { sign_in(user) }

    context 'voting on an article', js: true do
      it 'displays the initial score before voting' do
        expect(page).to have_content('3')
      end

      it 'allows a User to upvote' do
        find('a.upvote-link').click
        expect(page).to have_content('4')
      end

      it 'allows a User to downvote' do
        find('a.downvote-link').click
        expect(page).to have_content('2')
      end

      it 'allows the User to delete their vote' do
        find('a.upvote-link').click
        expect(page).to have_content('4')

        find('a.upvote-link').click
        expect(page).to have_content('3')
      end

      it 'allows the User to change their vote' do
        find('a.upvote-link').click
        expect(page).to have_content('4')

        find('a.downvote-link').click
        expect(page).to have_content('2')
      end
    end

    context 'voting on a comment', js: true do
      let!(:comment) { create(:comment, commentable: article) }

      before { visit article_path(article) }

      it 'displays the initial score before voting' do
        within('.comments') { expect(page).to have_content('0') }
      end

      it 'allows a User to upvote' do
        within('.comments') { find('a.upvote-link').click }
        expect(page).to have_content('1')
      end

      it 'allows a User to downvote' do
        within('.comments') { find('a.downvote-link').click }
        expect(page).to have_content('-1')
      end

      it 'allows the User to delete their vote' do
        within('.comments') { find('a.upvote-link').click }
        expect(page).to have_content('1')

        within('.comments') { find('a.upvote-link').click }
        expect(page).to have_content('0')
      end

      it 'allows the User to change their vote' do
        within('.comments') { find('a.upvote-link').click }
        expect(page).to have_content('1')

        within('.comments') { find('a.downvote-link').click }
        expect(page).to have_content('-1')
      end
    end
  end
end
