Organization::ADMIN_NAMES.each.with_index(1) do |login_name, i|
  LoginName.seed do |s|
    s.id = login_name
  end

  Organization.seed do |s|
    s.id = i
    s.login_name = login_name
  end
end
