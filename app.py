from flask import Flask
import psycopg2

app = Flask(__name__)



@app.route('/')
def hello_world():
    return 'Flask dockerized'

@app.route('/students')
def create_database():
    conn = None
    cur = None
    Return_value = 'error 404'
    try:

        conn = psycopg2.connect(host='localhost', database='exampleFLAST', user='postgres', password='password', port=5432)
        cur = conn.cursor()
        # cur.execute(f'CREATE TABLE students (name varchar(255) ,ID int);')
        # cur.execute(f'INSERT INTO students (name, ID) VALUES(\'John\', 1);')
        cur.execute(f'SELECT * FROM students;')
        students = cur.fetchall()
        Return_value = students

    except Exception as e:
        print(e)
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()

    return str(Return_value)

if __name__ =='__main__':
    app.run(debug=True, host='0.0.0.0')

