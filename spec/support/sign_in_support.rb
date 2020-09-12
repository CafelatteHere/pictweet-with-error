module SignInSupport
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    # find('input[name="commit"]').click это то, что по программе
    find('input[value="Sign up"]').click #это моё на пробу, убрать потом
    expect(current_path).to eq root_path
  end
end