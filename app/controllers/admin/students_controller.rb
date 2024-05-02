class Admin::StudentsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @students = Student.all.map do |student|
      {
        student: student.full_name,
        courses: student.courses.map do |course|
          {
            course: course.name,
            year: course.course_students.find_by(user_id: student.id).year,
            grades: student.grades_for_course(course)
          }
        end
      }
    end

    render json: @students, status: :ok
  end

  def create
    @student = Student.create(student_params)

    if @student.errors.any?
      render json: @student.errors, status: :unprocessable_entity
    else
      render json: @student, status: :created
    end
  end

  def enroll
    @course_student = CourseStudent.create(student_id: params[:id], course_id: params[:course_id], year: params[:year])

    if @course_student.errors.any?
      render json: { message: @course_student.errors.map(&:message) }, status: :unprocessable_entity
    else
      render json: { message: "Student enrolled successfully" }, status: :created
    end
  end

  def grade_quarter
    @course_student = CourseStudent.find_by(student_id: params[:id], course_id: params[:course_id], year: params[:year])

    if @course_student.update!("q#{params[:quarter]}" => params[:grade])
      render json: { message: "Grade updated successfully" }, status: :ok
    else
      render json: { message: "Grade update failed" }, status: :unprocessable_entity
    end

  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :email, :password)
  end

  def student
    @student ||= Student.find(params[:id])
  end

  def course
    @course ||= Course.find(params[:course_id])
  end
end
