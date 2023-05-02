require 'rails_helper'

RSpec.describe '/User', type: :request do

describe 'user' do
  before do
    post '/signin', params: {user: {email: 'user@user.com', password: 'password'}}
  end
  
  it 'GET /root' do 
    get '/'
    expect(response).to have_http_status(200)
  end

  it 'GET /transaction/index' do
    get '/transactions/index'
    expect(response).to have_http_status(200)
  end

  it 'GET /transaction/index' do
    get '/transactions/TSLA/buy'
    expect(response).to have_http_status(200)
  end

  it 'GET /transaction/index' do
    get '/transactions/TSLA/sell'
    expect(response).to have_http_status(200)
  end

end 


describe 'admin' do
  before do
    post '/signin', params: {user: {email: 'user@user.com', password: 'password', admin: true}}
  end

  it 'GET dashboard' do 
    get '/admin/dashboard'
    expect(response).to have_http_status(302)
  end

  it 'GET new user' do 
    get '/admin/dashboard/new'
    expect(response).to have_http_status(302)
  end


  it 'GET pending user' do 
    get '/admin/dashboard/pendingusers'
    expect(response).to have_http_status(302)
  end
  
  it 'GET edit user' do 
    get '/admin/dashboard/4/edit'
    expect(response).to have_http_status(302)
  end

  it 'GET show a user' do 
    get '/admin/dashboard/8'
    expect(response).to have_http_status(302)
  end
end
  
# POST rspec Tests

  it 'can create new user' do
    post '/signup', params: {user: {email: 'user@email.com', password: 'password', password_confirmation: 'password'}}
    expect(response).to have_http_status(302)
  end

  it 'can login' do
    post '/signin', params: {user: {email: 'user@user.com', password: 'password'}}
    expect(response).to have_http_status(302)
  end

  it 'can logout' do
    post '/signin', params: {user: {email: 'user@user.com', password: 'password'}}
    delete '/logout'
    expect(response).to have_http_status(302)
  end

    # #
    # describe 'GET /root' do
    
    #     it 'renders a successful response' do
    #         post '/signin', user_params: {email: 'user@user.com', password: 'password'}
    #         expect(response).to have_http_status(302)
    #     end
    # end
end