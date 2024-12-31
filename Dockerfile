FROM python:3

# Install distutils for Python 3.12+
RUN apt-get update && apt-get install -y python3-distutils && apt-get clean

# Set the working directory
WORKDIR /data

# Copy the application code
COPY . .

# Create a virtual environment
RUN python -m venv venv

# Activate virtual environment and install dependencies
RUN . venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt

# Apply migrations
RUN . venv/bin/activate && python manage.py migrate

# Expose the port for the Django app
EXPOSE 8000

# Run the application
CMD ["sh", "-c", ". venv/bin/activate && python manage.py runserver 0.0.0.0:8000"]
