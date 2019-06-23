class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)  # {:name=>"Alex Patriquin", :location=>"New York, NY"}
   student_hash.each do |key, value|
    # binding.pry
      self.send("#{key}=", value)
   end
    
    @@all << self
  end

  def self.create_from_collection(students_array) # students_array == [{:name , :location}]
    # binding.pry
    students_array.each {|student| Student.new(student)}
  end

  def add_student_attributes(attributes_hash)
    # binding.pry
    attributes_hash.each_key do |key|
      self.send("#{key}=", attributes_hash[key])
    end 
  end

  def self.all
    @@all 
  end
end

