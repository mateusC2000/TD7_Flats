require 'rails_helper'

describe Property do
  it { should belong_to(:property_type) }
  it { should belong_to(:property_location) }
  
  it { should validate_presence_of(:title).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:description).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:rooms).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:bathrooms).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:daily_rate).with_message('não pode ficar em branco') }

  it { should validate_numericality_of(:rooms).only_integer.is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:bathrooms).only_integer.is_greater_than(0) }
  it { should validate_numericality_of(:daily_rate).is_greater_than(0) }
end
