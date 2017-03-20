# ## Schema Information
#
# Table name: `memberships`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `integer`          | `not null, primary key`
# **`user_id`**          | `integer`          | `not null`
# **`organization_id`**  | `integer`          | `not null`
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_memberships_on_organization_id`:
#     * **`organization_id`**
# * `index_memberships_on_user_id`:
#     * **`user_id`**
#

FactoryGirl.define do
  factory :membership do
    user nil
    organization nil
  end
end
