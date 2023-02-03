require_relative './comment.rb'
require_relative './post.rb'

class PostRepository
  def find_with_comments(id)
    sql = 'SELECT posts.id AS post_id,
                  posts.title AS post_title,
                  posts.content AS post_content,
                  comments.id AS comment_id,
                  comments.content AS comment_content,
                  comments.author AS comment_author,
                  comments.post_id
                  FROM posts
                  LEFT JOIN comments
                  ON posts.id = comments.post_id
                  WHERE posts.id = $1;'
    
    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    post = Post.new
    
    post.id = result.first['post_id']
    post.title = result.first['post_title']
    post.content = result.first['post_content']

    result.each do |record|
      comment = Comment.new

      comment.id = record['comment_id']
      comment.content = record['comment_content']
      comment.author = record['comment_author']
      comment.post_id = record['post_id']

      post.comments << comment
    end
    return post
  end
end