
from flask import Flask,render_template, request, redirect, url_for, jsonify
import requests
import json


app = Flask(__name__)




@app.route('/test')
def get_message():
    message = requests.get('http://localhost:5000/return_message')
    return message.text


##FRONT-END----- running on port 3000 

@app.route('/')     ## Get Method
def get_pull():
    try:
        response = requests.get('http://localhost:5000/get_list')
        response.raise_for_status()  # Raise  HTTPError for the bad responses
 
        customer_list = response.json()
        print(customer_list)
        return render_template('index.html', customer_list=customer_list)
    except requests.exceptions.RequestException as e:
        return f"Error: {e}"



##FRONT-END

# @app.route('/create', methods=('GET', 'POST'))
# def create():
#    if request.method == 'POST':
#        username = request.form.get['username']
#        email = request.form.get['email']
#        password = request.form.get['password']
#        data = {
#            'username': username,
#            'email': email,
#            'password': password
#        }
#        print('This is username ',data.username)
#        backend_url = 'http://localhost:5000/create'
#        response = requests.post(backend_url, json=data)
#        return redirect(url_for('index'))    #jsonify(success=True, message="User created successfully")
       
#    return render_template('create.html')



# @app.route('/create' methods=['POST'])
# def get_post():
#     try:
#         username = request.form['username']
#         email = request.form['email']
#         password = request.form['password']
#         url = 'http://localhost:5000/create?username=${username}&email=${email}&password=${password}';         
        
#         # response = requests.post('http://localhost:5000/create')
#         # response.raise_for_status()  # Raise  HTTPError for the bad responses
 
#         # customer_list = response.json()
#         # print(customer_list)
#         return redirect(url_for('index.html'))
#     except requests.exceptions.RequestException as e:
#         return f"Error: {e}"



# @app.route('/create')
# def get_post():
#     try:
#         username = request.form['username']
#         email = request.form['email']
#         password = request.form['password']
#         url = 'http://localhost:5000/create?username={username}&email={email}&password={password}'
       
        
#         # response = requests.post('http://localhost:5000/create')
#         # response.raise_for_status()  # Raise  HTTPError for the bad responses
 
#         # customer_list = response.json()
#         # print(customer_list)
#         return redirect(url_for('get_pull'))
#     except requests.exceptions.RequestException as e:
#         return f"Error: {e}"




# @app.route('/create', methods=('GET', 'POST'))
# def create():

#     data = request.post_json()
#     if request.method == 'POST':
#         username = request.form['username']
#         email = request.form['email']
#         password = request.form['password']
        
#         #url = 'http://localhost:5000/create?username={username}&email={email}&password={password}'
# #       conn = get_db_connection()
# #       cur = conn.cursor()
# #       cur.execute('INSERT INTO books (title, author, pages_num, review)'
# #                    'VALUES (%s, %s, %s, %s)',
# #                    (title, author, pages_num, review))
# #       conn.commit()
# #       cur.close()
# #       conn.close()       
#         return redirect(url_for('index.html'))

#     return render_template('index.html')



#############################################

# @app.route("/login", methods=["POST", "GET"])
# def login():
#     if request.method == "POST":
#         user = request.form["name of field"]
#         return redirect(url_for("user", usr=user))
#     else:
#         return render_template("login.html")



# @app.route("/<usr>")
# def user(usr):
#     return f"<h1>{usr}</h1>"