package com.cw.course_wave.model;

import java.sql.Timestamp;

public class Enrollment {
    private int userId;
    private int courseId;
    private Timestamp enrollmentDate;
    private boolean completed;

    public Enrollment(int userId, int courseId, Timestamp enrollmentDate, boolean completed) {
        this.userId = userId;
        this.courseId = courseId;
        this.enrollmentDate = enrollmentDate != null ? enrollmentDate : new Timestamp(System.currentTimeMillis());
        this.completed = completed;
    }

    public Enrollment(int userId, int courseId) {
        this.userId = userId;
        this.courseId = courseId;
        this.enrollmentDate = new Timestamp(System.currentTimeMillis());
        this.completed = false;
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public Timestamp getEnrollmentDate() {
        return enrollmentDate;
    }

    public void setEnrollmentDate(Timestamp enrollmentDate) {
        this.enrollmentDate = enrollmentDate;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }

}
