require 'spec_helper'

describe Article do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:user) }

  it { should belong_to(:user) }
  it { should have_many(:comments) }

  describe "empty value validation" do
    it "will allow content to be empty" do
      article = build(:article, :has_url)
      article.valid?.should == true
    end

    it "will allow URL to be empty" do
      article = build(:article, :has_content)
      article.valid?.should == true
    end
  end

  describe "single article type validation" do

    it "will not accept an article without a URL or text content" do
      article = build(:article)
      article.valid?.should == false
    end

    it "will not accept both a URL and text content" do
      article = build(:article, :has_url, :has_content)
      article.valid?.should == false
    end
  end

  describe "full URI validation" do
    
    it "will accept a valid URI with no scheme" do
      article = build(:article, :has_url)
      article.valid?.should == true
    end

    it "will not accept an arbitrary string as the URL" do
      article = build(:article)
      article.url = 'one horse sized duck'
      article.valid?.should == false
    end
  end
end
