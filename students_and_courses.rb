class Student
  attr_reader :courses, :first_name, :last_name, :course_load

  def initialize(first, last)
    @first_name = first
    @last_name = last
    @courses = []
    @course_load = {}
  end

  def name
    first_name + " " + last_name
  end

  def enroll(course)
    unless courses.include?(course)
      courses << course
      course.add_student(self)
      add_course_load(course)
    end
  end

  def to_s
    name
  end

  private:
  def add_course_load(course)
    department = course.department
    credits = course.credits
    if course_load.include?(department)
      course_load[department] += credits
    else
      course_load[department] = credits
    end
  end


end

class Course
  attr_reader :students, :department, :credits, :name

  def initialize(name, department, credits)
    @name = name
    @department = department
    @credits = credits
    @students = []
  end

  def add_student(student)
    unless students.include?(student)
      students << student
      student.enroll(self)
    end
  end

  def to_s
    name
  end
end

cs101 = Course.new("CS101", "Computer Science", 3)
alice = Student.new("Alice", "Able")

cs101.add_student(alice)
puts alice.courses
puts cs101.students

p alice.course_load
