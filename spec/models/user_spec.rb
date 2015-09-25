describe User do

  let!(:user) do

    User.create(email: 'alice@example.com', password: '12345678',
                password_confirmation: '12345678')
  end

    it 'does not authenticate when given an incorrect password' do
      expect(User.authenticate(user.mail, 'wrong_stupid_password')).to be_nil
    end


end
