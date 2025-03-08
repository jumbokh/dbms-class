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

**user**: 

```
請以python語言, 再寫一個範例, 此範例在簡單的web環境架構下執行, 也請寫一個控制選單
```

**assistant**: 

```
好的，我們可以使用 Flask 來建立一個簡單的 Web 環境。Flask 是一個用 Python 寫的小型 WSGI 網頁應用框架，常被用來做快速原型開發或小型網站。

首先，你需要安裝 Flask。如果你還沒有安裝，請使用以下命令：


pip install Flask


接下來，我們會建立一個簡單的 Web 應用，並在其中加入一個控制選單。以下是範例代碼：

### 目錄結構


simple_web_app/
│
├── app.py
└── templates/
    └── index.html


### app.py


from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        action = request.form.get('action')
        if action == 'greet':
            return redirect(url_for('greet'))
        elif action == 'info':
            return redirect(url_for('info'))
        elif action == 'contact':
            return redirect(url_for('contact'))
    return render_template('index.html')

@app.route('/greet')
def greet():
    return "Hello! Welcome to our website."

@app.route('/info')
def info():
    return "This is the information page. Here you can find more details about us."

@app.route('/contact')
def contact():
    return "Contact us at: example@example.com"

if __name__ == '__main__':
    app.run(debug=True)


### templates/index.html


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simple Web App</title>
</head>
<body>
    <h1>Welcome to Our Website</h1>
    <form method="post">
        <label for="action">Choose an action:</label>
        <select id="action" name="action">
            <option value="greet">Greet</option>
            <option value="info">Info</option>
            <option value="contact">Contact</option>
        </select>
        <button type="submit">Submit</button>
    </form>
</body>
</html>


### 說明

1. **app.py**: 這是我們的 Flask 應用主程式。它包含三條路由：`/`, `/greet`, 和 `/info`，以及一個控制選單。
2. **templates/index.html**: 這是我們的 HTML 頁面模板，其中包含一個表單和一個選擇菜單（dropdown menu）。用戶可以從中選擇要執行的操作。

### 執行

在終端機中切換到 `simple_web_app` 目錄，然後運行以下命令：


python app.py


這將啟動 Flask 開發伺服器。你可以在瀏覽器中打開 `http://127.0.0.1:5000/` 來查看應用。

希望這個範例能幫助你理解如何在簡單的 Web 環境下使用 Python 和 Flask，以及如何實現一個控制選單。
```

**user**: 

```
我的要求是:寫一個 python 程序, 連接本地端的 mysql 主機, mysql 登入使用者 root, 密碼 123456 , 請以學生選課為主題, 分次展示 CRUD 功能
```

**assistant**: 

```
好的，我們可以使用 `Flask` 搭配 `Flask-SQLAlchemy` 和 `mysql-connector-python` 來建立一個簡單的學生選課系統。這個範例將會包含基本的 CRUD（Create, Read, Update, Delete）功能。

首先，你需要安裝所需的套件：


pip install Flask Flask-SQLAlchemy mysql-connector-python


接下來，我們會建立一個簡單的 Web 應用，並在其中實現學生選課系統。以下是範例代碼：

### 目錄結構


student_course_app/
│
├── app.py
└── templates/
    ├── index.html
    ├── add_student.html
    ├── edit_student.html
    └── student_list.html


### app.py


from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:123456@localhost/student_course_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# 定義學生模型
class Student(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    course = db.Column(db.String(120), nullable=False)

    def __repr__(self):
        return f'<Student {self.name}>'

# 初始化資料庫
with app.app_context():
    db.create_all()

@app.route('/')
def index():
    students = Student.query.all()
    return render_template('student_list.html', students=students)

@app.route('/add', methods=['GET', 'POST'])
def add_student():
    if request.method == 'POST':
        name = request.form.get('name')
        course = request.form.get('course')
        new_student = Student(name=name, course=course)
        db.session.add(new_student)
        db.session.commit()
        return redirect(url_for('index'))
    return render_template('add_student.html')

@app.route('/edit/<int:id>', methods=['GET', 'POST'])
def edit_student(id):
    student = Student.query.get_or_404(id)
    if request.method == 'POST':
        student.name = request.form.get('name')
        student.course = request.form.get('course')
        db.session.commit()
        return redirect(url_for('index'))
    return render_template('edit_student.html', student=student)

@app.route('/delete/<int:id>', methods=['POST'])
def delete_student(id):
    student = Student.query.get_or_404(id)
    db.session.delete(student)
    db.session.commit()
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)


### templates/index.html


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Course Management</title>
</head>
<body>
    <h1>Student Course List</h1>
    <a href="{{ url_for('add_student') }}">Add New Student</a>
    <ul>
        {% for student in students %}
            <li>
                {{ student.name }} - {{ student.course }}
                <form action="{{ url_for('edit_student', id=student.id) }}" method="get" style="display:inline;">
                    <button type="submit">Edit</button>
                </form>
                <form action="{{ url_for('delete_student', id=student.id) }}" method="post" style="display:inline;">
                    <button type="submit">Delete</button>
                </form>
            </li>
        {% endfor %}
    </ul>
</body>
</html>


### templates/add_student.html


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student</title>
</head>
<body>
    <h1>Add New Student</h1>
    <form method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br><br>
        <label for="course">Course:</label>
        <input type="text" id="course" name="course" required><br><br>
        <button type="submit">Add</button>
    </form>
    <a href="{{ url_for('index') }}">Back to List</a>
</body>
</html>


### templates/edit_student.html


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student</title>
</head>
<body>
    <h1>Edit Student</h1>
    <form method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="{{ student.name }}" required><br><br>
        <label for="course">Course:</label>
        <input type="text" id="course" name="course" value="{{ student.course }}" required><br><br>
        <button type="submit">Update</button>
    </form>
    <a href="{{ url_for('index') }}">Back to List</a>
</body>
</html>


### 說明

1. **app.py**: 這是我們的 Flask 應用主程式。它包含以下路由：
   - `/`: 顯示所有學生的列表。
   - `/add`: 新增新學生。
   - `/edit/<int:id>`: 編輯指定 ID 的學生。
   - `/delete/<int:id>`: 刪除指定 ID 的學生。

2. **templates/index.html**: 顯示所有學生的列表，並提供新增、編輯和刪除學生的連結。

3. **templates/add_student.html**: 提供表單以新增新學生。

4. **templates/edit_student.html**: 提供表單以編輯現有的學生。

### 前提條件

- 確保已安裝 MySQL 與 `mysql-connector-python`。
- 在 MySQL 中建立名為 `student_course_db` 的資料庫。


CREATE DATABASE student_course_db;


### 執行應用程式

1. 執行程式：

    
    python app.py
    

2. 開啟瀏覽器並前往 `http://localhost:5000/` 以查看學生課程管理系統。

這樣，您就可以使用這個簡單的 Flask 應用程式來管理學生及其選修的課程。
```



--------------------


<a href="https://chatboxai.app" style="display: flex; align-items: center;">
<img src='https://chatboxai.app/icon.png' style='width: 40px; height: 40px; padding-right: 6px'>
<b style='font-size:30px'>Chatbox AI</b>
</a>
