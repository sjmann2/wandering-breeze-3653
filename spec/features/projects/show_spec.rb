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
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
  end

  describe 'User story 1' do
    describe 'When I visit a project show page' do
      describe 'I see that projects name and material' do
        describe 'I also see the theme of the challenge that this project belongs to' do
          it 'displays project name and material' do
            visit "/projects/#{@news_chic.id}"
            
            expect(page).to have_content('News Chic')
            expect(page).to have_content('Newspaper')
          end

          it 'displays the theme of the challenge the project belongs to' do
            visit "/projects/#{@news_chic.id}"

            expect(page).to have_content('Recycled Material')
          end
        end
      end
    end
  end
end