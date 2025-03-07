import pymysql
import matplotlib.pyplot as plt
import charts
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
    # 建立Cursor物件
    with conn.cursor() as cursor:
        #資料表相關操作
        # 新增資料SQL語法
        command = "INSERT INTO charts(id, name, artist)VALUES(%s, %s, %s)"
        # 取得華語單曲日榜
        charts = charts.get_charts_tracks("H_PilcVhX-E8N0qr1-")
        for chart in charts:
            cursor.execute(
                command, (chart["id"], chart["name"], chart["album"]["artist"]["name"]))
        # 儲存變更
        conn.commit()
except Exception as ex:
    print(ex)
