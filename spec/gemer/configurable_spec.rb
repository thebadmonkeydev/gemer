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

  context 'self#setup_config' do
    before do
      TestModule.setup_config do |c|
        c.attr :test_attr, 'foo'
        c.read_only :bar, 123
      end
    end

    it 'should create methods on module' do
      expect(TestModule).to respond_to :test_attr
      expect(TestModule).to respond_to :test_attr=
      expect(TestModule).to respond_to :bar
    end

    it 'should allow configuring values' do
      TestModule.configure do |c|
        expect{ c.test_attr = 'baz' }.to_not raise_error
        expect{ c.bar = 321 }.to raise_error NoMethodError
      end
    end
  end
end
