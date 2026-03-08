%w[イオン Amazon].each do |name|
  Payee.find_or_create_by!(name: name)
end
