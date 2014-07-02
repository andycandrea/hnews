require 'spec_helper'

describe Session do
  context 'when creating a session' do
    it 'should have a nil user instance variable if no matching User exists' do
      session = build(:session)
      session.user.should == nil
    end

    it 'should set the user instance variable to be the user with the given name and password' do
      user = create(:user)
      session = build(:session, name: user.name)
      session.name = user.name
      session.user.should == user
    end
  end

  context 'when loading a user' do
    it 'should return the correct user when passed a remember_token' do
      user = create(:user)
      token = RememberToken.new 
      user.update_column(:remember_token, token.digest) 
      Session.load_user(token).should == user
    end
  end
end
