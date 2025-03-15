import datetime
from flask import Flask, Response
import json
import pymysql

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False

def get_connection():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='123456',  # 请替换为你的密码
        db='schoolDB',            # 请替换为你的数据库名称
        charset='utf8mb4',
        use_unicode=True,
        cursorclass=pymysql.cursors.DictCursor
    )

def default_converter(o):
    if isinstance(o, (datetime.date, datetime.datetime)):
        return o.isoformat()
    raise TypeError("Type not serializable")

@app.route('/query1')
def query1():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM Student WHERE Smajor = %s"
            cursor.execute(sql, ('信息安全',))
            result = cursor.fetchall()
        json_str = json.dumps(result, ensure_ascii=False, default=default_converter)
        return Response(json_str, mimetype='application/json; charset=utf-8')
    finally:
        conn.close()

if __name__ == '__main__':
    app.run(debug=True)
