require 'rails_helper'

RSpec.describe CreateUserAccountCommand, type: :command do
  let(:params) do
    { login_name: login_name,
      email: email,
      password: password,
      password_confirmation: password_confirmation,
    }
  end

  let(:login_name) { 'testuser' }
  let(:email) { 'testuser@example.com' }
  let(:password) { 'password' }
  let(:password_confirmation) { 'password' }

  let(:cmd) { CreateUserAccountCommand.run(params) }
  subject { cmd }

  context 'when the login_name has already been taken' do
    before do
      LoginName.create!(id: login_name)
      account = Account.new(
        email: 'other@example.com',
        password: 'password',
        password_confirmation: 'password',
        email_and_password_registered: true,
      )
      User.create!(login_name: login_name, account: account)
    end

    it do
      is_expected.to_not be_success
      expect(cmd.user).to_not be_persisted
      expect(cmd.account).to_not be_persisted
      expect(User.count).to eq 1
      expect(Account.count).to eq 1
      expect(cmd.errors).to be_key(:login_name)
    end
  end

  context 'when the email has already been registered' do
    before do
      other_login_name = 'otheruser'
      LoginName.create!(id: other_login_name)
      account = Account.new(
        email: email,
        password: 'password',
        password_confirmation: 'password',
        email_and_password_registered: true,
      )
      User.create!(login_name: other_login_name, account: account)
    end

    it do
      is_expected.to_not be_success
      expect(cmd.user).to_not be_persisted
      expect(cmd.account).to_not be_persisted
      expect(User.count).to eq 1
      expect(Account.count).to eq 1
      expect(cmd.errors).to be_key(:email)
    end
  end

  context 'when the confirmation password is not match' do
    let(:password_confirmation) { 'invalidpassword' }

    it do
      is_expected.to_not be_success
      expect(cmd.user).to be_blank
      expect(cmd.account).to be_blank
      expect(User.count).to eq 0
      expect(Account.count).to eq 0
      expect(cmd.errors).to be_key(:password_confirmation)
    end
  end

  context 'when a new account has been created successfully' do
    it do
      is_expected.to be_success
      expect(cmd.user).to be_persisted
      expect(cmd.account).to be_persisted
      expect(User.count).to eq 1
      expect(Account.count).to eq 1
    end
  end
end
