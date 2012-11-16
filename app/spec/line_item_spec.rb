require_relative 'spec_helper'

describe LineItem do
  it { should have_property :id }
  it { should belong_to :asset }
  it { should belong_to :reservation }
end