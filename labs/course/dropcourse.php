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
