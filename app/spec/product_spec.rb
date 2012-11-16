require_relative 'spec_helper'

describe Product do
  it { should have_property :id }
  it { should have_property :model_name }
  it { should have_property :manufacturer }

  it { should have_many :assets }
end