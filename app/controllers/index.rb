get '/' do
  if params.key(nil).nil?
  else
  	@user = User.find(params.key(nil))
  end
  session.clear
  erb :index
end

