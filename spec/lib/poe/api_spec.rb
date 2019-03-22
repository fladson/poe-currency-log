# frozen_string_literal: true

require 'rails_helper'

RSpec.describe POE::API do
  let(:api) { described_class.new(session) }

  describe '#client' do
    subject { api.client }

    let(:session) { 'any_session' }

    it 'returns a connection with a poe host' do
      expect(subject.host).to eq('www.pathofexile.com')
    end

    it 'returns a connection with a POESESSID Cookie' do
      expect(subject.headers['Cookie']).to eq("POESESSID=#{session}")
    end

    it 'returns a json content type connection' do
      expect(subject.headers['Content-type']).to eq('application/json')
    end
  end

  context 'when valid session' do
    let(:session) { 'valid_session' }

    describe '#account_name' do
      it 'returns a valid account name' do
        VCR.use_cassette 'account name' do
          expect(api.account_name).to eq('fladsongomes')
        end
      end
    end

    describe '#chars' do
      it 'returns an array with all characters' do
        VCR.use_cassette 'characters' do
          expect(api.chars.length).to eq(4)
        end
      end
    end

    describe '#stash_tabs' do
      subject { api.stash_tabs(account_name, league) }

      context 'when valid params' do
        let(:account_name) { 'valid_account_name' }
        let(:league) { 'valid_league' }

        it 'returns the correct number of tabs' do
          VCR.use_cassette 'stash tabs' do
            expect(api.stash_tabs(account_name, league).size).to eq(16)
          end
        end
      end

      context 'when invalid params' do
        describe 'invalid account name' do
          let(:account_name) { 'invalid_account_name' }
          let(:league) { 'valid_league' }

          it 'raises a InvalidSession exception' do
            VCR.use_cassette 'invalid account name stash tabs' do
              expect { subject }.to raise_error(POE::Error::InvalidSession)
            end
          end
        end

        describe 'invalid league' do
          let(:account_name) { 'valid_account_name' }
          let(:league) { 'invalid_league' }

          it 'raises a InvalidParams exception' do
            VCR.use_cassette 'invalid league stash tabs' do
              expect { subject }.to raise_error(POE::Error::InvalidParams)
            end
          end
        end
      end
    end

    describe '#number_of_tabs' do
      subject { api.number_of_tabs(account_name, league) }

      context 'when valid params' do
        let(:account_name) { 'valid_account_name' }
        let(:league) { 'valid_league' }

        it 'returns the correct number of tabs' do
          VCR.use_cassette 'number of tabs' do
            expect(subject).to eq(16)
          end
        end
      end

      context 'when invalid params' do
        describe 'invalid account name' do
          let(:account_name) { 'invalid_account_name' }
          let(:league) { 'valid_league' }

          it 'raises a InvalidSession exception' do
            VCR.use_cassette 'invalid account name number of tabs' do
              expect { subject }.to raise_error(POE::Error::InvalidSession)
            end
          end
        end

        describe 'invalid league' do
          let(:account_name) { 'valid_account_name' }
          let(:league) { 'invalid_league' }

          it 'raises a InvalidParams exception' do
            VCR.use_cassette 'invalid league number of tabs' do
              expect { subject }.to raise_error(POE::Error::InvalidParams)
            end
          end
        end
      end
    end
  end

  context 'when invalid session' do
    let(:session) { 'valid_session' }

    describe '#account_name' do
      it 'raises a POE::InvalidSession exception' do
        VCR.use_cassette 'invalid account name' do
          expect { api.account_name }.to raise_error(POE::Error::InvalidSession)
        end
      end
    end

    describe '#chars' do
      it 'raises a POE::InvalidSession exception' do
        VCR.use_cassette 'invalid characters' do
          expect { api.chars }.to raise_error(POE::Error::InvalidSession)
        end
      end
    end

    describe '#stash_tabs' do
      let(:account_name) { 'valid_account_name' }
      let(:league) { 'valid_league' }

      it 'raises a InvalidSession exception' do
        VCR.use_cassette 'invalid session stash tabs' do
          expect { api.stash_tabs(account_name, league) }.to raise_error(POE::Error::InvalidSession)
        end
      end
    end

    describe '#number_of_tabs' do
      let(:account_name) { 'valid_account_name' }
      let(:league) { 'valid_league' }

      it 'raises a InvalidSession exception' do
        VCR.use_cassette 'invalid session number of tabs' do
          expect { api.number_of_tabs(account_name, league) }.to raise_error(POE::Error::InvalidSession)
        end
      end
    end
  end
end
