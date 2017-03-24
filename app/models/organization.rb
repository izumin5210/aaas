# ## Schema Information
#
# Table name: `organizations`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`login_name`**  | `string`           | `not null`
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_organizations_on_login_name` (_unique_):
#     * **`login_name`**
#

class Organization < ApplicationRecord
  include HasLoginName

  has_many :memberships
  has_many :users, through: :memberships

  validates :users, presence: true
end
