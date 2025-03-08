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
