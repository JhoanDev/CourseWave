package com.cw.course_wave.dao;

import com.cw.course_wave.database.DatabaseConnection;
import com.cw.course_wave.model.Course;
import com.cw.course_wave.model.Link;
import com.cw.course_wave.model.Enrollment;

import java.sql.SQLException;
import java.util.ArrayList;

public class CourseDao {

    public final LinkDao linkDao = new LinkDao();
    public final EnrollmentDao enrollmentDao = new EnrollmentDao();


    public void insertCourse(Course course, int userID) throws SQLException {
        String sql = "INSERT INTO courses (title, description, hours) VALUES (?, ?, ?)";
        int courseID = DatabaseConnection.executeQueryWithGeneratedKey(sql, course.getTitle(), course.getDescription(), course.getHours());
        for (Link link : course.getLinks()) {
            link.setCourseId(courseID);
            linkDao.insertLink(link);
        }
        Enrollment enrollment = new Enrollment(userID, courseID);
        System.out.println(userID);
        enrollmentDao.insertEnrollment(enrollment); //Criando a matricula

    }

    public void updateCourse(Course course) throws SQLException {
        String sql = "UPDATE courses SET title = ?, description = ?, hours = ? WHERE id = ?";
        DatabaseConnection.executeQuery(sql, course.getTitle(), course.getDescription(), course.getHours(), course.getId());
        linkDao.deleteLinksByCourseId(course.getId());
        for (Link link : course.getLinks()) {
            link.setCourseId(course.getId());
            linkDao.insertLink(link);
        }
    }

    public Course getCourseById(int id) throws SQLException {
        String sql = "SELECT * FROM courses WHERE id = ?";
        var resultSet = DatabaseConnection.executeSelect(sql, id);

        if (resultSet.next()) {
            Course course = new Course(
                    resultSet.getInt("id"),
                    resultSet.getString("title"),
                    resultSet.getString("description"),
                    resultSet.getInt("hours")
            );
            course.setLinks(linkDao.getLinksByCourseId(course.getId()));
            return course;
        }

        resultSet.close();
        return null;
    }

    public ArrayList<Course> getCoursesByTeacherId(int teacherId) throws SQLException {
        String sql = "SELECT c.* FROM courses c " +
                "JOIN enrollment e ON c.id = e.course_id " +
                "WHERE e.user_id = ?";
        var resultSet = DatabaseConnection.executeSelect(sql, teacherId);
        ArrayList<Course> courses = new ArrayList<>();
        while (resultSet.next()) {
            Course course = new Course(
                    resultSet.getInt("id"),
                    resultSet.getString("title"),
                    resultSet.getString("description"),
                    resultSet.getInt("hours")
            );
            course.setLinks(linkDao.getLinksByCourseId(course.getId()));
            courses.add(course);
        }
        resultSet.close();
        return courses;

    }

    public ArrayList<Course> getCoursesByStudentId(int studentId) throws SQLException {
        String sql = "SELECT c.* FROM courses c " +
                "JOIN enrollment e ON c.id = e.course_id " +
                "WHERE e.user_id = ?  AND e.completed = 0";
        var resultSet = DatabaseConnection.executeSelect(sql, studentId);
        ArrayList<Course> courses = new ArrayList<>();

        while (resultSet.next()) {
            Course course = new Course(
                    resultSet.getInt("id"),
                    resultSet.getString("title"),
                    resultSet.getString("description"),
                    resultSet.getInt("hours")
            );
            course.setLinks(linkDao.getLinksByCourseId(course.getId()));
            courses.add(course);
        }
        resultSet.close();
        return courses;
    }

    public ArrayList<Course> getAvailableCoursesForStudent(int studentId) throws SQLException {
        String sql = "SELECT * FROM courses c " +
                "WHERE c.id NOT IN (SELECT e.course_id FROM enrollment e WHERE e.user_id = ?)";
        var resultSet = DatabaseConnection.executeSelect(sql, studentId);
        ArrayList<Course> availableCourses = new ArrayList<>();

        while (resultSet.next()) {
            Course course = new Course(
                    resultSet.getInt("id"),
                    resultSet.getString("title"),
                    resultSet.getString("description"),
                    resultSet.getInt("hours")
            );
            course.setLinks(linkDao.getLinksByCourseId(course.getId()));
            availableCourses.add(course);
        }
        resultSet.close();
        return availableCourses;
    }

    public String getProfessorNameByCourseId(int courseId) throws SQLException {
        String sql = "SELECT u.name FROM enrollment e " +
                "JOIN users u ON e.user_id = u.id " +
                "WHERE e.course_id = ? AND u.role = 'teacher'";
        var resultSet = DatabaseConnection.executeSelect(sql, courseId);

        if (resultSet.next()) {
            return resultSet.getString("name");
        }

        resultSet.close();
        return null; // Retorna null se não houver professor associado ao curso
    }



    public void deleteCourse(int courseId) throws SQLException {
        String sql = "DELETE FROM courses WHERE id = ?";
        DatabaseConnection.executeQuery(sql, courseId);
    }

}
