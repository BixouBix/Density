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
end