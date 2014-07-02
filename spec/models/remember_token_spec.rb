require 'spec_helper'

describe RememberToken do
  let(:value) { 'dog' }

  describe 'creating a new RememberToken' do
    context 'created with an argument' do
      subject { RememberToken.new(value) }
      
      it 'sets the value to the argument' do
        subject.value.should == value
      end
    end

    context 'crated with a non-string argument' do
      subject { RememberToken.new(2) }

      it 'sets the value to a string' do
        subject.value.should == '2'
      end
    end

    context 'created with no arguments' do
      subject { RememberToken.new }

      before do
        SecureRandom.stub(:urlsafe_base64) { 'doge' }
      end

      it 'sets the value to a new SecureRandom' do
        subject.value.should == 'doge'
      end
    end
  end

  describe '#digest' do 
    subject { RememberToken.new(value) }

    it "returns the digest of the remember token's value" do
      subject.digest.should == Digest::SHA1.hexdigest(value) 
    end
  end

  describe '#value' do
    subject { RememberToken.new(value) }

    it "returns the remember token's value" do
      subject.value.should == value
    end
  end
end
