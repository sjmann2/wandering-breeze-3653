require 'rails_helper'


# As a visitor,
# When I visit a project's show page ("/projects/:id"),
# I see that project's name and material
# And I also see the theme of the challenge that this project belongs to.
# (e.g.    Litfit
#     Material: Lamp Shade
#   Challenge Theme: Apartment Furnishings)
RSpec.describe 'the project show page' do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
  end

  describe 'User story 1' do
    describe 'When I visit a project show page' do
      describe 'I see that projects name and material' do
        describe 'I also see the theme of the challenge that this project belongs to' do
          it 'displays project name and material' do
            visit "/projects/#{@news_chic.id}"
            
            expect(page).to have_content('News Chic')
            expect(page).to have_content('Newspaper')
            expect(page).to_not have_content('Boardfit')
          end

          it 'displays the theme of the challenge the project belongs to' do
            visit "/projects/#{@news_chic.id}"
            
            expect(page).to have_content('Recycled Material')
            expect(page).to_not have_content('Apartment Furnishings')
          end
        end
      end
    end
  end

  describe 'User story 3' do
    describe 'When I visit a projects show page' do
      describe 'I see a count of the number of contestants on this project' do
        it 'lists the count of contestants on each project' do
          visit "/projects/#{@boardfit.id}"

          expect(page).to have_content('Number of Contestants: 2')
        end
      end
    end
  end
end