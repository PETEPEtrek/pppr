FROM python:3.9-slim

WORKDIR /app


COPY app.py requirements.txt ./


RUN pip install --no-cache-dir -r requirements.txt


RUN mkdir -p /app/logs /app/config

EXPOSE 5000

CMD ["python", "app.py"]

