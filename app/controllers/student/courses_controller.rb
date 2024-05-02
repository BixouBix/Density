# frozen_string_literal: true
class Student::CoursesController < ApplicationController
  before_action :authenticate_user!

  # GET /student/courses
  # Returns a list of all courses that the current student is enrolled in, grouped by year.
  # For each course, it also returns the grades that the student received.
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
