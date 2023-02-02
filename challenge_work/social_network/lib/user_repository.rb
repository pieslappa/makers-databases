require_relative './user.rb'

class UserRepository
  def all
    sql = 'SELECT id, email_address, username FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    users = []

    result_set.each do |record|
      user = User.new

      user.id = record['id']
      user.email_address = record['email_address']
      user.username = record['username']

      users << user
    end
    return users
  end

  def find(user_id)
    sql = 'SELECT id, email_address, username FROM users WHERE id = $1;'
    params = [user_id]
    result_set = DatabaseConnection.exec_params(sql, params)

    user = User.new
    user.id = result_set[0]['id']
    user.email_address = result_set[0]['email_address']
    user.username = result_set[0]['username']
    
    return user
  end

  def create(user)
    sql = 'INSERT INTO users (email_address, username) VALUES($1, $2);'
    params = [user.email_address, user.username]
    result_set = DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM users WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
  end
end