class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    new_student = self.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student
    # create a new Student object given a row from the database
  end

  def self.all 
    DB[:conn].execute("SELECT * FROM students").map do |row|
      self.new_from_db(row)
    end 


    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
  end

  def self.find_by_name(name)
    sss = <<-SSS
    SELECT *
    FROM students
    WHERE NAME = ?
    LIMIT 1
    SSS
    DB[:conn].execute(sss, name).map do |row|
      self.new_from_db(row)
    end.first 
  
    # find the student in the database given a name
    # return a new instance of the Student class
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
  def self.all_students_in_grade_9
    g9 = <<-haha
    SELECT *
    FROM students
    WHERE grade = 9
    haha
    DB[:conn].execute(g9).map do |row|
      self.new_from_db(row)
    end
  end
  def self.students_below_12th_grade
    g12down = <<-g12d
    SELECT *
    FROM students
    WHERE grade <= 11
    g12d
    DB[:conn].execute(g12down).map do |row|
      self.new_from_db(row)
    end
  end

  def self.first_X_students_in_grade_10(number)
    first_x = <<-FXSIG
    SELECT *
    FROM students
    WHERE grade = 10
    LIMIT ?
    FXSIG
    DB[:conn].execute(first_x, number).map do |row|
      self.new_from_db(row)
    end 
  end 
  def self.first_student_in_grade_10
    first_ten = <<-FS
    SELECT *
    FROM students
    WHERE grade == 10
    ORDER BY students.id
    LIMIT 1
    FS
    DB[:conn].execute(first_ten).map do |row|
      self.new_from_db(row)
    end.first
  end 
  def self.all_students_in_grade_X(grade)
    all_s = <<-asas
    SELECT * 
    FROM students
    WHERE grade == ?
    asas
    DB[:conn].execute(all_s, grade).map do |row|
      self.new_from_db(row)
    end 
  end 
end
