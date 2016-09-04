from bottle import route, run
# MySQLドライバはmysql.connector
import mysql.connector
# hostのIPアドレスは、$ docker inspect {データベースのコンテナ名}で調べる
# MySQLのユーザやパスワード、データベースはdocker-compose.ymlで設定したもの
connector = mysql.connector.connect(
            user='python',
            password='python',
            host='178.10.0.3',
            database='sample')

cursor = connector.cursor()
cursor.execute("select * from users")

disp = ""
for row in cursor.fetchall():
    disp = "ID:" + str(row[0]) + "  名前:" + row[1]

cursor.close
connector.close
			
@route('/hello')
def hello():

    return "DBから取得 "+disp

run(host='0.0.0.0', port=8080, debug=True, reloader=True)