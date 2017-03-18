class LoginNameUniquenessValidator < ActiveModel::EachValidator
  attr_reader :record, :value, :login_name

  def validate_each(record, attribute, value)
    @record = record
    @value = value
    @login_name = name_class.find_by!(column => value)

    if used_in_other_record?
      # FIXME: I18n
      record.errors.add(attribute, :taken)
    end
  end

  private

  def name_class
    options[:name_class] || LoginName
  end

  def column
    options[:column] || :id
  end

  def namable_classes
    name_class.namable_classes
  end

  def attribute_name
    name_class.attribute_name
  end

  def used_in_other_record?
    namable_classes.any? do |klass|
      if record.is_a? klass
        klass.where(attribute_name => value).where.not(id: record.id).count > 0
      else
        klass.exists?(attribute_name => value)
      end
    end
  end
end
