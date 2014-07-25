require 'spec_helper'

describe 'Voting' do
  let!(:article) { create(:article, :has_url) }
  let!(:upvotes) { create_list(:vote, 5, votable: article) }
  let!(:downvotes) { create_list(:vote, 2, is_up: false, votable: article) }

  context 'when signed out' do
    it 'shows scores but does not allow voting' do
      visit '/'

      expect(page).to have_content('The score is: 3')
      expect(page).to_not have_selector("input[type=submit][value='Upvote']")
      expect(page).to_not have_selector("input[type=submit][value='Downvote']")
    end
  end

  context 'when signed in' do
    let!(:user) { create(:user) }

    before { sign_in(user) }

    context 'voting on an article' do
      it 'displays the initial score before voting' do
        expect(page).to have_content('The score is: 3')
      end

      it 'allows a User to upvote' do
        click_button 'Upvote'
        expect(page).to have_content('The score is: 4')
      end

      it 'allows a User to downvote' do
        click_button 'Downvote'
        expect(page).to have_content('The score is: 2')
      end

      it 'allows the User to delete their vote' do
        click_button 'Upvote'
        expect(page).to have_content('The score is: 4')

        click_button 'Upvote'
        expect(page).to have_content('The score is: 3')
      end

      it 'allows the User to change their vote' do
        click_button 'Upvote'
        expect(page).to have_content('The score is: 4')

        click_button 'Downvote'
        expect(page).to have_content('The score is: 2')
      end
    end

    context 'voting on a comment' do
      let!(:comment) { create(:comment, commentable: article) }

      before { click_link 'View post' }

      it 'displays the initial score before voting' do
        within('.comments') { expect(page).to have_content('The score is: 0') }
      end

      it 'allows a User to upvote' do
        within('.comments') { click_button 'Upvote' }
        
        expect(page).to have_content('The score is: 1')
      end

      it 'allows a User to downvote' do
        within('.comments') { click_button 'Downvote' }

        expect(page).to have_content('The score is: -1')
      end

      it 'allows the User to delete their vote' do
        within('.comments') { click_button 'Upvote' }
        expect(page).to have_content('The score is: 1')

        within('.comments') { click_button 'Upvote' }
        expect(page).to have_content('The score is: 0')
      end

      it 'allows the User to change their vote' do
        within('.comments') { click_button 'Upvote' }
        expect(page).to have_content('The score is: 1')


        within('.comments') { click_button 'Downvote' }
        expect(page).to have_content('The score is: -1')
      end
    end
  end
end
