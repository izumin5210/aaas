# ## Schema Information
#
# Table name: `login_names`
#
# ### Columns
#
# Name      | Type               | Attributes
# --------- | ------------------ | ---------------------------
# **`id`**  | `string`           | `not null, primary key`
#

class LoginName < ApplicationRecord
  validates :id, uniqueness: true, login_name_format: true
end
