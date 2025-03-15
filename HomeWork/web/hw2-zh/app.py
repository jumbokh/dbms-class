from flask import Flask, Response
import json
import pymysql
import datetime

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False  # 全局设置不转义中文

def get_connection():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='123456',  # 请替换为你的密码
        db='schoolDB',            # 请替换为你的数据库名称
        charset='utf8mb4',        # 确保使用 utf8mb4 编码
        use_unicode=True,
        cursorclass=pymysql.cursors.DictCursor
    )

# 定义默认转换函数，用于处理日期等非 JSON 序列化对象
def default_converter(o):
    if isinstance(o, (datetime.date, datetime.datetime)):
        return o.isoformat()
    raise TypeError(f"Type {type(o)} not serializable")

# 示例接口：查询专业为“信息安全”的所有学生记录
@app.route('/query1')
def query1():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM Student WHERE Smajor = %s"
            cursor.execute(sql, ('信息安全',))
            result = cursor.fetchall()
        # 使用 json.dumps 时指定 ensure_ascii=False 和 default 函数
        json_str = json.dumps(result, ensure_ascii=False, default=default_converter)
        return Response(json_str, mimetype='application/json; charset=utf-8')
    finally:
        conn.close()

# 以下各个查询接口也可以采用类似方法，如下给出几个示例

# 查询出生日期在2001-01-01及以后的学生记录
@app.route('/query2')
def query2():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM Student WHERE Sbirthdate >= %s"
            cursor.execute(sql, ('2001-01-01',))
            result = cursor.fetchall()
        json_str = json.dumps(result, ensure_ascii=False, default=default_converter)
        return Response(json_str, mimetype='application/json; charset=utf-8')
    finally:
        conn.close()

# 查询所有学生的姓名和主修专业
@app.route('/query3')
def query3():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT DISTINCT Sname, Smajor FROM Student"
            cursor.execute(sql)
            result = cursor.fetchall()
        json_str = json.dumps(result, ensure_ascii=False, default=default_converter)
        return Response(json_str, mimetype='application/json; charset=utf-8')
    finally:
        conn.close()

if __name__ == '__main__':
    app.run(debug=True)
