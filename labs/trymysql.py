import pymysql

# 資料庫設定
db_settings = {
    "host": "127.0.0.1",
    "port": 3306,
    "user": "root",
    "password": "123456",
    "db": "school",
    "charset": "utf8"
}
try:
    # 建立Connection物件
    conn = pymysql.connect(**db_settings)
except Exception as ex:
    print(ex)