require_relative './lib/cohort_repository.rb'
require_relative './lib/database_connection.rb'

class Application
  def initialize(database_name, io, cohort_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @cohort_repository = cohort_repository
  end

  def run
    @io.puts "Which cohort would you like to view?"
    cohort_id = gets.chomp
    cohort = @cohort_repository.find_with_students(cohort_id)
    @io.puts "Cohort #{cohort.id}: #{cohort.name} - Start Date: #{cohort.start_date}"
    cohort.students.each do |student|
      puts "Student #{student.id} - #{student.name}"
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'student_directory_2',
    Kernel,
    CohortRepository.new
  )
  app.run
end