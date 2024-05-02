# frozen_string_literal: true

FactoryBot.define do
  factory :course_student do
    association :student, factory: :user
    association :course
    year { 2024 }
  end
end
