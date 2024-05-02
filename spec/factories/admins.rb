# frozen_string_literal: true

FactoryBot.define do
  factory :admin, class: Admin do
    first_name { "John" }
    last_name { "Doe" }
    email { "admin@admin.com" }
    password { "password" }
  end
end