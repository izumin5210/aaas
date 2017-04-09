# ## Schema Information
#
# Table name: `organizations`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`login_name`**  | `string`           | `not null`
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_organizations_on_login_name` (_unique_):
#     * **`login_name`**
#

class Organization < ApplicationRecord
  include HasLoginName

  ADMIN_NAMES = %w(aaas)

  has_many :memberships
  has_many :users, through: :memberships
  has_many :oauth_applications,
    as: :owner, class_name: Doorkeeper::Application.name

  validates :users, presence: true

  scope :with_user, -> user_id {
    m_arel = Membership.arel_table
    u_arel = User.arel_table
    arel_table
      .join(m_arel, Arel::Nodes::OuterJoin).on(arel_table[:id].eq(m_arel[:organization_id]))
      .join(u_arel, Arel::Nodes::OuterJoin).on(m_arel[:user_id].eq(u_arel[:id]))
  }

  def self.admin
    find_by(login_name: ADMIN_NAMES[0])
  end

  def admin?
    ADMIN_NAMES.include?(login_name)
  end
end
