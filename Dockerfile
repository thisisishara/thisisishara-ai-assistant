# Extend the official Rasa SDK image
FROM rasa/rasa:2.2.8-full

# Change back to root user to install dependencies
USER root
RUN apt-get --allow-releaseinfo-change update
RUN apt-get -y install software-properties-common
RUN apt-get --allow-releaseinfo-change update
RUN pip3 install --upgrade setuptools pip

# Use subdirectory as working directory
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copying training data
COPY ./rasa-assistant-2 .
COPY entrypoint.sh .
RUN mkdir models && mkdir .rasa && mkdir tests

# Set the permissions for the entrypoint.sh script
RUN chmod +x entrypoint.sh

# Expose ports
EXPOSE 5005 5055

RUN rasa train

# Set the entrypoint script
ENTRYPOINT ["/app/entrypoint.sh"]