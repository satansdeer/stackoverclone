require_relative 'features_helper'

feature 'Add files to answer', %q{
  In order to Illustrate my answer
  As a answer author
  I want to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in_user(user)
    visit question_path(question)
  end

  scenario 'User adds file when asks question', js: true  do
    fill_in 'Your answer', with: 'Test answer'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
    end
  end
  
end
