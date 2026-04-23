# 🚀 DevOps Experiments (16–20)

---

## 🔹 Experiment 20: CI/CD Pipeline

### 📌 Steps

```bash
mvn archetype:generate
GroupId: com.example
ArtifactId: cicd-demo
cd cicd-demo
```

### 📦 Dependencies (pom.xml)

```xml
<dependencies>
  <dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>4.0.1</version>
    <scope>provided</scope>
  </dependency>

  <dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>5.10.0</version>
    <scope>test</scope>
  </dependency>
</dependencies>
```

---

### ☕ HelloServlet.java

```java
package com.example;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class HelloServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        res.setContentType("text/html");
        res.getWriter().println("<h1>CI/CD Working</h1>");
    }
}
```

---

### ⚙️ web.xml

```xml
<servlet>
  <servlet-name>Hello</servlet-name>
  <servlet-class>com.example.HelloServlet</servlet-class>
</servlet>

<servlet-mapping>
  <servlet-name>Hello</servlet-name>
  <url-pattern>/hello</url-pattern>
</servlet-mapping>
```

---

### 🧪 Test Case

```java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class TestSample {
    @Test
    void test() {
        assertEquals(2, 1 + 1);
    }
}
```

---

### 🐳 Dockerfile

```dockerfile
FROM tomcat:9-jdk17
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war
```

---

### ▶️ Run Commands

```bash
mvn clean package
docker build -t cicd-app .
docker run -d -p 8087:8080 cicd-app
```

---

### ⚙️ Jenkins Pipeline

```groovy
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Run') {
            steps {
                sh 'docker build -t cicd-app .'
                sh 'docker run -d -p 8087:8080 cicd-app'
            }
        }
    }

    post {
        always {
            junit '**/target/surefire-reports/*.xml'
        }
    }
}
```

---

## 🔹 Experiment 19: Jenkins + Docker

```groovy
pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t my-app .'
            }
        }

        stage('Run Container') {
            steps {
                bat 'docker run my-app'
            }
        }
    }
}
```

---

## 🔹 Experiment 18: Docker Hub Push

```dockerfile
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY . /app
RUN javac Grade.java
CMD ["java", "Grade"]
```

```bash
docker build -t java-app .
docker login
docker tag java-app yourusername/java-app:v1
docker push yourusername/java-app:v1
```

---

## 🔹 Experiment 17: Docker Volume

```bash
docker run -d -p 8080:80 nginx
docker volume create myvolume

docker run -it -v myvolume:/data ubuntu bash
echo "Hello from Docker Volume" > /data/test.txt

docker run -it -v myvolume:/data ubuntu bash
cat /data/test.txt

docker run -d -p 8081:80 -v myvolume:/usr/share/nginx/html nginx
```

---

## 🔹 Experiment 16: Python Docker App

```python
from http.server import SimpleHTTPRequestHandler, HTTPServer

PORT = 5020

class MyHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(b"<h1>Hello from Docker Python Container</h1>")

server = HTTPServer(("0.0.0.0", PORT), MyHandler)
server.serve_forever()
```

```dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY app.py .
EXPOSE 5020
CMD ["python", "app.py"]
```

```bash
docker build -t my-python-app .
docker run -d -p 5020:5020 my-python-app
```

---

## 🔹 Experiment 14: JaCoCo

```xml
<build>
    <plugins>

        <plugin>
            <groupId>org.jacoco</groupId>
            <artifactId>jacoco-maven-plugin</artifactId>
            <version>0.8.11</version>

            <executions>
                <execution>
                    <goals>
                        <goal>prepare-agent</goal>
                    </goals>
                </execution>

                <execution>
                    <id>report</id>
                    <phase>verify</phase>
                    <goals>
                        <goal>report</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>

    </plugins>
</build>
```

---
	
