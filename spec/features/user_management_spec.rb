# require 'spec_helper'

feature 'user sign up'  do

  scenario 'I can sign up as a new user' do
    expect {sign_up}.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, alice@example.com")
    expect(User.first.email).to eq('alice@example.com')
  end

  def sign_up(email: 'alice@example.com', password: 'oranges!')
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Sign up'
  end

  scenario 'requires a matching confirmation password' do
    expect { sign_up(password_confirmation: 'wrong')}.not_to change(User, :count)
  end

  def sign_up(email: 'alice@example.com',
              password: '12345678',
              password_confirmation: '12345678')
    visit '/users/new'
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end


   scenario "I can't sign in without entering an email adress"  do
      visit '/users/new'
      click_button 'Sign up'
      expect(current_path).to eq('/users')
      expect(page).to have_content 'You must input a valid email'
  end



   scenario 'with a password that does not match' do
     expect { sign_up(password_confirmation: 'wrong')}.not_to change(User, :count)
     expect(current_path).to eq('/users')
     expect(page).to have_content 'Password and confirmation password do not match'
   end

end
