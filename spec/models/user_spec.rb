require 'spec_helper'

describe User do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe "usernames that are too long" do
    it "will not allow a username of greater than 20 characters" do
      user = build(:user)
      user.name = "a" * 21
      user.valid?.should == false
    end
  end

  describe "previously used emails" do
    it "will not allow one email address to be associated with multiple users" do
      user = create(:user)
      user2 = build(:user, name: "bobdole", email: "ABC@efg.co")

      user2.valid?.should == false
    end
  end

  describe "previously used usernames" do
    it "will not allow one username to be associated with multiple users" do
      user = create(:user)
      user2 = build(:user, name: "jackieCHAN", email: "test@abc.com")

      user2.valid?.should == false
    end
  end

  describe "passwords that are too short" do
    it "will not allow a password less than six characters" do
      user = build(:user, password: "hi")
      user.valid?.should == false
    end
  end
end
