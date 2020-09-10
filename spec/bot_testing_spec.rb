require 'telegram/bot'
describe Telegram::Bot::Exceptions::ResponseError do
  subject do
    begin
      described_class.new(response)
    rescue StandardError => e
      e
    end
  end

  let(:response) { Telegram::Bot::Api.new('123456:wrongtoken').call('getMe') }

  it 'has error code' do
    is_expected.to respond_to(:error_code)
  end
end
RSpec.describe Telegram::Bot::Api do
  let(:token) { '180956132:AAHU0_CeyQWOd6baBc9TibTPybxY9p1P8xo' }
  let(:endpoint) { 'getMe' }
  let(:api) { described_class.new(token) }

  describe '#call' do
    subject(:api_call) { api.call(endpoint) }

    it 'returns hash' do
      is_expected.to be_a(Hash)
    end

    it 'has status' do
      is_expected.to have_key('ok')
    end

    it 'has result' do
      is_expected.to have_key('result')
    end

    context 'when token is invalid' do
      let(:token) { '123456:wrongtoken' }

      it 'raises an error' do
        expect { api_call }
          .to raise_error(Telegram::Bot::Exceptions::ResponseError)
      end
    end
  end

  describe '#method_missing' do
    subject { api }

    it 'responds to endpoints' do
      is_expected.to respond_to(endpoint)
    end

    context 'when method name is in snake case' do
      let(:endpoint) { 'get_me' }

      it 'responds to snake-cased endpoints' do
        is_expected.to respond_to(endpoint)
      end
    end
  end
end
