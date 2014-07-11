require 'spec_helper'

describe User do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should ensure_length_of(:password).is_at_least(6) }
  it { should ensure_length_of(:name).is_at_most(20) }
  
  it { should have_secure_password }
  it { should validate_confirmation_of(:password) }
  
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:email) }
  
  it { should allow_value('andy@viget.com', 'andy.andrea@cs.unc.edu').for(:email) }
  it { should_not allow_value('fiz', 'a@b', 'andy@', '@com').for(:email) }

  it { should have_many(:articles) }
  it { should have_many(:comments) }
end
