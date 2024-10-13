package com.cw.course_wave.dao;

import com.cw.course_wave.database.DatabaseConnection;
import com.cw.course_wave.model.Course;
import com.cw.course_wave.model.Link;
import java.sql.SQLException;
import java.util.ArrayList;

public class CourseDao {

    public final LinkDao linkDao = new LinkDao();

    public void insertCourse(Course course) throws SQLException {
        String sql = "INSERT INTO courses (title, description, hours, teacher_id) VALUES (?, ?, ?, ?)";
        int courseID = DatabaseConnection.executeQueryWithGeneratedKey(sql, course.getTitle(), course.getDescription(), course.getHours(), course.getUserId());
        for (Link link : course.getLinks()) {
            link.setCourseId(courseID);
            linkDao.insertLink(link);
        }
    }

    public void updateCourse(Course course) throws SQLException {
        String sql = "UPDATE courses SET title = ?, description = ?, hours = ?, teacher_id = ? WHERE id = ?";
        DatabaseConnection.executeQuery(sql, course.getTitle(), course.getDescription(), course.getHours(), course.getUserId(), course.getId());
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
                    resultSet.getInt("hours"),
                    resultSet.getInt("teacher_id")
            );
            course.setLinks(linkDao.getLinksByCourseId(course.getId()));
            return course;
        }

        resultSet.close();
        return null;
    }

    public ArrayList<Course> getCoursesByTeacherId(int teacherId) throws SQLException {
        String sql = "SELECT * FROM courses WHERE teacher_id = ?";
        var resultSet = DatabaseConnection.executeSelect(sql, teacherId);
        ArrayList<Course> courses = new ArrayList<>();
        while (resultSet.next()) {
            Course course = new Course(
                    resultSet.getInt("id"),
                    resultSet.getString("title"),
                    resultSet.getString("description"),
                    resultSet.getInt("hours"),
                    resultSet.getInt("teacher_id")
            );
            course.setLinks(linkDao.getLinksByCourseId(course.getId()));
            courses.add(course);
        }
        resultSet.close();
        return courses;
    }

    public void deleteCourse(int courseId) throws SQLException {
        String sql = "DELETE FROM courses WHERE id = ?";
        DatabaseConnection.executeQuery(sql, courseId);
    }

}
