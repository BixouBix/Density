class Student < User
  has_many :course_students
  has_many :courses, through: :course_students

  def grades_for_course(course)
    course_students.find_by(course: course)&.grades
  end

  def active_years
    course_students.map(&:year).uniq
  end

  def courses_for_year(year)
    course_students.where(year: year).map(&:course)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
