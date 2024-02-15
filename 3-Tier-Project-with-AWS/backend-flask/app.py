from flask import Flask, request, jsonify
import os
#from dotenv import load_dotenv
import boto3
from botocore.config import Config


app = Flask(__name__)


# Load environment variables from .env file

my_config = Config(
    region_name=os.getenv('REGION')
)

rds_data = boto3.client( 'rds-data', config=my_config, aws_access_key_id=os.getenv('AWS_ACCESS_KEY_ID'),  aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY'))


# Database Configuration Items
aurora_db_name = os.getenv('DB_NAME')
aurora_cluster_arn = os.getenv('CLUSTER_ARN')
aurora_secret_arn = os.getenv('SECRET_ARN')

@app.route('/get_list')
def getPersons():
    response = callDbWithStatement("SELECT * FROM users")
    records = response['records']

    persons = []

    for record in records:
        person = {
            'username': record[1]['stringValue'],
            'email': record[2]['stringValue'],
            'password': record[3]['stringValue']
        }
        persons.append(person)

    print(persons)
    #return jsonify(persons)
    return jsonify({'Customers': persons})

@app.route('/create', methods=['POST'])
def createPerson():
    request_data = request.get_json()
    username = request_data['username']
    email = request_data['email']
    password = request_data['password']
    callDbWithStatement("INSERT INTO users(username, email, password) VALUES ('"
                        + username + "', '" + email + "', '" + password + "');")
    return "ok"

def callDbWithStatement(statement):
    response = rds_data.execute_statement(
        database=aurora_db_name,
        resourceArn=aurora_cluster_arn,
        secretArn=aurora_secret_arn,
        sql=statement,
        includeResultMetadata=True
    )

    return response

if __name__ == '__main__':
    app.run(threaded=True, host='0.0.0.0')
