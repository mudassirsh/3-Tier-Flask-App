import os
import psycopg2
# from dotenv import load_dotenv
from flask import Flask, request, jsonify, render_template, request, redirect, url_for, jsonify
# from flask_cors import CORS
# from flask_sqlalchemy import SQLAlchemy
import json

app = Flask(__name__)

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=3000)

######  BACK-END

def db_conn():      # we call this funcion when we need to call the database.
    conn = psycopg2.connect(database="flask_db",host="localhost",user="postgres",password="admin",port="5432")
    return conn         # this function will return the connection object.  



# Create table if not exist
conn = db_conn()
cur=conn.cursor()
cur.execute('''CREATE TABLE IF NOT EXISTS "Users_Table" (id serial PRIMARY KEY, username varchar(100),email varchar(120),password varchar(100));''')
# cur.execute('''CREATE TABLE IF NOT EXISTS users (id serial PRIMARY KEY, username varchar(100),email varchar(120));''')
cur.close()
conn.close()

######  BACK-g on port 5000END  --- runnin

@app.route('/get_list', methods=['GET'])
def index():                ## index view funcion 
    conn = db_conn()        ## inside the index func we open a db connection 
    cur = conn.cursor()
    cur.execute('''SELECT * FROM "Users_Table"''') # we can use the execute method of the cursor to select everything from customers table
    # cur.execute('''SELECT * FROM "users"''') # we can use the execute method of the cursor to select everything from customers table
    data_list = cur.fetchall() #use fetch all method to save the data in variable called 'data'
    #print(data_list)
    cur.close()     # now we can close the cursor and connection
    conn.close()
    return data_list
    #return render_template('create.html', data_list=data_list)

    # finally we have to return a call to the render template function to render a template file called index.html for passing it the list of customer. 
    #return render_template('index.html', data = data_list)

######  BACK-END

@app.route('/create', methods=['POST'])
def create():
    conn = db_conn()         
    cur = conn.cursor()
    username = request.form['username']
    email = request.form['email']
    password = request.form['password']
    # data = request.json
    cur.execute('''INSERT INTO "Users_Table" (username,email,password) VALUES (%s,%s,%s)''',(username, email, password)) 
    #cur.execute('''INSERT INTO users (username,email) VALUES (%s{"key":"value"},%s{"key":"value"})''', username=data['username'].json, email=data['email'].json,)
    # cur.execute('INSERT INTO users (username, email)'
    #                 'VALUES (%s, %s)',
    #                 (username, email))
    conn.commit() 
    cur.close()     
    conn.close()
   #return redirect(url_for('index'))
    return "User created"

    # data = request.get_json()
    # new_customer = Users(username=data['username'], email=data['email'], password=data['password'])
    # db.session.add(new_customer)

################################



# load_dotenv()
# CORS(app)  # Enable CORS for all routes

# app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:admin@localhost:5432/flask_db'

# db = SQLAlchemy(app)
# db = SQLAlchemy(db_conn)

# class Users(db.Model):
#     __tablename__ = 'Users_Table'  
#     id = db.Column(db.Integer, primary_key=True, autoincrement=True)
#     username = db.Column(db.String(200), nullable=True)
#     email = db.Column(db.String(200), nullable=True)
#     password = db.Column(db.String(20), nullable=True)

# with app.app_context():
#     db.create_all()


# @app.route('/return_message')
# def return_message():
#     return 'this message is from Backend'




# @app.route('/customers-list', methods=['GET'])
# def get_customers():
#     customers = Users.query.all()
#     cust_list = [
#         {'username': cust.username, 'email': cust.email, 'password': cust.password} for cust in customers
#     ]
#     return jsonify({'Customers': cust_list})





# @app.route('/create-customer', methods=['POST'])
# def create_customer():
#     data = request.get_json()
#     new_customer = Users(username=data['username'], email=data['email'], password=data['password'])
#     db.session.add(new_customer)
#     db.session.commit()
#     return jsonify({'message': 'User Created'}), 201


# if __name__ == '__main__':
#      app.run(debug=True)


# # if __name__ == '__main__':
# #     app.run(debug=True, port=8001)


# # if __name__ == '__main__':
# #     app.run(host="localhost", port=8000, debug=True)





#########################
#########################


# import os
# import psycopg2
# from flask import Flask, render_template, jsonify

# app = Flask(__name__)

# def get_db_connection():
#     conn = psycopg2.connect(database='flask_db_books',
#                             host='localhost',
#                             user="postgres",
#                             password="admin",
#                             port="5432")
#     return conn


# @app.route('/')
# def index():
#     conn = get_db_connection()
#     cur = conn.cursor()
#     cur.execute('SELECT * FROM books;')
#     books = cur.fetchall()
#     print(books)
#     cur.close()
#     conn.close()
#    # return render_template('index.html', books=books)
#     #return (books=books)
#     return books

# # ...

# @app.route('/create', methods=["POST"])
# def create():
#     data = request.get_json()
#     title = data['title']
#     author = data['author']
#     pages_num = data['pages_num']
#     review = data['review']
#     # title = request.json['title']
#     # author = request.json['author']
#     # pages_num = int(request.form['pages_num'])
#    # review = request.form['review']
   
#     conn = get_db_connection()
#     cur = conn.cursor()
#     cur.execute('INSERT INTO books (title, author, pages_num, review)'
#                 'VALUES (%s, %s, %s, %s)',
#                 (title, author, pages_num, review))
#     conn.commit()
#     cur.close()
#     conn.close()
#  #      return redirect(url_for('index'))
#  #   return "record created"    


#  #  return render_template('create.html')
#     return "record created"



######


# cur.execute('INSERT INTO books (title, author, pages_num, review)'
#             'VALUES (%s, %s, %s, %s)',
#             ('A Tale of Two Cities',
#              'Charles Dickens',
#              489,
#              'A great classic!')
#             )


# cur.execute('INSERT INTO books (title, author, pages_num, review)'
#             'VALUES (%s, %s, %s, %s)',
#             ('Anna Karenina',
#              'Leo Tolstoy',
#              864,
#              'Another great classic!')
#             )

# conn.commit()

# cur.close()
# conn.close()