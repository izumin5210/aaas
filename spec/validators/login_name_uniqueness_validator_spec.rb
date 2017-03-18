require 'rails_helper'

RSpec.describe LoginNameUniquenessValidator, type: :validator do

  create_temp_table :dummy_names, id: :string do |t|
  end

  create_temp_table :dummies do |t|
    t.string :value, null: false
  end

  create_temp_table :other_dummies do |t|
    t.string :value, null: false
  end

  class DummyName < ActiveRecord::Base
    class << self
      def namable_classes
        [Dummy, OtherDummy]
      end

      def attribute_name
        :value
      end
    end
  end

  class Dummy < ActiveRecord::Base
    validates :value, login_name_uniqueness: { name_class: DummyName }
  end

  class OtherDummy < ActiveRecord::Base
    validates :value, login_name_uniqueness: { name_class: DummyName }
  end

  let(:model_class) { Dummy }
  let(:value) { 'testuser' }
  let!(:login_name) { DummyName.find_or_create_by!(id: value) }

  subject do
    model_class.create(value: value)
  end

  context 'when the login_name has already been used in the same class' do
    before { Dummy.create!(value: value) }
    it { is_expected.to be_invalid }
  end

  context 'when the login_name has already been used in the other class' do
    before { OtherDummy.create!(value: value) }
    it { is_expected.to be_invalid }
  end

  context 'when the login_name has not been used' do
    it { is_expected.to be_valid }
  end
end
