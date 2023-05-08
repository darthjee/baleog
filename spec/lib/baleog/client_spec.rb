# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Client do
  describe 'inheritance' do
    it 'builds a nested model class' do
      expect(MyClient::Model < Baleog::Client::Model).to be_truthy
    end
  end
end
