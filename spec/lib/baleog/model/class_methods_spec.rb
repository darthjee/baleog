# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Model::ClassMethods do
  let(:model_class) { Class.new(Baleog::Model) }

  describe '#build' do
    it do
      expect(Baleog::Model.build < Baleog::Model).to be_truthy
    end

    it 'adds a value wrapper' do
      expect(Baleog::Model.build::ValueWrapper < Baleog::Model::ValueWrapper)
        .to be_truthy
    end
  end

  describe '#field' do
    it 'Adds reader' do
      expect { model_class.field :field_name }
        .to add_method(:field_name).to(model_class)
    end

    it 'Adds writter' do
      expect { model_class.field :field_name }
        .to add_method(:field_name=).to(model_class)
    end
  end

  describe '#fields' do
    it 'Adds reader for the first field' do
      expect { model_class.fields :field_name, :other_field }
        .to add_method(:field_name).to(model_class)
    end

    it 'Adds reader for the other field' do
      expect { model_class.fields :field_name, :other_field }
        .to add_method(:other_field).to(model_class)
    end

    it 'Adds writter for the first field' do
      expect { model_class.fields :field_name, :other_field }
        .to add_method(:field_name=).to(model_class)
    end

    it 'Adds writter for the other field' do
      expect { model_class.fields :field_name, :other_field }
        .to add_method(:other_field=).to(model_class)
    end
  end

  describe '#from' do
    let(:array) { [hash] }
    let(:hash)  { { field: value } }
    let(:value) { :value }
    let(:model_class) do
      Class.new(Baleog::Model) do
        field :field
      end
    end

    context 'when nil is given' do
      let(:object) { nil }

      it { expect(model_class.from(object)).to be_nil }
    end

    context 'when a hash is given' do
      let(:object) { hash }

      it { expect(model_class.from(object)).to be_a(model_class) }

      it 'ínitializes the model with the correct value' do
        expect(model_class.from(object))
          .to eq(model_class.new(hash))
      end
    end

    context 'when a JSON for a hash is given' do
      let(:object) { hash.to_json }

      it { expect(model_class.from(object)).to be_a(model_class) }

      it 'ínitializes the model with the correct value' do
        expect(model_class.from(object))
          .to eq(model_class.new(JSON.parse(object)))
      end
    end

    context 'when an array is given' do
      let(:object) { array }

      it { expect(model_class.from(object)).to be_a(Array) }
      it { expect(model_class.from(object)).to all(be_a(model_class)) }

      it 'ínitializes the model with the correct value' do
        expect(model_class.from(object).first)
          .to eq(model_class.new(hash))
      end
    end

    context 'when a JSON for an array is given' do
      let(:object) { array.to_json }

      it { expect(model_class.from(object)).to be_a(Array) }
      it { expect(model_class.from(object)).to all(be_a(model_class)) }

      it 'ínitializes the model with the correct value' do
        expect(model_class.from(object).first)
          .to eq(model_class.new(JSON.parse(hash.to_json)))
      end
    end
  end
end
