require 'spec_helper'

describe Category do
  let(:category) { build(:category) }

  it 'is valid' do
    category.valid?.should be_true
  end

  it 'validates uniquness' do
    name = category.name
    category.save

    build(:category, name: name).valid?.should be_false
  end
end
