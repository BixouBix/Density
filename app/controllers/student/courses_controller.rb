class Student::CoursesController < ApplicationController
  # before_action :authenticate_user!

  def index
      @courses =
        {
          years: current_user.active_years.map do |year|
            {
              year: year,
              courses: current_user.courses_for_year(year).map do |course|
                {
                  course: course.name,
                  grades: current_user.grades_for_course(course)
                }
              end
            }
          end
        }
      render json: @courses, status: :ok
  end
end
