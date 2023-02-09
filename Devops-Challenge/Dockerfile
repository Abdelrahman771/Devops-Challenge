FROM python:3.8-alpine
WORKDIR /app 
COPY  requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD export $(cat .env | xargs) && python3 hello.py 
