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
    @todo = Post.create(params) #сохраняем данные, полученные из формы в базу данных модели Post
    if @todo.save
      redirect to '/posts'
    else
      'Post was not save'
    end
  end
  #Edit post
  get '/posts/:id/edit' do
    #роутинг для редактирования поста, доступ к посту получаем по его id
    @todo = Post.get(params[:id]) #в переменной @post получаем данные из бд согласно id поста
    erb :'posts/edit' #рендерим шаблон /posts/edit.erb
  end

  #Update post
  patch '/posts/:id/edit' do
    todo = Post.get(params[:id])
    todo.title = (params[:title])
    todo.body = (params[:body])
    todo.save #сохраняем измененные данные
    redirect '/posts' #редиректимся на страницу со всеми постами
  end

  #Delete post
  get '/posts/:id/delete' do
    Post.get(params[:id]).destroy #удаляем пост
    redirect '/posts'
  end
end