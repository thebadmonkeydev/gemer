require 'spec_helper'

module TestModule
  include Gemer::Configurable
end

RSpec.describe Gemer::Configurable do
  it 'should add class level `configure`' do
    expect(TestModule).to respond_to :configure
  end

  it 'should add class level `setup_config`' do
    expect(TestModule).to respond_to :setup_config
  end
end
