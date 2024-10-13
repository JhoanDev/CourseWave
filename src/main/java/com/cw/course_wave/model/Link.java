package com.cw.course_wave.model;

public class Link {
    private int id;
    private String name;
    private String url;
    private String type;
    private int courseId;

    public Link(int id, String name, String url, String type, int courseId) {
        this.id = id;
        this.name = name;
        this.url = url;
        this.type = type;
        this.courseId = courseId;
    }

    public Link(String name, String url, String type, int courseId) {
        this.name = name;
        this.url = url;
        this.type = type;
        this.courseId = courseId;
    }

    public Link(String name, String url, String type) {
        this.name = name;
        this.url = url;
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }
}
