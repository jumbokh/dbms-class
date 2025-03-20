from flask import Flask, jsonify
import pymysql

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False   # 关闭 ASCII 转义，直接输出中文


# 配置 MySQL 数据库连接参数
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '123456'   # 请替换为你的密码
app.config['MYSQL_DB'] = 'schooldb'           # 请替换为你的数据库名称

def get_connection():
    return pymysql.connect(
        host=app.config['MYSQL_HOST'],
        user=app.config['MYSQL_USER'],
        password=app.config['MYSQL_PASSWORD'],
        db=app.config['MYSQL_DB'],
        charset='utf8mb4',
        use_unicode=True,
        cursorclass=pymysql.cursors.DictCursor
    )

# 题目1：查询专业为“信息安全”的所有学生记录
@app.route('/query1')
def query1():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM Student WHERE Smajor = %s"
            cursor.execute(sql, ('信息安全',))
            result = cursor.fetchall()
        return jsonify(result)
    finally:
        conn.close()

# 题目2：查询出生日期在2001年1月1日及以后的学生记录
@app.route('/query2')
def query2():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM Student WHERE Sbirthdate >= %s"
            cursor.execute(sql, ('2001-01-01',))
            result = cursor.fetchall()
        return jsonify(result)
    finally:
        conn.close()

# 题目3：查询所有学生的姓名和主修专业
@app.route('/query3')
def query3():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT DISTINCT Sname, Smajor FROM Student"
            cursor.execute(sql)
            result = cursor.fetchall()
        return jsonify(result)
    finally:
        conn.close()

# 题目4：查询所有不同的主修专业
@app.route('/query4')
def query4():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT DISTINCT Smajor FROM Student"
            cursor.execute(sql)
            result = cursor.fetchall()
        return jsonify(result)
    finally:
        conn.close()

# 题目5：查询选修课程号为“81003”的学生的学号、姓名和成绩
@app.route('/query5')
def query5():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = """
                SELECT SC.Sno, Student.Sname, SC.Grade
                FROM SC
                INNER JOIN Student ON SC.Sno = Student.Sno
                WHERE SC.Cno = %s
            """
            cursor.execute(sql, ('81003',))
            result = cursor.fetchall()
        return jsonify(result)
    finally:
        conn.close()

# 题目6：查询至少选修了课程集合 K = {'81005', '81007'} 中所有课程的学生的学号
@app.route('/query6')
def query6():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = """
                SELECT Sno
                FROM SC
                WHERE Cno IN (%s, %s)
                GROUP BY Sno
                HAVING COUNT(DISTINCT Cno) = 2
            """
            cursor.execute(sql, ('81005', '81007'))
            result = cursor.fetchall()
        return jsonify(result)
    finally:
        conn.close()

# 题目7：查询至少选修了“81001”和“81003”两门课程的学生的学号
@app.route('/query7')
def query7():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = """
                SELECT Sno
                FROM SC
                WHERE Cno IN (%s, %s)
                GROUP BY Sno
                HAVING COUNT(DISTINCT Cno) = 2
            """
            cursor.execute(sql, ('81001', '81003'))
            result = cursor.fetchall()
        return jsonify(result)
    finally:
        conn.close()

# 题目8：查询选修课程号为“81002”的学生的学号
@app.route('/query8')
def query8():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT DISTINCT Sno FROM SC WHERE Cno = %s"
            cursor.execute(sql, ('81002',))
            result = cursor.fetchall()
        return jsonify(result)
    finally:
        conn.close()

if __name__ == '__main__':
    app.run(debug=True)
