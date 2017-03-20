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

class User < ApplicationRecord
  include HasLoginName

  has_one :account, required: true
  has_many :oauth_accounts
  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner
end
