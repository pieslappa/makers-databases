require_relative './post.rb'
require_relative './database_connection.rb'

class PostRepository
  def all
    sql = 'SELECT id, title, content, views, user_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []
    result_set.each do |record|
      post = Post.new

      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.views = record['views']
      post.user_id = record['user_id']
      
      posts << post
    end
    return posts
  end

  def find(id)
    sql = 'SELECT id, title, content, views, user_id FROM posts WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    post = Post.new

    post.id = result_set[0]['id']
    post.title = result_set[0]['title']
    post.content = result_set[0]['content']
    post.views = result_set[0]['views']
    post.user_id = result_set[0]['user_id']
    
    return post
  end

  def create(post)
    sql = 'INSERT INTO posts (title, content, views, user_id) VALUES($1, $2, $3, $4);'
    params = [post.title, post.content, post.views, post.user_id]
    result_set = DatabaseConnection.exec_params(sql, params)
  end
  
  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
  end
end