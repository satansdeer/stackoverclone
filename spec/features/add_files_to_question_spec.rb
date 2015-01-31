require_relative 'features_helper'

feature 'Add files to question' %q{
  In order to Illustrate my question
  As a question author
  I want to be able to attach files
} do

  given(:user) { create(:user) }

end
