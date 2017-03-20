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

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
