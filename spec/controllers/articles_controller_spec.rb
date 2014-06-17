require 'spec_helper'

describe ArticlesController do

  it { should permit(:title).for(:create) }
  it { should permit(:url).for(:create) }
  it { should permit(:content).for(:create) }

  describe "GET 'new'" do
    before { get :new }

    it { should respond_with(:success) }
    it { should render_template(:new) }

    it "assigns new instance of Article" do
      assigns(:article).should be_instance_of(Article)
    end
  end

  describe "POST 'create'" do
    before { post :create, article: { title: 'Wow. Such Read' } }

    it { should redirect_to(new_article_path) }

    it "assigns article with provided title" do
      assigns(:article).title.should == 'Wow. Such Read'
    end
  end

end
