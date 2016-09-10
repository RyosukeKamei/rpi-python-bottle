# bottleのライブラリ
from bottle import route, run, request

# MySQLドライバはmysql.connector
import mysql.connector

# 補足
# 本当はテンプレートを入れるとHTMLが綺麗になります。
# その辺は後日…

# hostのIPアドレスは、$ docker inspect {データベースのコンテナ名}で調べる
# MySQLのユーザやパスワード、データベースはdocker-compose.ymlで設定したもの
# user     : MYSQL_USER
# password : MYSQL_PASSWORD
# database : MYSQL_DATABASE
connector = mysql.connector.connect (
            user     = 'bottle',
            password = 'bottle',
            host     = '172.17.0.3',
            database = 'measurement'
)


			
@route('/list')
def list():
    # 温度を表示
    cursor = connector.cursor()
    cursor.execute("select `id`, `temperature`, `careted_at` from temperatures")

    disp  = "<table>"
    # ヘッダー
    disp += "<tr><th>ID</th><th>温度</th><th>登録日</th></tr>"
    
    # 一覧部分
    for row in cursor.fetchall():
        disp += "<tr><td>" + str(row[0]) + "</td><td>" + str(row[1]) + "</td><td>" + str(row[2]) + "</td></tr>"
    
    disp += "</table>"
    
    cursor.close

    return "DBから取得 "+disp

@route('/input_temperature')
def input_temperature():
    # 温度を入力
    cursor = connector.cursor()
    cursor.execute("INSERT INTO `temperatures` (`server_id`, `temperature`, `careted_at`, `careted_user`, `updated_at`, `updated_user`) VALUES (" + request.query.server_id + ", " + request.query.temperature + ", NOW(), " + request.query.user_id + ", NOW(), " + request.query.user_id + ")

    # コミット
    connector.commit();

    cursor.close

    return true
    

# コネクターをクローズ
connector.close

# サーバ起動
run(host='0.0.0.0', port=8080, debug=True, reloader=True)