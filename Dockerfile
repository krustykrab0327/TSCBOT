FROM python:3.11-slim

WORKDIR /app

# 安裝系統依賴
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

# 先安裝 gunicorn 和 requirements
COPY requirements.txt .
RUN pip install --no-cache-dir gunicorn
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# 直接在這裡指定啟動指令
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 300 main:app