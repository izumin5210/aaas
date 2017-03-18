class CreateUserAccountCommand
  include ApplicationCommand

  attr_reader :user, :account,
    :login_name, :email, :password, :password_confirmation

  validates :login_name,
    presence: true,
    login_name_format: true
  validates :email,
    presence: true
  validates :password,
    presence: true,
    confirmation: true

  def initialize(params)
    @login_name = params[:login_name]
    @email = params[:email]
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
  end

  def run
    ActiveRecord::Base.transaction { transaction! }
  rescue => e
    e.record.errors.each do |attr, error|
      errors.add(attr, error)
    end
  end

  private

  def transaction!
    find_or_create_login_name
    @user = build_user 
    @account = build_account
    user.save!
    account.save!
  end

  def find_or_create_login_name
    LoginName.find_or_create_by(id: login_name)
  end

  def build_user
    User.new(login_name: login_name)
  end

  def build_account
    Account.new(
      user: user,
      email: email,
      password: password,
      password_confirmation: password_confirmation,
    )
  end
end
