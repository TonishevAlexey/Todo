ENV['RACK_ENV'] = 'test'
require_relative '../db/test.rb'
require 'rspec'
require 'rack/test'
require_relative '../todo'
RSpec.describe TodoApp do
  include Rack::Test::Methods

  def app
    TodoApp
  end

  Post.all.destroy
  Post.create({ id: 1, title: "Sleep", body: "Sleep all day" })
  todo = Post.get(1)

  it "creat a new Test class" do
    expect(todo.is_a? Object).to eq(true)

  end

  it "Value='Sleep'" do
    expect(todo.title).to eq("Sleep")
  end
  it "Body='Sleep all day'" do
    expect(todo.body).to eq("Sleep all day")
  end
  it "Id='1'" do
    expect(todo.id).to eq(1)
  end
  it "routs" do
    get '/posts'
    expect(last_response).to be_ok
    get 'posts/new'
    expect(last_response).to be_ok
    get "/posts/#{todo.id}"
    expect(last_response).to be_ok
    patch "/posts/#{todo.id}"
    expect(last_response.status).to eq(302)
    delete "/posts/#{todo.id}"
    expect(last_response.status).to eq(302)
  end

end
#
