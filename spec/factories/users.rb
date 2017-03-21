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

FactoryGirl.define do
  factory :user do
    before(:create) { |u| LoginName.create!(id: u.login_name).errors }
    login_name { FFaker::InternetSE.login_user_name }
    name { FFaker::Name.name }

    trait :with_account do
      account { build(:account) }
    end
  end
end
