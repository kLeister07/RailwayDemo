# Use an official Maven image to build the application
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory in the Docker container
WORKDIR /app

# Copy the backend code into the container
COPY railway-backend /app

# Build the Spring Boot application
RUN mvn clean package -DskipTests

# Use an official OpenJDK runtime for running the application
FROM openjdk:17-jdk-slim

# Set the working directory in the Docker container
WORKDIR /app

# Copy the built .jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port Spring Boot runs on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
