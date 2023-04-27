# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Model::ClassMethods do
  let(:model_class) { Class.new(Baleog::Model) }

  describe '.field' do
    it 'Adds reader' do
      expect { model_class.field :field_name }
        .to add_method(:field_name).to(model_class)
    end

    it 'Adds writter' do
      expect { model_class.field :field_name }
        .to add_method(:field_name=).to(model_class)
    end
  end

  describe '.fields' do
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
end
