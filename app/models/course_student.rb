class CourseStudent < ApplicationRecord
  belongs_to :student, class_name: "User", foreign_key: "user_id", polymorphic: true
  belongs_to :course

  alias_attribute :student_id, :user_id

  validates :q1, :q2, :q3, :q4, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10, allow_nil: true }

  def grades
    grades_array = (1..4).map do |i|
      ["q#{i}", self["q#{i}"], "q#{i}_status", passing_status(self["q#{i}"])]
    end.flatten
    Hash[*grades_array]
  end

  private

  def passing_status(grade)
    return "N/A" if grade.nil?
      
    grade > 5 ? "pass" : "fail"
  end
end
