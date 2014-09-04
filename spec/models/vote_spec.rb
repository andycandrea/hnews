require 'spec_helper'

describe Vote do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:votable) }

  it { should belong_to(:user) }
  it { should belong_to(:votable) }

  it 'does not allow a User to vote multiple times per votable' do
    user = create(:user)
    article = create(:article, :has_url)
    create(:vote, user: user, votable: article)
    build(:vote, user: user, votable: article).save.should == false
  end
end
