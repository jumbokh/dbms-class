# PHP 學生選課 CRUD

## 1. PHP 學生選課 CRUD

**system**: 

```
You are a helpful assistant.
```

**user**: 

```
寫一個 php 程序, 連接本地端的 mysql 主機, mysql 登入使用者 root, 密碼 123456 , 請以學生選課為主題, 分次展示 CRUD 功能
```

**assistant**: 

```
好的，我們將使用 PHP 和 MySQL 來實現一個簡單的学生选课系統。這個系統會包括創建（Create）、讀取（Read）、更新（Update）和刪除（Delete）功能。

首先，請確保您的本地端已經安裝了 MySQL 與 PHP 環境，並且有 `root` 使用者與密碼 `123456` 可以使用。

### 1. 創建資料庫與表格
在開始前，請先創建一個名為 `school_db` 的數據庫，然後再這個數據庫中創建兩個表格：`students` 和 `courses`。此外，還有一個關聯表格 `enrollments` 用來記錄學生選課的信息。


CREATE DATABASE school_db;

USE school_db;

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);


### 2. 創建 PHP 程序

#### a. 連接 MySQL 資料庫
首先，我們需要一個函數來連接到MySQL資料庫。


<?php
function connectDB() {
    $host = '127.0.0.1';
    $dbname = 'school_db';
    $username = 'root';
    $password = '123456';

    try {
        $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $pdo;
    } catch (PDOException $e) {
        echo 'Connection failed: ' . $e->getMessage();
        exit;
    }
}
?>


#### b. 創建（Create）
接下來，我們將實現添加學生和課程的功能。


<?php
// 添加學生
function addStudent($name, $email) {
    global $pdo;
    try {
        $stmt = $pdo->prepare("INSERT INTO students (name, email) VALUES (:name, :email)");
        $stmt->execute([':name' => $name, ':email' => $email]);
        return true;
    } catch (PDOException $e) {
        echo 'Error adding student: ' . $e->getMessage();
        return false;
    }
}

// 添加課程
function addCourse($title, $description = '') {
    global $pdo;
    try {
        $stmt = $pdo->prepare("INSERT INTO courses (title, description) VALUES (:title, :description)");
        $stmt->execute([':title' => $title, ':description' => $description]);
        return true;
    } catch (PDOException $e) {
        echo 'Error adding course: ' . $e->getMessage();
        return false;
    }
}

// 範例：添加學生和課程
$pdo = connectDB();
addStudent('John Doe', 'john@example.com');
addCourse('PHP Programming', 'Learn PHP from scratch.');
?>


#### c. 讀取（Read）
接下來，我們將實現讀取學生和課程的功能。


<?php
// 取得所有學生
function getAllStudents() {
    global $pdo;
    try {
        $stmt = $pdo->query("SELECT * FROM students");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        echo 'Error getting students: ' . $e->getMessage();
        return [];
    }
}

// 取得所有課程
function getAllCourses() {
    global $pdo;
    try {
        $stmt = $pdo->query("SELECT * FROM courses");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        echo 'Error getting courses: ' . $e->getMessage();
        return [];
    }
}

// 範例：列出所有學生和課程
$students = getAllStudents();
$courses = getAllCourses();

echo '<h2>Students</h2>';
foreach ($students as $student) {
    echo "ID: {$student['id']}, Name: {$student['name']}, Email: {$student['email']}<br>";
}

echo '<h2>Courses</h2>';
foreach ($courses as $course) {
    echo "ID: {$course['id']}, Title: {$course['title']}, Description: {$course['description']}<br>";
}
?>


#### d. 更新（Update）
接下來，我們將實現更新學生和課程的功能。


<?php
// 更新學生信息
function updateStudent($id, $name, $email) {
    global $pdo;
    try {
        $stmt = $pdo->prepare("UPDATE students SET name = :name, email = :email WHERE id = :id");
        $stmt->execute([':name' => $name, ':email' => $email, ':id' => $id]);
        return true;
    } catch (PDOException $e) {
        echo 'Error updating student: ' . $e->getMessage();
        return false;
    }
}

// 更新課程信息
function updateCourse($id, $title, $description = '') {
    global $pdo;
    try {
        $stmt = $pdo->prepare("UPDATE courses SET title = :title, description = :description WHERE id = :id");
        $stmt->execute([':title' => $title, ':description' => $description, ':id' => $id]);
        return true;
    } catch (PDOException $e) {
        echo 'Error updating course: ' . $e->getMessage();
        return false;
    }
}

// 範例：更新學生和課程
updateStudent(1, 'John Smith', 'john.smith@example.com');
updateCourse(1, 'Advanced PHP Programming', 'Deep dive into PHP.');
?>


#### e. 刪除（Delete）
接下來，我們將實現刪除學生和課程的功能。


<?php
// 刪除學生
function deleteStudent($id) {
    global $pdo;
    try {
        $stmt = $pdo->prepare("DELETE FROM students WHERE id = :id");
        $stmt->execute([':id' => $id]);
        return true;
    } catch (PDOException $e) {
        echo 'Error deleting student: ' . $e->getMessage();
        return false;
    }
}

// 刪除課程
function deleteCourse($id) {
    global $pdo;
    try {
        $stmt = $pdo->prepare("DELETE FROM courses WHERE id = :id");
        $stmt->execute([':id' => $id]);
        return true;
    } catch (PDOException $e) {
        echo 'Error deleting course: ' . $e->getMessage();
        return false;
    }
}

// 範例：刪除學生和課程
deleteStudent(1);
deleteCourse(1);
?>


### 3. 學生選課功能

#### a. 添加選課記錄

<?php
function enrollStudentInCourse($studentId, $courseId) {
    global $pdo;
    try {
        $stmt = $pdo->prepare("INSERT INTO enrollments (student_id, course_id) VALUES (:student_id, :course_id)");
        $stmt->execute([':student_id' => $studentId, ':course_id' => $courseId]);
        return true;
    } catch (PDOException $e) {
        echo 'Error enrolling student in course: ' . $e->getMessage();
        return false;
    }
}

// 範例：讓學生 1 選擇課程 2
enrollStudentInCourse(1, 2);
?>


#### b. 讀取選課記錄

<?php
function getEnrolledCourses($studentId) {
    global $pdo;
    try {
        $stmt = $pdo->prepare("SELECT courses.* FROM enrollments JOIN courses ON enrollments.course_id = courses.id WHERE enrollments.student_id = :student_id");
        $stmt->execute([':student_id' => $studentId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        echo 'Error getting enrolled courses: ' . $e->getMessage();
        return [];
    }
}

// 範例：取得學生 1 的選課記錄
$enrolledCourses = getEnrolledCourses(1);

echo '<h2>Enrolled Courses for Student ID 1</h2>';
foreach ($enrolledCourses as $course) {
    echo "ID: {$course['id']}, Title: {$course['title']}, Description: {$course['description']}<br>";
}
?>


#### c. 取消選課

<?php
function unenrollStudentFromCourse($studentId, $courseId) {
    global $pdo;
    try {
        $stmt = $pdo->prepare("DELETE FROM enrollments WHERE student_id = :student_id AND course_id = :course_id");
        $stmt->execute([':student_id' => $studentId, ':course_id' => $courseId]);
        return true;
    } catch (PDOException $e) {
        echo 'Error unenrolling student from course: ' . $e->getMessage();
        return false;
    }
}

// 範例：讓學生 1 取消選擇課程 2
unenrollStudentFromCourse(1, 2);
?>


這是一個基本的範例，您可以根據需要進行擴展和修改。希望這個範例對您有幫助！
```



--------------------


<a href="https://chatboxai.app" style="display: flex; align-items: center;">
<img src='https://chatboxai.app/icon.png' style='width: 40px; height: 40px; padding-right: 6px'>
<b style='font-size:30px'>Chatbox AI</b>
</a>
