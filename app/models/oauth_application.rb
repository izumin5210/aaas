# ## Schema Information
#
# Table name: `oauth_applications`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `integer`          | `not null, primary key`
# **`name`**          | `string`           | `not null`
# **`uid`**           | `string`           | `not null`
# **`secret`**        | `string`           | `not null`
# **`redirect_uri`**  | `text`             | `not null`
# **`scopes`**        | `string`           | `default(""), not null`
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
# **`owner_id`**      | `integer`          |
# **`owner_type`**    | `string`           |
#
# ### Indexes
#
# * `index_oauth_applications_on_owner_id_and_owner_type`:
#     * **`owner_id`**
#     * **`owner_type`**
# * `index_oauth_applications_on_uid` (_unique_):
#     * **`uid`**
#

class OauthApplication < Doorkeeper::Application
  # OauthApplication.find_by_sql(
  #   OauthApplication
  #   .joins(OauthApplication.with_organizations.join_sources)
  #   .joins(Organization.with_user(1).join_sources)
  #   .where(User.by_id(1))
  # )
  scope :with_organizations, -> {
    o_arel = Organization.arel_table
    arel_table.join(o_arel, Arel::Nodes::OuterJoin).on(
      Arel::Nodes::And.new([
        arel_table[:owner_type].eq(Organization.name),
        arel_table[:owner_id].eq(o_arel[:id]),
      ])
    )
  }

  scope :by_user_id, -> user_id {
    arel_table[:owner_type].eq(User.name)
      .and(arel_table[:owner_id].eq(user_id))
  }

  def to_resource
    OauthApplicationRepresenter.new(self)
  end
end
