require 'rails_helper'

RSpec.describe Admin::StudentsController, type: :controller do
  describe "GET #index" do
    let!(:student) { create(:student) }

    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "returns all students" do
      get :index
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(1)
      expect(parsed_response.first["student"]).to eq(student.full_name)
      expect(parsed_response.first["courses"]).to eq([])
    end
  end

  describe "POST #create" do
    let(:valid_attributes) { { first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', password: 'password'  } }

    context "with valid parameters" do
      it "creates a new Student" do
        expect {
          post :create, params: { student: valid_attributes }
        }.to change(Student, :count).by(1)
      end

      it "renders a JSON response with the new student" do
        post :create, params: { student: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { first_name: '' } }

      it "does not create a new Student and raises exception" do
        expect {
          post :create, params: { student: invalid_attributes }
        }.to change(Student, :count).by(0)
      end

      it "renders a JSON response with errors for the new student" do
        post :create, params: { student: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "POST #enroll" do
    let!(:student) { create(:student) }
    let!(:course) { create(:course) }

    it "enrolls a student in a course" do
      post :enroll, params: { id: student.id, course_id: course.id, year: 2021 }
      expect(response).to have_http_status(:created)
    end

    context "when enrollment is successful" do
      it "renders a JSON response with success message" do
        post :enroll, params: { id: student.id, course_id: course.id, year: 2021 }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(JSON.parse(response.body)).to eq({ "message" => "Student enrolled successfully" })
      end
    end

    context "when enrollment fails" do

      it "renders a JSON response with failure message" do
        post :enroll, params: { id: 0, course_id: course.id, year: 2021 }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    describe "POST #grade_quarter" do
      let!(:student) { create(:student) }
      let!(:course) { create(:course) }
      let!(:course_student) { create(:course_student, student: student, course: course, year: 2021) }

      it "updates the student's grade for a course" do
        post :grade_quarter, params: { id: student.id, course_id: course.id, year: 2021, quarter: 1, grade: 9 }
        expect(response).to have_http_status(:ok)
      end

      context "when grade update is successful" do
        it "renders a JSON response with success message" do
          post :grade_quarter, params: { id: student.id, course_id: course.id, year: 2021, quarter: 1, grade: 9 }
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including("application/json"))
          expect(JSON.parse(response.body)).to eq({ "message" => "Grade updated successfully" })
        end
      end
    end
  end
end