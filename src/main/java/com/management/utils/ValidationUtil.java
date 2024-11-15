package com.management.utils;

public class ValidationUtil {

    // Validate that the name contains only alphabetic characters and is non-empty
    public static boolean isValidName(String name) {
        return name != null && name.matches("[A-Za-z ]+") && !name.trim().isEmpty();
    }

    // Validate age: must be a positive integer within a reasonable range (e.g., 5 to 100)
    public static boolean isValidAge(String age) {
        try {
            int ageValue = Integer.parseInt(age);
            return ageValue >= 5 && ageValue <= 100;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    // Validate that the grade is in an acceptable format (e.g., "A", "B", "C", etc.)
    public static boolean isValidGrade(String grade) {
        return grade != null && grade.matches("[A-Fa-f]");
    }

    // Validate username for login (checks if it's non-empty)
    public static boolean isValidUsername(String username) {
        return username != null && !username.trim().isEmpty();
    }

    // Validate password for login (checks if it's non-empty and meets length criteria)
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }
}