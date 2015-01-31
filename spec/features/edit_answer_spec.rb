require_relative 'features_helper'

feature 'Answer editing', %q{
  In order to fix error in answer
  As an author of answer
  I want to be able to edit my answer
} do

  given (:user) { create(:user) }
  given (:question) { create(:question) }
  given! (:answer) { create(:answer, question: question) }

  scenario 'Unauthenticated user tries to edit question' do
    visit question_path(question)
    
    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    before do
      sign_in_user(user)
      visit question_path(question)
    end
    
    scenario 'sees link to Edit' do
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end
    
    scenario 'tries to edit question', js:true do
      click_on 'Edit'
      within '.answers' do
        fill_in 'Answer', with: 'Edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end
  
    scenario "tries to edit other's user question"
  end
end
