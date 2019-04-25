FROM python:3

WORKDIR /usr/src/app

COPY . .
RUN pip install flask

EXPOSE 5000

ENTRYPOINT [ "python", "main.py" ]