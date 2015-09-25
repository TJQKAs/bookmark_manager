# require 'spec_helper'

feature 'user sign up'  do

  scenario 'I can sign up as a new user' do
  user = build :user
    expect {sign_up(user)}.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, alice@example.com")
    expect(User.first.email).to eq('alice@example.com')
  end

  def sign_up(user)
     visit '/users/new'
     fill_in :email, with: user.email
     fill_in :password, with: user.password
     fill_in :password_confirmation, with: user.password_confirmation
     click_button 'Sign up'
  end

   scenario 'requires a matching confirmation password' do
     user = build :userfail
    # user = User.new(email: 'alice@example.com',
    #             password: '12345678',
    #             password_confirmation: '123456789')
    expect { sign_up(user)}.not_to change(User, :count)
  end

  # def sign_up(email: 'alice@example.com',
  #             password: '12345678',
  #             password_confirmation: '12345678')
  #   visit '/users/new'
  #   fill_in :email, with: email
  #   fill_in :password, with: password
  #   fill_in :password_confirmation, with: password_confirmation
  #   click_button 'Sign up'
  # end

   scenario "I can't sign in without entering an email adress"  do
      visit '/users/new'
      click_button 'Sign up'
      expect(current_path).to eq('/users')
      expect(page).to have_content 'You must input a valid email'
  end



   scenario 'with a password that does not match' do
     user = build :userfail
    #  user = User.new(email: 'alice@example.com',
    #              password: '12345678',
    #              password_confirmation: '123456789')
     expect { sign_up(user)}.not_to change(User, :count)
     expect(current_path).to eq('/users')
     expect(page).to have_content 'Password and confirmation password do not match'
   end

    scenario 'I cannot sign up with an exisitng email' do
      user = build :user
      sign_up(user)
      expect{ sign_up(user)}.to change(User, :count).by(0)
      expect(page).to have_content('Email is already taken')
    end


end
