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
