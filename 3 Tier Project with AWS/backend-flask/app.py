import os
from os import environ
import psycopg2
from dotenv import load_dotenv
from flask import Flask, request, jsonify 
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
import time
import boto3
from botocore.config import Config


app = Flask(__name__)


my_config = Config(
    region_name= 'us-east-1'
)


rds_data = boto3.client('rds-data', config=my_config, aws_access_key_id={os.getenv('ACCESS_KEY')}, aws_secret_access_key={os.getenv('SECRET_KEY_ID')})


#Database Configuration Items
aurora_db_name = environ.get['DB_NAME']
aurora_cluster_arn = environ.get['CLUSTER_ARN']
aurora_secret_arn = environ.get['SECRET_ARN']

time.sleep(5)




#load_dotenv()
#CORS(app)       # Enable CORS for all routes


#app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:postgres@localhost:5432/flask_db'
#SQLALCHEMY_DATABASE_URI = f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"

# SQLALCHEMY_DATABASE_URI =environ.get('DB_URL')

# app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI



# db = SQLAlchemy(app)




# class Users(db.Model):
#     __tablename__ = 'Users_Table'  
#     id = db.Column(db.Integer, primary_key=True, autoincrement=True)
#     username = db.Column(db.String(200), nullable=True)
#     email = db.Column(db.String(200), nullable=True)
#     password = db.Column(db.String(20), nullable=True)
   
# with app.app_context(): 
#     db.create_all()




# @app.route('/get_list', methods=['GET'])
# def get_customers():
#     customers = Users.query.all()
#     cust_list = [
#         {'username': cust.username, 'email': cust.email, 'password': cust.password} for cust in customers
#     ]
#     return jsonify({'Customers': cust_list})


@app.route('/get_list', methods=['GET'])
def getPerson():
    personId = request.args.get('personId')
    response = callDbWithStatement("SELECT * FROM persons" )
    person = {}
    
    # records = response['records'] 
    # person = [
    #     {'username': record.username, 'email': cust.email, 'password': cust.password} for record in records 
    # ]

    records = response['records']
    for record in records:
        person['personId'] = record[0]['longValue']
        person['firstName'] = record[1]['stringValue']
        person['lastName'] = record[2]['stringValue']
    return jsonify({'Customers': person})


# @app.route('/create', methods=['POST'])
# def create_customer():
#     data = request.get_json()
#     new_customer = Users(username=data['username'], email=data['email'], password=data['password'])
#     db.session.add(new_customer)
#     db.session.commit()
#     return jsonify({'message': 'User Created'}), 201



@app.route('/create', methods=['POST']) # API 2 - createPerson
def createPerson():
    request_data = request.get_json()
    username = request_data['username']
    email = request_data['email']
    password = password(request_data['password'])
    callDbWithStatement("INSERT INTO Persons(personId, firstName, lastName) VALUES ('" 
    + username + "', '" + email + "', '" + password + "');")
    return ""



def callDbWithStatement(statement):
    response = rds_data.execute_statement(
            database = aurora_db_name,
            resourceArn = aurora_cluster_arn,
            secretArn = aurora_secret_arn,
            sql = statement,            
        )
    print(response) #Delete this in production
    return response



if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)



