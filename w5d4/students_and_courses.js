var Student = function (firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
};

var Course = function (name, department, credits) {
  this.courseName = name;
  this.department = department;
  this.credits = credits;
  this.enrolledStudents = [];
};

Student.prototype.name = function() {
  return this.firstName + " " + this.lastName;
};

Student.prototype.enroll = function(course) {
  if (this.courses.indexOf(course) === -1) {
    this.courses.push(course);
    course.enrolledStudents.push(this);
    return true;
  }
  return false;
};

Student.prototype.courseLoad = function () {
  var courseLoad = {};
  for (var i = 0; i < this.courses.length; i++){
    var credits = this.courses[i].credits;
    var department = this.courses[i].department;
    if (courseLoad[department] === undefined) {
      courseLoad[department] = credits;
    } else {
      courseLoad[department] += credits;
    }
  }
  return courseLoad;
};

Course.prototype.addStudent = function (student) {
  student.enroll(this);
};
