require 'rails_helper'

RSpec.describe LoginNameFormatValidator, type: :validator do
  using RSpec::Parameterized::TableSyntax

  where(:value, :be_valid_or_invalid) do
    ''       | be_invalid
    'a'      | be_valid
    'aa'     | be_valid
    'aaa'    | be_valid
    'a' * 39 | be_valid
    'a' * 40 | be_invalid
    'a-'     | be_invalid
    '-a'     | be_invalid
    'a-a'    | be_valid
    'a--a'   | be_invalid
    'a-a-a'  | be_valid
    'a_a-a'  | be_invalid
    'aあa-a' | be_invalid
    '0123'   | be_valid
    '0123aa' | be_valid
    '012-3'  | be_valid
    '-0123'  | be_invalid
    '0123-'  | be_invalid
  end

  with_them do
    it { is_expected.to be_valid_or_invalid }
  end
end
