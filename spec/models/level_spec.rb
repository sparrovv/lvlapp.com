require 'spec_helper'

describe Level do
  subject { build(:level) }

  it 'is valid' do
    subject.valid?.should be_true
  end

  it 'validates uniquness' do
    name = subject.name
    subject.save

    build(:level, name: name).valid?.should be_false
  end
end
