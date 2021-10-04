require 'rails_helper'

describe PropertyOwner do
  it { should allow_value('teu@shelby.com.br').for(:email) }
  it { should_not allow_value('aaaaaaaaaaaaaa').for(:email) }
  it { should_not allow_value({}).for(:email) }
end
