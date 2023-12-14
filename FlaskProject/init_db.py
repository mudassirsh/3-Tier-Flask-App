# import psycopg2

# #Create table if not exist

# conn = psycopg2.connect(database="flask_db",host="localhost",user="postgres",password="admin",port="5432")
# cur=conn.cursor()
# cur.execute('''CREATE TABLE IF NOT EXISTS customers (id serial PRIMARY KEY, username varchar(100), email varchar(120));''')
# cur.execute('''INSERT INTO customers (username, email) VALUES ('mudassir','mudassir@hotmail.com');''')
# conn.commit
# cur.close()
# cur.close()
