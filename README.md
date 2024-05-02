# README

* This app is a simple example of a RESTful API where an Admin can create students and courses, and enroll the students in the courses. The Admin can also view the list of students and courses, and view the list of students enrolled in a course.
* The project is separated into an Admin and a Student module that allow the different roles to be managed separately.
* It implements devise for User management, but it is temporarily disabled for the purpose of this example. This is the reason the Student module is not tested, because it required too much configuration to get the tests to work and this is just a basic exercise.
* There are some code duplications in the specs that need to be cleaned up
* In order to run `app/controllers/student/courses_controller.rb` either the user needs to be authenticated or `current_user` needs to be set in line 9 as `current_user = Student.last` assuming a student exists
