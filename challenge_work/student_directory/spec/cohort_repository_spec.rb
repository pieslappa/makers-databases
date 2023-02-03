require_relative '../lib/database_connection.rb'
require_relative '../lib/cohort_repository.rb'

RSpec.describe CohortRepository do
  def reset_cohorts_table
    seed_sql = File.read('spec/seeds_cohorts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_cohorts_table
  end

  it "finds a cohort and returns the students" do
    repo = CohortRepository.new

    cohort = repo.find_with_students(1)
    expect(cohort.students.length).to eq 3
  end
end