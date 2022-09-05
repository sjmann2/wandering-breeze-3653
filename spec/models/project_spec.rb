require 'rails_helper'

RSpec.describe Project, type: :model do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :material}
  end

  describe "relationships" do
    it {should belong_to :challenge}
    it {should have_many :contestant_projects}
    it {should have_many(:contestants).through(:contestant_projects)}
  end

  describe 'instance methods' do
    describe 'count_of_contestants' do
      it 'returns the count of contestants associated with a project' do
        expect(@boardfit.count_of_contestants).to eq(2)
      end
    end

    describe 'average_years_experience' do
      it 'returns the average years experience for all contestants on a project' do
        expect(@boardfit.average_years_experience).to eq(11.5)
      end
    end
  end
end