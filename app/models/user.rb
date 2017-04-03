# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`login_name`**  | `string`           | `not null`
# **`name`**        | `string`           |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_users_on_login_name` (_unique_):
#     * **`login_name`**
#

class User < ApplicationRecord
  include HasLoginName

  has_one :account, required: true

  has_many :memberships
  has_many :organizations, through: :memberships

  has_many :oauth_accounts
  has_many :oauth_applications,
    as: :owner, class_name: OauthApplication.name

  def last_authorized_admin_app_token
    admin = Organization.admin
    app = admin.oauth_applications.first
    Doorkeeper::AccessToken.last_authorized_token_for(app.id, id)
  end
end
