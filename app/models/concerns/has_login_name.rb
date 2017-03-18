module HasLoginName
  extend ActiveSupport::Concern

  included do
    validates LoginName.attribute_name,
      presence: true,
      uniqueness: true,
      login_name_format: true,
      login_name_uniqueness: { name_class: LoginName, column: :id }
  end
end
