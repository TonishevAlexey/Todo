require 'data_mapper'
require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'
#database connection

class Post
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :body, Text
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite:./db/test.db') #подключение и путь к бд
DataMapper.finalize #Проверка моделей
DataMapper.auto_upgrade!  #Создает новые таблицы и добавляет новые столбцы в существующие таблицы

