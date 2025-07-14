# Use a lightweight Python image
FROM python:3.10-slim

# Set environment
ENV TZ=Asia/Kolkata
WORKDIR /app

# Set timezone
RUN apt-get update && \
    apt-get install -y tzdata git curl ffmpeg && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the bot files
COPY . .

# Make startup script executable if needed
RUN chmod +x startup

# Run the bot
CMD ["bash", "startup"]
