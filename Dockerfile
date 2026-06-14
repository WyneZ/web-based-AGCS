FROM python:3.11-slim

# Install system libraries required by OpenCV (libGL etc.) and common utilities
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       libgl1-mesa-glx \
       libglib2.0-0 \
       libsm6 \
       libxrender1 \
       libxext6 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements and install Python deps
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . ./

EXPOSE 8501

# Default command to run the Streamlit app
CMD ["streamlit", "run", "combine2.py", "--server.enableCORS", "false", "--server.enableXsrfProtection", "false"]
