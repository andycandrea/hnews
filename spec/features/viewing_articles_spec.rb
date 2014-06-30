require 'spec_helper'

describe 'viewing articles' do
  let!(:old_article) { create(:article, :has_url) }
  let!(:new_article) { create(:article, :has_url, title: 'Title 2') }
  
  before { visit root_path }

  it 'should display new entry' do
    page.should have_content('Such title')
    page.should have_content('Title 2')
    page.should have_content('http://www.much.url')
  end
  
  it 'should be sorted by descending time of creation' do
    page.body.index(new_article.title).should < page.body.index(old_article.title)
  end

  context 'when trying to view an individual article' do
    it 'should have a valid link to a show article page' do
      page.should have_link('View post', href: article_path(old_article))
      click_link('View post', href: article_path(old_article))

      current_path.should == article_path(old_article)
      page.should have_content(old_article.title)
      page.should have_content(old_article.created_at)
      page.should have_content(old_article.url)
    end
  end

  context 'when fewer articles than ARTICLES_PER_PAGE exist' do
    it 'should not link to any additional pages' do
      page.should_not have_link('1')
      page.should_not have_link('2')
    end
  end

  context 'when more articles than ARTICLES_PER_PAGE exist' do
    it 'should only show ARTICLES_PER_PAGE and link to the next page' do
      created_articles = create_list(:article, 20, :has_content, title: 'Newest title')
      visit root_path

      page.should have_content(created_articles[0].title)
      page.should have_content(created_articles[0].content)
      page.should have_content(created_articles[0].created_at)
      page.should have_link('View post', href: article_path(created_articles[0]))

      page.should_not have_content(old_article.title)
      page.should_not have_content(old_article.url)
      page.should_not have_link('View post', href: article_path(old_article))

      page.should_not have_content(new_article.title)
      page.should_not have_content(new_article.url)
      page.should_not have_link('View post', href: article_path(new_article))
      
      page.should have_link('1')
      page.should have_link('2')
      click_link('2')

      page.should_not have_content(created_articles[0].title)
      page.should_not have_content(created_articles[0].content)
      page.should_not have_link('View post', href: article_path(created_articles[0]))

      page.should have_content(old_article.title)
      page.should have_content(old_article.url)
      page.should have_content(old_article.created_at)
      page.should have_link('View post', href: article_path(old_article))

      page.should have_content(new_article.title)
      page.should have_content(new_article.url)
      page.should have_content(new_article.created_at)
      page.should have_link('View post', href: article_path(new_article))
    end
  end
end
