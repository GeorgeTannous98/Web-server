FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y python3
RUN apt-get -y install python3-pip
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip3 install -r requirements.txt
COPY . /app

CMD ["python3","app.py"]