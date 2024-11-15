package com.management.utils;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class DatabaseUtil {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseUtil.class);
    private static final String CONFIG_FILE = "/config.properties";
    private static String MONGODB_URI;
    private static final String DATABASE_NAME = "student-management";

    private static MongoClient mongoClient = null;

    static {
        try (InputStream input = DatabaseUtil.class.getResourceAsStream(CONFIG_FILE)) {
            Properties prop = new Properties();
            if (input == null) {
                System.out.println("Sorry, unable to find " + CONFIG_FILE);
                throw new IOException("Sorry, unable to find " + CONFIG_FILE);
            }
            prop.load(input);
            MONGODB_URI = prop.getProperty("mongodb.uri");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    public static MongoDatabase getDatabase() {
        if (mongoClient == null) {
            try {
                mongoClient = MongoClients.create(MONGODB_URI);
                logger.info("MongoDB connection established");
            } catch (Exception e) {
                logger.error("Error connecting to MongoDB: {}", e.getMessage());
                throw e;
            }
        }
        return mongoClient.getDatabase(DATABASE_NAME);
    }

    public static MongoClient getMongoClient() {
        return mongoClient;
    }
}
