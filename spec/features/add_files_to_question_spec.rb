require_relative 'features_helper'

feature 'Add files to question', %q{
  In order to Illustrate my question
  As a question author
  I want to be able to attach files
} do

  given(:user) { create(:user) }

  background do
    sign_in_user(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Create'

    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
  end
  
end
