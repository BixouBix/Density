class Course < ApplicationRecord
  has_many :students, through: :course_students
  has_many :course_students

  validates :name, presence: true

  def years_imparted
    course_students.map(&:year).uniq || []
  end

  def students_by_year(year)
    course_students.where(year: year).map(&:student)
  end
end
