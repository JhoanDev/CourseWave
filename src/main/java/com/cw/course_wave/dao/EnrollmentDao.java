package com.cw.course_wave.dao;

import com.cw.course_wave.database.DatabaseConnection;
import com.cw.course_wave.model.Enrollment;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

public class EnrollmentDao {

    public void insertEnrollment(Enrollment enrollment) throws SQLException {
        String sql = "INSERT INTO enrollment (user_id, course_id, enrollment_date, completed) VALUES (?, ?, ?, ?)";
        DatabaseConnection.executeQuery(sql, enrollment.getUserId(), enrollment.getCourseId(), enrollment.getEnrollmentDate(), enrollment.isCompleted());
    }

    public Enrollment getEnrollment(int userId, int courseId) throws SQLException {
        String sql = "SELECT * FROM enrollment WHERE user_id = ? AND course_id = ?";
        var resultSet = DatabaseConnection.executeSelect(sql, userId, courseId);

        if (resultSet.next()) {
            return new Enrollment(
                    resultSet.getInt("user_id"),
                    resultSet.getInt("course_id"),
                    resultSet.getTimestamp("enrollment_date"),
                    resultSet.getBoolean("completed")
            );
        }

        resultSet.close();
        return null;
    }

    public void deleteEnrollment(int userId, int courseId) throws SQLException {
        String sql = "DELETE FROM enrollment WHERE user_id = ? AND course_id = ?";
        DatabaseConnection.executeQuery(sql, userId, courseId);
    }

    public void updateEnrollment(Enrollment enrollment) throws SQLException {
        String sql = "UPDATE enrollment SET enrollment_date = ?, completed = ? WHERE user_id = ? AND course_id = ?";
        DatabaseConnection.executeQuery(sql, enrollment.getEnrollmentDate(), enrollment.isCompleted(), enrollment.getUserId(), enrollment.getCourseId());
    }

    public ArrayList<Enrollment> getEnrollmentsByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM enrollment WHERE user_id = ?";
        var resultSet = DatabaseConnection.executeSelect(sql, userId);
        ArrayList<Enrollment> enrollments = new ArrayList<>();

        while (resultSet.next()) {
            enrollments.add(new Enrollment(
                    resultSet.getInt("user_id"),
                    resultSet.getInt("course_id"),
                    resultSet.getTimestamp("enrollment_date"),
                    resultSet.getBoolean("completed")
            ));
        }

        resultSet.close();
        return enrollments;
    }

    public ArrayList<Enrollment> getEnrollmentsByCourseId(int courseId) throws SQLException {
        String sql = "SELECT * FROM enrollment WHERE course_id = ?";
        var resultSet = DatabaseConnection.executeSelect(sql, courseId);
        ArrayList<Enrollment> enrollments = new ArrayList<>();

        while (resultSet.next()) {
            enrollments.add(new Enrollment(
                    resultSet.getInt("user_id"),
                    resultSet.getInt("course_id"),
                    resultSet.getTimestamp("enrollment_date"),
                    resultSet.getBoolean("completed")
            ));
        }

        resultSet.close();
        return enrollments;
    }
}
