require 'spec_helper'

module LemonSqueezer
  describe Wallet do
    let(:main_wallet) { LemonSqueezer::Wallet.new({id: 'sc', email: 'society@lemonway.fr', config_name: :EUR, public_ip: '46.101.130.8'}) }
    let(:default_wallet) { LemonSqueezer::Wallet.new({id: 'sc', email: 'society@lemonway.fr'}) }
    let(:invalid_wallet) { LemonSqueezer::Wallet.new({id: 'erratum', email: 'erratum@erratum.com', config_name: :EUR, public_ip: '46.101.130.8'}) }
    let(:no_wallet) { LemonSqueezer::Wallet.new }
    let(:shortcut_wallet_get_details) {
      LemonSqueezer.wallet_get_details(
                                        {
                                          id: 'sc',
                                          email: 'society@lemonway.fr',
                                          config_name: :EUR,
                                          public_ip: '46.101.130.8'
                                        }
                                      )
    }
    let(:register_wallet_company) {
      LemonSqueezer::Wallet.new(
                                  {
                                    id: random_string,
                                    email: random_email,
                                    first_name: random_string,
                                    last_name: random_string,
                                    birthdate: random_date,
                                    nationality: 'FRA',
                                    country: 'FRA',
                                    is_company: 1,
                                    company_name: random_string,
                                    company_website: 'https://example.com',
                                    company_description: random_string,
                                    payer_or_beneficiary: 2,
                                    technical: 1,
                                    config_name: :EUR,
                                    public_ip: '46.101.130.8'
                                  }
                                )
    }
    let(:register_wallet) {
      LemonSqueezer::Wallet.new(
                                  {
                                    id: random_string,
                                    email: random_email,
                                    first_name: random_string,
                                    last_name: random_string,
                                    birthdate: random_date,
                                    nationality: 'FRA',
                                    country: 'FRA',
                                    is_company: 0,
                                    payer_or_beneficiary: 1,
                                    technical: 1,
                                    config_name: :EUR,
                                    public_ip: '46.101.130.8'
                                  }
                                )
    }
    let(:register_existing_wallet) {
      LemonSqueezer::Wallet.new(
                                  {
                                    id: 'sc',
                                    email: 'society@lemonway.fr',
                                    first_name: random_string,
                                    last_name: random_string,
                                    birthdate: random_date,
                                    nationality: 'FRA',
                                    country: 'FRA',
                                    is_company: 0,
                                    payer_or_beneficiary: 1,
                                    config_name: :EUR,
                                    public_ip: '46.101.130.8'
                                  }
                                )
    }
    let(:shortcut_wallet_register) {
      LemonSqueezer.wallet_register(
                                      {
                                        id: random_string,
                                        email: random_email,
                                        first_name: random_string,
                                        last_name: random_string,
                                        birthdate: random_date,
                                        nationality: 'FRA',
                                        country: 'FRA',
                                        is_company: 0,
                                        payer_or_beneficiary: 1,
                                        config_name: :EUR,
                                        public_ip: '46.101.130.8'
                                      }
                                    )
    }
    let(:update_details_wallet) {
      LemonSqueezer::Wallet.new(
                                  {
                                    id: shortcut_wallet_register.id,
                                    email: shortcut_wallet_register.email,
                                    first_name: random_string,
                                    last_name: random_string,
                                    birthdate: random_date,
                                    nationality: 'FRA',
                                    country: 'FRA',
                                    is_company: 0,
                                    payer_or_beneficiary: 1,
                                    technical: 1,
                                    config_name: :EUR,
                                    public_ip: '46.101.130.8'
                                  }
                                )
    }
    let(:shortcut_wallet_update_details) {
      LemonSqueezer.wallet_update_details(
                                      {
                                        id: shortcut_wallet_register.id,
                                        email: shortcut_wallet_register.email,
                                        first_name: random_string,
                                        last_name: random_string,
                                        birthdate: random_date,
                                        nationality: 'FRA' ,
                                        country: 'FRA',
                                        is_company: 0,
                                        payer_or_beneficiary: 1,
                                        config_name: :EUR,
                                        public_ip: '46.101.130.8'
                                      }
                                    )
    }
    let(:no_update_details_wallet) { LemonSqueezer::Wallet.new }
    let(:update_status_wallet) { LemonSqueezer::Wallet.new({id: register_wallet.register.id, new_status: 12, config_name: :EUR, public_ip: '46.101.130.8'}) }
    let(:invalid_update_status_wallet) { LemonSqueezer::Wallet.new({id: register_wallet.register.id, new_status: 404, config_name: :EUR, public_ip: '46.101.130.8'}) }
    let(:no_update_status_wallet) { LemonSqueezer::Wallet.new }
    let(:shortcut_wallet_update_status) {
      LemonSqueezer.wallet_update_status({id: register_wallet.register.id, new_status: 12, config_name: :EUR, public_ip: '46.101.130.8'})
    }
    let(:file_to_upload) { Base64.encode64(File.open('./spec/fixtures/files/upload_test.pdf', 'rb').read) }
    let(:upload_file_wallet) { LemonSqueezer::Wallet.new({id: register_wallet.register.id, file_name: 'upload_test.pdf', type: 'id_card', buffer: file_to_upload, config_name: :EUR, public_ip: '46.101.130.8' }) }
    let(:invalid_upload_file_wallet) { LemonSqueezer::Wallet.new({id: register_wallet.register.id, file_name: 'upload_test.pdf', type: 'toto', buffer: file_to_upload, config_name: :EUR, public_ip: '46.101.130.8' }) }
    let(:no_upload_file_wallet) { LemonSqueezer::Wallet.new }
    let(:shortcut_wallet_upload_file) {
      LemonSqueezer.wallet_upload_file({id: register_wallet.register.id, file_name: 'upload_test.pdf', type: 'id_card', buffer: file_to_upload, config_name: :EUR, public_ip: '46.101.130.8' })
    }

    describe ':DEFAULT' do
      it 'returns a LemonSqueezer::Wallet object' do
        expect(default_wallet.get_details).to be_a(LemonSqueezer::Wallet)
      end
    end

    describe '#get_details' do
      it 'returns a LemonSqueezer::Wallet object' do
        expect(main_wallet.get_details).to be_a(LemonSqueezer::Wallet)
      end

      it 'shortcut return a LemonSqueezer::Wallet object' do
        expect(shortcut_wallet_get_details).to be_a(LemonSqueezer::Wallet)
      end

      it 'get details of main wallet' do
        main_wallet.get_details
        expect(main_wallet.id).to be_a(String)
        expect(main_wallet.balance).to be_a(Float)
        expect(main_wallet.name).to be_a(String)
        expect(main_wallet.email).to be_a(String)
        expect(main_wallet.ibans).to eq(nil)
        expect(main_wallet.status).to be_a(Integer)
        expect([true, false]).to include(main_wallet.blocked)
        expect(main_wallet.error).to be_nil
      end

      it 'return an error' do
        invalid_wallet.get_details
        expect(invalid_wallet.error).to be_a(Hash)
        expect(invalid_wallet.error[:code]).not_to eq -1
      end

      it 'return an error 250' do
        no_wallet.get_details
        expect(no_wallet.error).to be_a(Hash)
        expect(no_wallet.error[:code]).to eq -1
      end
    end

    describe '#register' do
      it 'returns a LemonSqueezer::Wallet object' do
        expect(register_wallet.register).to be_a(LemonSqueezer::Wallet)
      end

      it 'returns a LemonSqueezer::Wallet object (company)' do
        expect(register_wallet_company.register).to be_a(LemonSqueezer::Wallet)
      end

      it 'shortcut return a LemonSqueezer::Wallet object' do
        expect(shortcut_wallet_register).to be_a(LemonSqueezer::Wallet)
      end

      it 'get details of main wallet' do
        register_wallet.register
        expect(register_wallet.id).to be_a(String)
        expect(register_wallet.lwid).to be_a(String)
        expect(register_wallet.error).to be_nil
      end

      it 'get details of main wallet company' do
        register_wallet_company.register
        expect(register_wallet_company.id).to be_a(String)
        expect(register_wallet_company.lwid).to be_a(String)
        expect(register_wallet_company.error).to be_nil
      end

      it 'return an error' do
        register_existing_wallet.register
        expect(register_existing_wallet.error).to be_a(Hash)
        expect(register_existing_wallet.error[:code]).not_to eq -1
      end

      it 'return an error 250' do
        no_wallet.register
        expect(no_wallet.error).to be_a(Hash)
        expect(no_wallet.error[:code]).to eq -1
      end
    end

    describe '#update_details' do
      it 'returns a LemonSqueezer::Wallet object' do
        expect(update_details_wallet.update_details).to be_a(LemonSqueezer::Wallet)
      end

      it 'shortcut return a LemonSqueezer::Wallet object' do
        expect(shortcut_wallet_update_details).to be_a(LemonSqueezer::Wallet)
      end

      it 'update status to rspecwallet_tech' do
        update_details_wallet.update_details
        expect(update_details_wallet.id).to be_a(String)
        expect(update_details_wallet.lwid).to be_a(String)
        expect(update_details_wallet.error).to be_nil
        
        updated_details_wallet = LemonSqueezer::Wallet.new(
                                  {
                                    id: shortcut_wallet_register.id,
                                    email: shortcut_wallet_register.email,
                                    config_name: :EUR,
                                    public_ip: '46.101.130.8'
                                  }
                                ).get_details
                                
        expect(updated_details_wallet.first_name).to eq(update_details_wallet.first_name.capitalize)
        expect(updated_details_wallet.first_name).to_not eq(shortcut_wallet_register.first_name.capitalize)
      end

      it 'return an error 250' do
        no_update_details_wallet.update_details
        expect(no_update_details_wallet.error).to be_a(Hash)
        expect(no_update_details_wallet.error[:code]).to eq -1
      end
    end

    describe '#update_status' do
      it 'returns a LemonSqueezer::Wallet object' do
        expect(update_status_wallet.update_status).to be_a(LemonSqueezer::Wallet)
      end

      it 'shortcut return a LemonSqueezer::Wallet object' do
        expect(shortcut_wallet_update_status).to be_a(LemonSqueezer::Wallet)
      end

      it 'update status to rspecwallet_tech' do
        update_status_wallet.update_status
        expect(update_status_wallet.id).to be_a(String)
        expect(update_status_wallet.error).to be_nil
      end

      it 'return an error' do
        invalid_update_status_wallet.update_status
        expect(invalid_update_status_wallet.error).to be_a(Hash)
        expect(invalid_update_status_wallet.error[:code]).not_to eq -1
      end

      it 'return an error 250' do
        no_update_status_wallet.update_status
        expect(no_update_status_wallet.error).to be_a(Hash)
        expect(no_update_status_wallet.error[:code]).to eq -1
      end
    end

    describe '#upload_file' do
      it 'returns a LemonSqueezer::Wallet object' do
        expect(upload_file_wallet.upload_file).to be_a(LemonSqueezer::Wallet)
      end

      it 'shortcut return a LemonSqueezer::Wallet object' do
        expect(shortcut_wallet_upload_file).to be_a(LemonSqueezer::Wallet)
      end

      it 'update file to rspecwallet' do
        upload_file_wallet.upload_file
        expect(upload_file_wallet.document_id).to be_a(String)
        expect(upload_file_wallet.error).to be_nil
      end

      it 'return an error' do
        invalid_upload_file_wallet.upload_file
        expect(invalid_upload_file_wallet.error).to be_a(Hash)
        expect(invalid_upload_file_wallet.error[:code]).not_to eq -1
      end

      it 'return an error 250' do
        no_upload_file_wallet.upload_file
        expect(no_upload_file_wallet.error).to be_a(Hash)
        expect(no_upload_file_wallet.error[:code]).to eq -1
      end
    end
  end
end
