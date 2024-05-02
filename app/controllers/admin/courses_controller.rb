class Admin::CoursesController < ApplicationController
  # before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @courses = Course.all.map do |course|
      {
        course: course.name,
        years: course.years_imparted.map do |course_year|
          {
            year: course_year,
            students: course.students_by_year(course_year).map(&:full_name)
          }
        end
      }
    end

    render json: @courses, status: :ok
  end

  def create
    @course = Course.create(course_params)

    if @course.errors.any?
      render json: @course.errors, status: :unprocessable_entity
    else
      render json: @course, status: :created
    end
  end

  private

  def course_params
    params.permit(:name)
  end
end
