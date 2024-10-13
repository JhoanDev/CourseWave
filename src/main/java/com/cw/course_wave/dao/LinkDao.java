package com.cw.course_wave.dao;

import com.cw.course_wave.database.DatabaseConnection;
import com.cw.course_wave.model.Link;

import java.sql.SQLException;
import java.util.ArrayList;

public class LinkDao {

    public void insertLink(Link link) throws SQLException {
        String sql = "INSERT INTO links (name, url, type, course_id) VALUES (?, ?, ?, ?)";
        DatabaseConnection.executeQuery(sql, link.getName(), link.getUrl(), link.getType(), link.getCourseId());
    }

    public Link getLinkById(int id) throws SQLException {
        String sql = "SELECT * FROM links WHERE id = ?";
        var resultSet = DatabaseConnection.executeSelect(sql, id);

        if (resultSet.next()) {
            return new Link(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("url"),
                    resultSet.getString("type"),
                    resultSet.getInt("course_id")
            );
        }

        resultSet.close();
        return null;
    }

    public void deleteLink(int id) throws SQLException {
        String sql = "DELETE FROM links WHERE id = ?";
        DatabaseConnection.executeQuery(sql, id);
    }

    public void updateLink(Link link) throws SQLException {
        String sql = "UPDATE links SET name = ?, url = ?, type = ?, course_id = ? WHERE id = ?";
        DatabaseConnection.executeQuery(sql, link.getName(), link.getUrl(), link.getType(), link.getCourseId(), link.getId());
    }

    public void deleteLinksByCourseId(int courseId) throws SQLException {
        String sql = "DELETE FROM links WHERE course_id = ?";
        DatabaseConnection.executeQuery(sql, courseId);
    }

    public ArrayList<Link> getLinksByCourseId(int courseId) throws SQLException {
        String sql = "SELECT * FROM links WHERE course_id = ?";
        var resultSet = DatabaseConnection.executeSelect(sql, courseId);
        ArrayList<Link> links = new ArrayList<>();

        while (resultSet.next()) {
            links.add(new Link(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("url"),
                    resultSet.getString("type"),
                    resultSet.getInt("course_id")
            ));
        }

        resultSet.close();
        return links;
    }

}
