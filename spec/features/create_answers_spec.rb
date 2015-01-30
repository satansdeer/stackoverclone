require 'rails_helper'

feature 'User answer', %q{
  In order to share my knowledge
  As authenticated user
  I want to be able to create answers
} do
  
  given (:user) { create(:user) }
  given (:question) { create(:question) }
  
  scenario 'Authenticated user creates answer', js:true do
    sign_in_user(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'My answer'
    end
  end
  
end
