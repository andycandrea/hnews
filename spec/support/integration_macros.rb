module IntegrationMacros
  def sign_in(user=create(:user))
    visit '/signin'
          
    %w(name password).each do |attr|
      fill_in "session_#{attr}", with: user.send(attr)      
    end

    click_button 'Submit'
  end
end
