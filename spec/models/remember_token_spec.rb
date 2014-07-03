require 'spec_helper'

describe RememberToken do
  describe '#new' do
    let(:value) { 'doge' }

    context 'called with one argument' do
      subject { RememberToken.new(value) }
    
      it 'assigns that argument to value' do
        subject.value.should == value
      end
    end

    context 'called with no arguments' do
      subject { RememberToken.new }

      it 'assigns a string to value' do
        RememberToken.any_instance.stub(:create_token).and_return(:dog)
        subject.value.should == 'dog'
      end
    end

    context 'called with a non string argument' do
      subject { RememberToken.new(2) }

      it 'sets the value to a string' do
        subject.value.should == '2'
      end
    end
  end

  describe '#to_s' do
    let(:value) { 'doge' }

    subject { RememberToken.new(value) }

    it 'returns the value as a string' do
      subject.to_s.should == value
    end
  end

  describe '#digest' do
    let(:value) { 'doge' }

    context 'when called' do
      subject { RememberToken.new(value) }
      
      it 'returns the digest of the value' do
        subject.digest.should == Digest::SHA1.hexdigest(value)
      end
    end
  end
end
