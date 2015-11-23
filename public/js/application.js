function login() {
  $('#login-form').hide();
  $('#signup-form').hide();
  $('.login').click(function(event) {
    event.preventDefault();
    $('#signup-form').hide();
    $('#login-form').toggle();
    var target = $(this);
    $.ajax({
      url: "/login",
      method: "post"
    })
  })
}

function signup() {
  $('.signup').click(function(event) {
    $('.error_msg').hide();
    event.preventDefault();
    $('#login-form').hide();
    $('#signup-form').toggle();
  })
}

// get Indeed API Url
function getIndeedAPIUrl(searchTerm, location) {
  var searchTerm = searchTerm || 'tech%2C+jobs',
      location = location || 'San%2C+Francisco',
      limit = limit || '100';

  var response = 'http://api.indeed.com/ads/apisearch?'
  response += 'publisher=4019886558740498'
  response += '&q='
  response += searchTerm
  response += '&l='
  response += location
  response += '&limit='
  response += limit
  response += '&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=0&latlong=1&co=us&chnl=&v=2&format=json'
  return response;
}

// save results from Indeed API
function saveJobs(data) {
  $.ajax({
    url: '/jobs',
    method: 'post',
    data: {jobs: data},
  })
  .done(function(response) {
    $.ajax({
      url: '/admin',
      method: "get"
    })
  })
}

// api_call button triggers ajax call to Indeed API
// and save the results
function getData() {
  var indeedAPI = getIndeedAPIUrl()
  $('.api_call').click(function(event) {
    event.preventDefault();
    $.ajax({
      url: indeedAPI,
      dataType: 'jsonp'
    })
    .done(function(response){
      results = response.results;
      console.log(results);
      saveJobs(results);
    })
  })
}

// change clip icon to checked mark when job is saved,
// vice versa otherwise
function changeClipIcon() {
  var star_icon = $('.fav_star').parent()
  $(star_icon).click(function(event) {
    event.preventDefault();
    var user_id = $('header').children().last().attr('id'),
        job_id = $(this).parent().parent().attr('class');
    if (user_id === undefined ) {
      alert("please log in to clip your job");
    } else {
      var link = $(this);
      console.log("hhhhhhhhhhhh");
      var job_id = { job_id: job_id }
       $.ajax({
        method: 'post',
        url: '/users/' + user_id + '/star',
        data: job_id
      })
      .done(function(response) {
        link.toggleClass('favorited');
      })
    }
  })
}

$(document).ready(function(){
  login();
  signup();
  changeClipIcon();
  getData();
})
