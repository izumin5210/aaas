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
  validates :id,
    uniqueness: true,
    login_name_format: true

  class << self
    def namable_classes
      [User]
    end

    def attribute_name
      :login_name
    end
  end
end
