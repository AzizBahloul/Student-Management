package com.management.listener;

import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

public class SessionListener implements HttpSessionListener {

    private static int activeSessions = 0;

    @Override
    public void sessionCreated(HttpSessionEvent event) {
        activeSessions++;
        System.out.println("Session created: " + event.getSession().getId());
        System.out.println("Active sessions: " + activeSessions);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        activeSessions--;
        System.out.println("Session destroyed: " + event.getSession().getId());
        System.out.println("Active sessions: " + activeSessions);
    }

    // Optional: Getter method to retrieve active session count
    public static int getActiveSessions() {
        return activeSessions;
    }
}
