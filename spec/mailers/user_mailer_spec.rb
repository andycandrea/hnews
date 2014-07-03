require "spec_helper"

describe UserMailer do
  let(:user) { create(:user) }
  
  describe '#reset_password_email' do
    context 'sending the email' do
      before do
        user.send_password_reset
      end

      it 'sends the email' do
        ActionMailer::Base.deliveries.count.should == 1
      end

      it 'contains the correct subject line' do
        ActionMailer::Base.deliveries.first.subject.should == 'Haxx0r News - Reset Password'
      end

      it 'contains the correct sender' do
        ActionMailer::Base.deliveries.first.from.should == ['haxx0rnews@gmail.com'] 
      end
      
      it 'is addressed to the correct recipient' do
        ActionMailer::Base.deliveries.first.to.should == [user.email]
      end
    end
  end
end
