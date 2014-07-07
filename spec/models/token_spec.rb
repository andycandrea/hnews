require 'spec_helper'

describe Token do
  describe '#new' do
    let(:value) { 'doge' }

    context 'called with one argument' do
      subject { Token.new(value) }
    
      it 'assigns that argument to value' do
        subject.value.should == value
      end
    end

    context 'called with a non string argument' do
      subject { Token.new(2) }

      it 'sets the value to a string' do
        subject.value.should == '2'
     end
    end

    context 'created with no arguments' do
      subject { Token.new }

      before do
        SecureRandom.stub(:urlsafe_base64) { 'doge' }
      end

      it 'sets the value to a new SecureRandom' do
        subject.value.should == 'doge'
      end
    end
  end

  describe '#to_s' do
    let(:value) { 'doge' }

    subject { Token.new(value) }

    it 'returns the value as a string' do
      subject.to_s.should == value
    end
  end

  describe '#digest' do 
    let(:value) { 'doge' }
    
    subject { Token.new(value) }

    it "returns the digest of the remember token's value" do
      subject.digest.should == Digest::SHA1.hexdigest(value) 
    end
  end

  describe '#value' do
    let(:value) { 'doge' }
    
    subject { Token.new(value) }

    it "returns the remember token's value" do
      subject.value.should == value
    end
  end
end
