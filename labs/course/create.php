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
