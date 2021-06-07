require_relative './db/database'
require 'rubygems'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/contrib'
require 'rack/contrib'

class TodoApp < Sinatra::Base
  use Rack::MethodOverride
  get '/' do
    redirect to '/posts'
  end

  get '/posts' do
    @todos = Post.all
    erb :'posts/index'
  end

  get '/posts/new' do
    erb :'posts/new'
  end
  post '/posts/new' do
    params.delete 'submit'
    @todo = Post.create(params)
    if @todo.save
      redirect to '/posts'
    else
      'Post was not save'
    end
  end
  get '/posts/:id/edit' do
    @todo = Post.get(params[:id])
    erb :'posts/edit'
  end

  patch '/posts/:id/edit' do
    todo = Post.get(params[:id])
    todo.title = (params[:title])
    todo.body = (params[:body])
    todo.save
    redirect '/posts'
  end

  get '/posts/:id/delete' do
    Post.get(params[:id]).destroy
    redirect '/posts'
  end
end