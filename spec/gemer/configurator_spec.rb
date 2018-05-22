require 'spec_helper'

module AttrTestModule; end
module ReadOnlyTestModule; end

RSpec.describe Gemer::Configurator do
  let(:mod)     { AttrTestModule }

  subject { described_class.new(mod) }

  describe '#define_configuration_error' do
    before { subject.define_configuration_error }

    it 'should create the error sub-class' do
      expect{ AttrTestModule.const_get('ConfigError') }.to_not raise_error
    end
  end

  describe '#attr' do
    let(:mod)     { AttrTestModule }
    let(:name)    { 'test_attr' }
    let(:default) { nil }
    let(:opts)    { Hash.new }

    before { subject.attr(name, default, opts) }

    it 'should define a reader' do
      expect(mod).to respond_to :test_attr
      expect(mod.test_attr).to eq nil
    end

    it 'should define a writer' do
      expect(mod).to respond_to :test_attr=
    end

    context 'default is given' do
      let(:default) { 'foo' }

      it 'should set the value' do
        expect(mod.test_attr).to eq 'foo'
      end
    end

    context 'with opts[in]' do
      let(:opts) do
        {
          in: [true, false]
        }
      end

      context 'setting value in possible values' do
        it 'should set the value' do
          mod.test_attr = true
          expect(mod.test_attr).to eq true
        end
      end

      context 'setting value not in possible values' do
        it 'should raise an error' do
          expect{ mod.test_attr = 'foo' }.to raise_error 'value for AttrTestModule.test_attr is invalid, must be one of [true, false]'
        end
      end
    end
  end

  describe '#read_only' do
    let(:mod)   { ReadOnlyTestModule }
    let(:name)  { 'test_attr' }
    let(:value) { 'foo' }

    before { subject.read_only(name, value) }

    it 'should define a reader' do
      expect(mod).to respond_to :test_attr
      expect(mod.test_attr).to eq 'foo'
    end

    it 'should not define a writer' do
      expect(mod).to_not respond_to :test_attr=
    end
  end
end
