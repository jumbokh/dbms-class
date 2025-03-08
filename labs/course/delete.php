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
