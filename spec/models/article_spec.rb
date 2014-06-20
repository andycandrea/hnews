require 'spec_helper'

describe Article do
  it { should validate_presence_of(:title) }

  describe "non-nil value validation" do
    it "will not allow URL or content to be nil" do
      article = build(:article)
      article.url = nil
      article.content = nil

      article.valid?.should be false
    end

    it "will allow content to be empty" do
      article = build(:article)
      article.valid?.should be true
    end

    it "will allow URL to be empty" do
      article = build(:article)
      article.url = ""
      article.content = "not empty"
      article.valid?.should be true
    end
  end

  describe "single article type validation" do

    it "will not accept an article without a URL or text content" do
      article = build(:article)
      article.url = ""
      article.valid?.should be false
    end

    it "will not accept both a URL and text content" do
      article = build(:article)
      article.content = 'such content'
      article.valid?.should be false
    end
  end

  describe "full URI validation" do
    
    it "will accept a valid URI with no scheme" do
      article = build(:article)
      article.valid?.should be true
    end

    it "will not accept an arbitrary string as the URL" do
      article = build(:article)
      article.url = 'one horse sized duck'
      article.valid?.should be false
    end
  end
end
