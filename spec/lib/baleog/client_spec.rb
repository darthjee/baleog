# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Client do
  let(:client_class) { Class.new(described_class) }

  describe 'configure' do
    it 'builds a nested model class' do
      expect { client_class.configure }
        .to change { client_class::Model < Baleog::Client::Model }
        .from(false)
        .to(true)
    end
  end
end
