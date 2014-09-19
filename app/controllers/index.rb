get '/' do
  if params.key(nil).nil?
  else
  	@user = User.find(params.key(nil))
  end

  erb :index
end

