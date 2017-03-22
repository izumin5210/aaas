module HasLoginName
  extend ActiveSupport::Concern

  included do
    validates LoginName.attribute_name,
      presence: true,
      uniqueness: true,
      login_name_format: true,
      login_name_uniqueness: { name_class: LoginName, column: :id }

    before_validation do |resource|
      LoginName.find_or_create_by(id: resource.send(LoginName.attribute_name))
    end
  end
end
