class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each_pair{ |key, val| instance_variable_set("@#{key.to_s}", val) }
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    students_array.each{ |student| student = Student.new(student) } #why use  the scraper class to do this? Makes no sense!!
  end

  def add_student_attributes(attributes_hash)
    # binding.pry
    attributes_hash.each_pair{ |key, val| instance_variable_set("@#{key.to_s}", val) }
  end

  def self.all
    @@all
  end
end

