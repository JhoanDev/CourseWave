package com.cw.course_wave.model;

import java.util.ArrayList;

public class Course {
    private int id;
    private String title;
    private String description;
    private int hours;
    private ArrayList<Link> links;
    private int userId;

    public Course(int id, String title, String description, int hours, int userId) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.hours = hours;

        this.userId = userId;
        this.links = new ArrayList<>();
    }

    public Course(String title, String description, int hours, int userId) {
        this.title = title;
        this.description = description;
        this.hours = hours;
        this.userId = userId;
        this.links = new ArrayList<>();
    }

    public void addLink(Link link) {
        links.add(link);
    }

    public ArrayList<Link> getLinks() {
        return links;
    }

    public void setLinks(ArrayList<Link> links) {
        this.links = links;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getHours() {
        return hours;
    }

    public void getHours(int hours) {
        this.hours = hours;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
