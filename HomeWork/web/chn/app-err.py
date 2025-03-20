from flask import Flask, Response
import json
import pymysql

app = Flask(__name__)
# 关闭 Flask jsonify 默认的 ASCII 编码
app.config['JSON_AS_ASCII'] = False

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

# 示例接口，直接用 Response 返回经过 json.dumps 的结果
@app.route('/test')
def test():
    # 模拟查询结果（也可以通过数据库查询获得）
    data = [
        {
            "Sbirthdate": "2000-03-08",
            "Smajor": "信息安全",
            "Sname": "张三",
            "Sno": "20180001",
            "Ssex": "男"
        },
        {
            "Sbirthdate": "2000-12-15",
            "Smajor": "信息安全",
            "Sname": "王五",
            "Sno": "20180003",
            "Ssex": "男"
        }
    ]
    # 用 json.dumps 指定 ensure_ascii=False
    json_str = json.dumps(data, ensure_ascii=False)
    return Response(json_str, mimetype='application/json; charset=utf-8')

# 例如查询 Student 表中专业为“信息安全”的所有记录
@app.route('/query1')
def query1():
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            sql = "SELECT * FROM Student WHERE Smajor = %s"
            cursor.execute(sql, ('信息安全',))
            result = cursor.fetchall()
        # 这里直接使用 json.dumps 返回
        json_str = json.dumps(result, ensure_ascii=False)
        return Response(json_str, mimetype='application/json; charset=utf-8')
    finally:
        conn.close()

if __name__ == '__main__':
    app.run(debug=True)
