enable 'sessions'
enable 'hirb'


get '/' do
  # session[:user_id] = nil
  @jobs = Job.where(saved: true)
  erb :index
end

get '/login' do
  erb :'users/login'
end

post '/login' do
  user = User.find_by(email: params[:email])
  @jobs = Job.where(saved: true)

  if user && user.password == params[:password]
    login(user)
    redirect '/'
  else
    @errors = {login_error: "email or password incorrect, try again"}
    erb :index
  end

end

get '/registration' do
  erb :'users/register'
end

post '/registration' do
  user = User.new(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    hashed_password: params[:password])
    user.password = params[:password]
    if user.save
      login(user)
      first_name = user
      redirect '/'
    else
      #
      @errors = {registration_error: "email or password incorrect, try again"}
      p "this is the error page"
      redirect '/'
    end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end



