# allow user to unfavorite job posting
# allow admin to undo job posting
post '/users/:user_id/star' do
  job = Job.find(params[:job_id])
  user = User.find(params[:user_id])

  if user.admin == 1
    if job.saved
      job.update(saved: false)
    else
      job.update(saved: true)
      job.update(saved_by: current_user.email)
    end
  else
    if user.jobs.include?(job)
      user.jobs.delete(job)
    else
      user.jobs << job
    end
  end
end

# show all jobs favorited
get '/users/:user_id/jobs' do
 @user = User.find(params[:user_id])
 if current_user
    erb :'users/favorite'
 else
    redirect '/'
 end
end
