# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::CoursesController, type: :controller do
  describe "GET #index" do
    let!(:course) { create(:course) }

    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "returns all courses" do
      get :index
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(1)
      expect(parsed_response.first["course"]).to eq(course.name)
    end
  end

  describe "POST #create" do
    let(:valid_attributes) { { name: 'Course1' } }

    context "with valid parameters" do
      it "creates a new Course" do
        expect {
          post :create, params: valid_attributes
        }.to change(Course, :count).by(1)
      end

      it "renders a JSON response with the new course" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { name: '' } }

      it "does not create a new Course" do
        expect {
          post :create, params: invalid_attributes
        }.to change(Course, :count).by(0)
      end

      it "renders a JSON response with errors for the new course" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end