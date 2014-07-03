require 'spec_helper'

describe ApplicationController do

  describe '#sign_in' do
    let(:user) { create(:user) }
  
    it 'sets the current_user and current_remember_token' do
      # Let above not working? user undefined unless using line below
      #user = create(:user)
      controller.send(:sign_in, user)

      assigns[:current_user].should == user
      assigns[:current_remember_token].should be_a RememberToken
    end
  end

  describe '#sign_out' do
    let(:user) { create(:user) }
    let(:token) { RememberToken.new('droid') }

    it 'sets the current_user and current_remember_token to nil' do
      controller.instance_variable_set(:@current_user, user)
      controller.instance_variable_set(:@current_remember_token, token)

      controller.instance_eval { sign_out }

      assigns(:current_user).should == nil
      assigns(:current_remember_token).should == nil
    end
  end

  describe '#current_user' do
    let(:token) { RememberToken.new('droid') }

    it 'returns the current user if it exists' do
      user = create(:user)
      controller.instance_variable_set(:@current_user, user)
      (controller.instance_eval { current_user }).should == user
    end

    it 'returns the user with the corresponding remember_token' do
      user = create(:user, remember_token: token.digest)
      controller.instance_variable_set(:@current_remember_token, token)

      (controller.instance_eval { current_user }).should == user
    end
  end

  describe '#current_remember_token' do
    let(:token) { RememberToken.new('droid') }
    
    it 'returns the current remember token if it exists' do
      controller.instance_variable_set(:@current_remember_token, token)

      (controller.instance_eval { current_remember_token }).should == token
    end

    it 'returns a remember token based on the remember_token cookie' do
      request.cookies['remember_token'] = token.value

      token = controller.instance_eval { current_remember_token }

      token.should be_a RememberToken
      token.value.should == 'droid'
    end
  end

  describe '#current_remember_token=' do
    let(:user) { create(:user) }
    let(:token) { RememberToken.new('droid') }
    
    it 'sets current_token to nil and deletes the remember token cookie if passed nil' do
      request.cookies['remember_token'] = token.value
      controller.instance_variable_set(:@current_remember_token, token)
      
      controller.send(:current_remember_token=, nil)
      assigns[:current_remember_token].should == nil
      response.cookies['remember_token'].should == nil
    end

    it "sets the current token and remember token cookie to the passed token's value" do
      controller.send(:current_remember_token=, token)
      
      assigns[:current_remember_token].should == token
      cookies['remember_token'].should == token.value
    end
  end

  describe '#signed_in?' do
    let(:user) { create(:user) }
    
    it 'returns true if current_user is set' do
      controller.instance_variable_set(:@current_user, user)
      (controller.instance_eval { signed_in? }).should == true
    end

    it 'returns false if current_user is not set' do
      (controller.instance_eval { signed_in? }).should == false 
    end
  end
end
