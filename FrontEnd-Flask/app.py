
from flask import Flask,render_template, request, redirect, url_for, jsonify
import requests
import json


app = Flask(__name__)




@app.route('/test')
def get_message():
    message = requests.get('http://localhost:5000/return_message')
    return message.text




@app.route('/')
def get_pull():
    try:
        response = requests.get('http://localhost:5000/')
        response.raise_for_status()  # Raise  HTTPError for the bad responses
 
        customer_list = response.json()
        print(customer_list)
        return render_template('index.html', customer_list=customer_list)
    except requests.exceptions.RequestException as e:
        return f"Error: {e}"


@app.route('/create2')
def get_post():
    try:
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        url = 'http://localhost:5000/create?username=${username}&email=${email}&password=${password}';         
        
        # response = requests.post('http://localhost:5000/create')
        # response.raise_for_status()  # Raise  HTTPError for the bad responses
 
        # customer_list = response.json()
        # print(customer_list)
        return redirect(url_for('index.html'))
    except requests.exceptions.RequestException as e:
        return f"Error: {e}"



# @app.route('/create')
# def get_post():

# @app.route('/create/', methods=('GET', 'POST'))
# def create():
#     if request.method == 'POST':
#         title = request.form['title']
#         author = request.form['author']
#         pages_num = int(request.form['pages_num'])
#         review = request.form['review']

#         conn = get_db_connection()
#         cur = conn.cursor()
#         cur.execute('INSERT INTO books (title, author, pages_num, review)'
#                     'VALUES (%s, %s, %s, %s)',
#                     (title, author, pages_num, review))
#         conn.commit()
#         cur.close()
#         conn.close()
#         return redirect(url_for('index'))

#     return render_template('create.html')
