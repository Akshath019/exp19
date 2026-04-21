FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY . /app
RUN javac Grade.java
CMD ["Java","Grage"]
