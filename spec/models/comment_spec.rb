require 'spec_helper'

describe Comment do
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:commentable) }

  it { should belong_to(:user) }
  it { should belong_to(:commentable) }
  it { should have_many(:comments) }

  describe '#num_replies' do
    subject { create(:comment, :on_article) }   

    it 'displays the number of comments on a comment' do
      subject.num_replies.should == 0

      comment = create(:comment, commentable: subject)
      subject.num_replies.should == 1

      create(:comment, commentable: comment)
      subject.reload.num_replies.should == 2
    end
  end
end
