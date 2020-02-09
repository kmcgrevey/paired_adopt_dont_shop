require 'rails_helper'

RSpec.describe 'from any page on application', type: :feature do
  it 'can see favorites indicator from any page' do
    visit '/shelters'
    expect(page).to have_content('Favorites')

    visit '/pets'
    expect(page).to have_content('Favorites')

    visit '/'
    expect(page).to have_content('Favorites')
  end
end
