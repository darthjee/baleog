# frozen_string_literal: true

require 'spec_helper'

describe Baleog::Client::WithEndpoint do
  let(:client_class) { Class.new(Baleog::Client) }

  describe '#with_endpoint' do
    let(:http_method) { :get }
    let(:path)        { '/some_path' }
    let(:name)        { nil }
    let(:method_name) { nil }

    let(:options) do
      {
        name: name,
        method_name: method_name
      }.compact
    end

    context 'when a name is given' do
      let(:name) { :my_endpoint }

      it do
        expect { client_class.with_endpoint(http_method, path, **options) }
          .to add_method(name).to(client_class)
      end

      it do
        expect(client_class.with_endpoint(http_method, path, **options))
          .to be_a(Baleog::Client::Endpoint)
      end
    end

    context 'when a name and method name are given' do
      let(:name)        { :my_endpoint }
      let(:method_name) { :my_method }

      it do
        expect { client_class.with_endpoint(http_method, path, **options) }
          .to add_method(method_name).to(client_class)
      end

      it do
        expect { client_class.with_endpoint(http_method, path, **options) }
          .not_to add_method(name).to(client_class)
      end
    end

    context 'when no meethod name or name is given' do
      it do
        expect { client_class.with_endpoint(http_method, path, **options) }
          .not_to raise_error
      end
    end
  end
end
