class Student < User
  has_many :courses, through: :course_students

  def grades_for_course(course, year)
    course_students.where(course: course, year: year).grades
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
