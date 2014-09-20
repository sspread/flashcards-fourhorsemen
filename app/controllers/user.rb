# all login/logout/authentication routing


before '/users/profile' do
	unless current_user
		redirect '/'
	end
end

get '/users/profile' do
	@user = User.find(session[:user_id])
	erb :"users/profile"
end

get '/users/register' do

	erb :'users/register'
end

get '/users/login' do

	erb :'users/login'
end

post '/users/register' do
	@user = User.new(username: params[:username])
	@errors = @user.errors.messages
	@username = params[:username]
	if @user.valid?
		@user.password = params[:password]
		@user.save
		redirect "/?#{@user.id}"
	else
		erb :'users/register'
	end
end

post '/users/login' do
	@user = User.find_by_username(params[:username])
	@username = params[:username]
	@password = params[:password]
	if @user.nil?
		erb :'users/login'
	else
		if @user.authenticate(params[:password])
			session["user_id"] = @user.id
			redirect "/users/profile"
		else
			erb :'users/login'
		end
	end
end

