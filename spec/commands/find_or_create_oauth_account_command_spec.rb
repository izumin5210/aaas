require 'rails_helper'

RSpec.describe FindOrCreateOauthAccountCommand, type: :command do
  include AuthHashMock::GitHub
  using RSpec::Parameterized::TableSyntax

  let(:current_user) { nil }

  let(:cmd) { FindOrCreateOauthAccountCommand.run(auth_hash: auth_hash, user: current_user) }
  subject { cmd }

  shared_context 'user registered' do
    let(:login_name) { 'loginuser' }
    let(:email) { 'loginuser@example.com' }
    let(:email_and_password_registered) { false }
    let(:account) do
      Account.new(
        email: email,
        password: 'password',
        password_confirmation: 'password',
        email_and_password_registered: email_and_password_registered,
      )
    end
    let!(:user) do
      LoginName.create!(id: login_name)
      User.create!(login_name: login_name, account: account)
    end
  end

  shared_context 'oauth_account exists' do
    let(:prev_name) { "prev-#{info['name']}" }
    let(:prev_nickname) { "prev-#{nickname}" }
    let(:login_name) { prev_nickname }
    let(:oauth_account) do
      OauthAccount.new(
        uid: uid,
        provider: provider,
        name: prev_name,
        nickname: prev_nickname,
        credentials: credentials.to_json,
        raw_info: raw_info.to_json,
      )
    end

    before do
      user.oauth_accounts << oauth_account
    end
  end

  context 'when the user has not logged in' do
    context 'when the oauth account has not registered' do
      where(:record_class, :count) do
        User         | 1
        LoginName    | 1
        Account      | 1
        OauthAccount | 1
      end

      with_them do
        it { expect { subject }.to change { record_class.count }.by(count) }
      end

      it { is_expected.to be_success }

      describe 'user' do
        subject { cmd.user }
        it { is_expected.to be_persisted }
        its(:account) { is_expected.to be_persisted }
        its('oauth_accounts.size') { is_expected.to eq 1 }
      end

      describe 'oauth_account' do
        subject { cmd.oauth_account }
        it { is_expected.to be_persisted }
        its(:name) { is_expected.to eq info['name'] }
        its(:nickname) { is_expected.to eq nickname }
        its(:credentials) { is_expected.to eq credentials.to_json }
        its(:raw_info) { is_expected.to eq raw_info.to_json }
      end

      context 'when the oauth account nickname has been taken' do
        include_context 'user registered'
        let(:login_name) { nickname }

        where(:record_class, :count) do
          User         | 0
          LoginName    | 0
          Account      | 0
          OauthAccount | 0
        end

        it { is_expected.to_not be_success }

        with_them do
          it { expect { subject }.to change { record_class.count }.by(count) }
        end

        its(:user) { is_expected.to_not be_persisted }
        its(:oauth_account) { is_expected.to_not be_persisted }

        describe 'errors' do
          subject { cmd.errors }
          it { is_expected.to be_key(:login_name) }
          its(:size) { is_expected.to eq 1 }
        end
      end
    end

    context 'when the oauth account has registered' do
      include_context 'user registered'
      include_context 'oauth_account exists'

      where(:record_class, :count) do
        User         | 0
        LoginName    | 0
        Account      | 0
        OauthAccount | 0
      end

      with_them do
        it { expect { subject }.to change { record_class.count }.by(count) }
      end

      it { is_expected.to be_success }
      its('user.login_name') { is_expected.to eq login_name }
      its('oauth_account.nickname') { is_expected.to eq nickname }

      describe 'account' do
        subject { cmd.account }

        context 'when an email has not been registered to account' do
          let(:email) { oauth_account.email_dummy }
          its(:email) { is_expected.to eq email }
          its(:email_and_password_registered) { is_expected.to be false }
        end

        context 'when an email has been regsitered to the account' do
          let(:email_and_password_registered) { true }
          its(:email) { is_expected.to eq email }
          its(:email) { is_expected.to_not eq oauth_account.email_dummy }
          its(:email_and_password_registered) { is_expected.to be true }
        end
      end
    end
  end

  context 'when the user has logged in' do
    include_context 'user registered'
    let(:current_user) { user }

    context 'when the oauth account has not registered' do
      where(:record_class, :count) do
        User         | 0
        LoginName    | 0
        Account      | 0
        OauthAccount | 1
      end

      with_them do
        it { expect { subject }.to change { record_class.count }.by(count) }
      end

      it { is_expected.to be_success }

      context 'when the user has other oauth account' do
        where(:record_class, :count) do
          User         | 0
          LoginName    | 0
          Account      | 0
          OauthAccount | 1
        end

        with_them do
          it { expect { subject }.to change { record_class.count }.by(count) }
        end

        it { is_expected.to be_success }
      end
    end

    context 'when the oauth account has registered' do
      include_context 'oauth_account exists'

      where(:record_class, :count) do
        User         | 0
        LoginName    | 0
        Account      | 0
        OauthAccount | 0
      end

      with_them do
        it { expect { subject }.to change { record_class.count }.by(count) }
      end

      it { is_expected.to be_success }
    end
  end
end
