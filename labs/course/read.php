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
