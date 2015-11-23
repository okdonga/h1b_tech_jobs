# filter out the job results to show only
# jobs that sponsor h1b visa
post '/jobs' do
  @allJobs = params[:jobs]
  p "#" * 30
  p @allJobs
  @allJobs.each do |key, value|
    if !value[:snippet].include? 'unable to sponsor'
     @job = Job.new(title: value[:jobtitle], description: value[:snippet], location: value[:city], url: value[:url], company_name: value[:company])
     @job.save
    end
  end
  erb :'jobs/new', layout: false
end

# show all jobs saved
get '/admin' do
  @jobs = Job.all
  if User.admin(current_user)
    erb :'users/admin'
  else
    redirect '/'
  end
end

# favorite specific job
post '/jobs/favorite' do
  @jobs = Job.all
  job = Job.new(params[:job])
  if job.save
    job.update(saved: true)
    current_user.jobs << job
    redirect '/admin'
  else
    @errors = job.errors.full_messages
    erb :'users/admin'
  end
end
