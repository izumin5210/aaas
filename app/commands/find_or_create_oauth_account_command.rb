class FindOrCreateOauthAccountCommand
  include ApplicationCommand

  attr_reader :auth_hash, :credentials, :info,
    :oauth_account, :user, :account, :access_token

  validates :auth_hash, presence: true
  validates :credentials, presence: true
  validates :info, presence: true

  def initialize(auth_hash:, user: nil)
    @auth_hash = auth_hash
    @credentials = auth_hash['credentials']
    @info = auth_hash['info']
    @user = user
  end

  def run
    ActiveRecord::Base.transaction { transaction! }
  rescue => e
    e.record.errors.each do |attr, error|
      errors.add(attr, error)
    end
  end

  private

  def login_name
    info['nickname']
  end

  def transaction!
    @oauth_account = build_oauth_account
    @user = build_user
    @account = build_account

    user.save!
    user.oauth_accounts << oauth_account
    @access_token = find_or_create_access_token!
  end

  def build_oauth_account
    OauthAccount.find_or_initialize_by(
      uid: auth_hash['uid'],
      provider: auth_hash['provider']
    ).tap do |oauth_account|
      oauth_account.name = info['name']
      oauth_account.nickname = info['nickname']
      oauth_account.email = info['email']
      case oauth_account.provider
      when 'github'
        oauth_account.url = info['urls']['GitHub']
      end
      oauth_account.image_url = info['image']
      oauth_account.access_token = credentials['token']
      oauth_account.access_secret = credentials['secret']
      oauth_account.credentials = credentials.to_json
      oauth_account.raw_info = auth_hash['extra']['raw_info'].to_json
    end
  end

  def build_user
    (user || oauth_account.user || User.new(login_name: oauth_account.nickname)).tap do |user|
      user.name ||= oauth_account.name unless user.persisted?
    end
  end

  def build_account
    if user.account.present?
      user.account
    else
      password = Devise.friendly_token[0, 20]
      Account.new(
        email: oauth_account.email_dummy,
        password: password,
        password_confirmation: password,
        email_and_password_registered: false,
        user: user,
      )
    end
  end

  def find_or_create_access_token!
    admin = Organization.admin
    app = admin.oauth_applications.first
    Doorkeeper::AccessToken.find_or_create_for(
      app,
      user.id,
      app.scopes,
      nil,
      false,
    )
  end
end
