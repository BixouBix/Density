# frozen_string_literal: true

# Admin::CoursesController is responsible for managing courses in the admin context.
class Admin::CoursesController < ApplicationController
  # before_action :authenticate_user!

  # GET /admin/courses
  # Returns a list of all courses along with the years they were imparted and the students who took the course each year.
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

  # POST /admin/courses
  # Creates a new course with the provided parameters.
  def create
    @course = Course.create(course_params)

    if @course.errors.any?
      render json: @course.errors, status: :unprocessable_entity
    else
      render json: @course, status: :created
    end
  end

  private

  # Strong parameters for the create action.
  def course_params
    params.permit(:name)
  end
end