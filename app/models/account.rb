# ## Schema Information
#
# Table name: `accounts`
#
# ### Columns
#
# Name                                 | Type               | Attributes
# ------------------------------------ | ------------------ | ---------------------------
# **`id`**                             | `integer`          | `not null, primary key`
# **`email`**                          | `string`           | `default(""), not null`
# **`encrypted_password`**             | `string`           | `default(""), not null`
# **`reset_password_token`**           | `string`           |
# **`reset_password_sent_at`**         | `datetime`         |
# **`remember_created_at`**            | `datetime`         |
# **`sign_in_count`**                  | `integer`          | `default("0"), not null`
# **`current_sign_in_at`**             | `datetime`         |
# **`last_sign_in_at`**                | `datetime`         |
# **`current_sign_in_ip`**             | `inet`             |
# **`last_sign_in_ip`**                | `inet`             |
# **`created_at`**                     | `datetime`         | `not null`
# **`updated_at`**                     | `datetime`         | `not null`
# **`user_id`**                        | `integer`          | `not null`
# **`email_and_password_registered`**  | `boolean`          | `default("false"), not null`
#
# ### Indexes
#
# * `index_accounts_on_email` (_unique_):
#     * **`email`**
# * `index_accounts_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
# * `index_accounts_on_user_id` (_unique_):
#     * **`user_id`**
#

class Account < ApplicationRecord
  belongs_to :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
