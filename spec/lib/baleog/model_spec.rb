# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Model do
  let(:model_class) { Class.new(described_class) }

  describe '.field' do
    it do
      expect { model_class.field :field_name }
        .to add_method(:field_name).to(model_class)
    end

    it do
      expect { model_class.field :field_name }
        .to add_method(:field_name=).to(model_class)
    end
  end

  describe '.fields' do
    it do
      expect { model_class.fields :field_name, :other_field }
        .to add_method(:field_name).to(model_class)
    end

    it do
      expect { model_class.fields :field_name, :other_field }
        .to add_method(:other_field).to(model_class)
    end

    it do
      expect { model_class.fields :field_name, :other_field }
        .to add_method(:field_name=).to(model_class)
    end

    it do
      expect { model_class.fields :field_name, :other_field }
        .to add_method(:other_field=).to(model_class)
    end
  end

  describe '#initialize' do
    context 'when no argument is given' do
      it { expect { model_class.new }.not_to raise_error }
    end

    context 'when a hash is given' do
      it do
        expect { model_class.new({ key: :value }) }.not_to raise_error
      end
    end

    context 'when a json is given' do
      it do
        expect { model_class.new({ key: :value }.to_json) }.not_to raise_error
      end
    end
  end
end
