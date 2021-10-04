require 'rails_helper'

describe PropertyLocation do
  it { should have_many(:properties) }

  it { should validate_uniqueness_of(:name).with_message('já está em uso') }
  it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
end
