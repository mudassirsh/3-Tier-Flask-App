# Base Image
FROM python:3.10.5-slim-buster

# Application directory 
WORKDIR /app

# Install requirements 
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Copy application
COPY . .

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0", "port=5000"]
