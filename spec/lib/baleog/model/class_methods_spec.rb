# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Model::ClassMethods do
  let(:model_class)      { Class.new(base_model_class) }
  let(:base_model_class) { Baleog::Model.build }
  let(:model)            { model_class.new(string_hash) }
  let(:value)            { SecureRandom.hex(10) }
  let(:other_value)      { SecureRandom.hex(16) }
  let(:string_hash)      { JSON.parse(hash.to_json) }
  let(:hash) do
    { field_name: value, other_key: other_value }
  end

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
    context 'when no options are give' do
      let(:block) do
        proc { model_class.field :field_name }
      end

      it 'Adds reader' do
        expect(&block)
          .to add_method(:field_name).to(model_class)
      end

      it 'Adds writter' do
        expect(&block)
          .to add_method(:field_name=).to(model_class)
      end

      context 'when the reader is called' do
        before { block.call }

        it do
          expect(model.field_name)
            .to eq(string_hash['field_name'])
        end
      end

      context 'when the writter is called' do
        before { block.call }

        it do
          expect { model.field_name = 'new value' }
            .to change(model, :field_name)
            .from(string_hash['field_name'])
            .to('new value')
        end
      end
    end

    context 'when key option is given' do
      let(:block) do
        proc { model_class.field :field_name, key: :other_key }
      end

      it 'Adds reader' do
        expect(&block)
          .to add_method(:field_name).to(model_class)
      end

      it 'Adds writter' do
        expect(&block)
          .to add_method(:field_name=).to(model_class)
      end

      context 'when the reader is called' do
        before { block.call }

        it do
          expect(model.field_name)
            .to eq(string_hash['other_key'])
        end
      end

      context 'when the writter is called' do
        before { block.call }

        it do
          expect { model.field_name = 'new value' }
            .to change(model, :field_name)
            .from(string_hash['other_key'])
            .to('new value')
        end
      end
    end

    context 'when cast option is given as :integer' do
      let(:value)       { Random.rand(10..1000).to_s }
      let(:other_value) { Random.rand(2000..3000).to_s }
      let(:new_value)   { Random.rand(4000..5000).to_s }

      let(:block) do
        proc { model_class.field :field_name, cast: :integer }
      end

      it 'Adds reader' do
        expect(&block)
          .to add_method(:field_name).to(model_class)
      end

      it 'Adds writter' do
        expect(&block)
          .to add_method(:field_name=).to(model_class)
      end

      context 'when the reader is called' do
        before { block.call }

        it do
          expect(model.field_name)
            .to eq(string_hash['field_name'].to_i)
        end
      end

      context 'when the writter is called' do
        before { block.call }

        it do
          expect { model.field_name = new_value }
            .to change(model, :field_name)
            .from(string_hash['field_name'].to_i)
            .to(new_value.to_i)
        end
      end
    end

    context 'when cast option is given as "integer"' do
      let(:value)       { Random.rand(10..1000).to_s }
      let(:other_value) { Random.rand(2000..3000).to_s }
      let(:new_value)   { Random.rand(4000..5000).to_s }

      let(:block) do
        proc { model_class.field :field_name, cast: 'integer' }
      end

      it 'Adds reader' do
        expect(&block)
          .to add_method(:field_name).to(model_class)
      end

      it 'Adds writter' do
        expect(&block)
          .to add_method(:field_name=).to(model_class)
      end

      context 'when the reader is called' do
        before { block.call }

        it do
          expect(model.field_name)
            .to eq(string_hash['field_name'].to_i)
        end
      end

      context 'when the writter is called' do
        before { block.call }

        it do
          expect { model.field_name = new_value }
            .to change(model, :field_name)
            .from(string_hash['field_name'].to_i)
            .to(new_value.to_i)
        end
      end
    end

    context 'when cast option is given as a Model class' do
      let(:value)       { { name: 'The name', age: '23' } }
      let(:other_value) { { name: 'Other name', age: '55' } }
      let(:new_value)   { { name: 'New name', age: '44' } }

      let(:block) do
        proc do
          model_class.field :field_name, cast: 'NotLoadedPerson'
          require 'not_loaded/models/not_loaded_person'
        end
      end

      it 'Adds reader' do
        expect(&block)
          .to add_method(:field_name).to(model_class)
      end

      it 'Adds writter' do
        expect(&block)
          .to add_method(:field_name=).to(model_class)
      end

      context 'when the reader is called' do
        before { block.call }

        it do
          expect(model.field_name)
            .to eq(NotLoadedPerson.new(string_hash['field_name']))
        end
      end

      context 'when the writter is called' do
        before { block.call }

        it do
          expect { model.field_name = new_value }
            .to change(model, :field_name)
            .from(NotLoadedPerson.new(string_hash['field_name']))
            .to(NotLoadedPerson.new(new_value))
        end
      end
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
