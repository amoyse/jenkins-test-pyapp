FROM python:3.12.1-slim-bookworm
WORKDIR /app
COPY . .
RUN pip3 install -r requirements.txt
CMD ["python","app.py"]
EXPOSE 5000
