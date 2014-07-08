require 'spec_helper'

describe PasswordReset do
  let(:user) { create(:user, password_reset_token: 'hello', password_reset_sent_at: Time.zone.now) }
  let(:reset) { PasswordReset.new(email: user.email, token: 'hello') }

  before do
    ActionMailer::Base.deliveries = []
    reset.errors.clear
  end

  describe '#user' do
    it 'finds the user based on email' do
      reset.user.should == user
    end

    it 'finds the user based on token' do
      reset.email = nil
      reset.user.should == user
    end
  end

  describe '#deliver' do
    it "updates user's password_reset_token and sends an email" do
      reset.token = Token.new('dog')
      reset.deliver
      
      user.reload

      user.password_reset_token.should == reset.send(:token).digest
      ActionMailer::Base.deliveries.count.should == 1
    end

    it 'adds an error if user does not exist' do
      reset.email = 'apple'
      reset.token = Token.new('nananabatman')
      
      reset.deliver
      
      reset.errors[:base].should include('No user exists with that email.')
    end
  end

  describe '#update_user' do
    it 'displays an error if password reset is expired' do
      user.update_column(:password_reset_sent_at, Time.zone.yesterday) 
      reset.update_user
      
      reset.errors[:base].should include('Password reset has expired.')
    end

    it 'displays an error if password and password confirmation do not match' do
      reset.password = 'fourlights'
      reset.password_confirmation = 'fivelights'

      reset.update_user

      reset.errors[:base].should include('Passwords must match and be at least six characters long.')
    end

    it 'displays an error if password is less than six characters' do
      reset.password = 'hi'
      reset.password_confirmation = 'hi'
      
      reset.update_user

      reset.errors[:base].should include('Passwords must match and be at least six characters long.')
    end

    it 'destroys the password reset token and updates user password on success' do
      reset.password = 'android'
      reset.password_confirmation = 'android'
      
      reset.update_user
      user.reload

      user.password_reset_token.should == nil
      user.authenticate('android').should_not == false
    end
  end
end
