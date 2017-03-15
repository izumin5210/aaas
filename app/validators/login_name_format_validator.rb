class LoginNameFormatValidator < ActiveModel::EachValidator
  FORMAT_REGEX = /^[a-zA-Z0-9](?:[a-zA-Z0-9\-]?[a-zA-Z0-9])*$/
  LENGTH_MAX = 39

  def validate_each(record, attribute, value)
    if value.blank?
      record.errors.add(attribute, :blank)
    elsif value.size > LENGTH_MAX
      record.errors.add(attribute, :too_long, { count: value.size })
    elsif value !~ FORMAT_REGEX
      record.errors.add(attribute, :invalid)
    end
  end
end
