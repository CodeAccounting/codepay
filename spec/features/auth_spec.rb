require 'rails_helper'

RSpec.describe 'registration' do
  it 'logs in on successful registration' do
    visit '/users/new'
    fill_in 'user_first_name', with: 'Tony'
    fill_in 'user_last_name', with: 'Stark'
    fill_in 'user_email', with: 'tony.stark@gmail.com'
    fill_in 'user_password', with: 'password'
    click_button 'Submit'

    expect(page).to have_content('Tony Stark')
  end

  it 'requires a password longer than 6 characters' do
    visit '/users/new'
    fill_in 'user_first_name', with: 'Tony'
    fill_in 'user_last_name', with: 'Stark'
    fill_in 'user_email', with: 'tony.stark@gmail.com'
    fill_in 'user_password', with: 'x'
    click_button 'Submit'

    expect(page).to have_content('Password is too short')
  end
end

RSpec.describe 'login' do
  it 'redirects to root on successful sign in' do
    User.create(
      first_name: 'Tony',
      last_name: 'Stark',
      email: 'tony.stark@gmail.com',
      password: 'password')

    visit '/session/new'
    fill_in 'user_email', with: 'tony.stark@gmail.com'
    fill_in 'user_password', with: 'password'
    click_button 'LOGIN'

    expect(page).to have_content('Tony Stark')
  end
end
