#user.rb

# all login/logout/authentication routing

before 'user/profile/:id' do
	unless current_user
		redirect '/login'
	end
end

get 'user/profile' do
	@user = User.find(session[user_id])
	erb :"users/profile"
end