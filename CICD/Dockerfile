FROM ubuntu:latest

RUN apt update
# Install cron
RUN apt -y install cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log
RUN mkdir /scripts
COPY ci.py /scripts
# Setup cron job
RUN (crontab -l ; echo "* * * * * python3 /scripts/ci.py >> /var/log/cron.log") | crontab
# Run the command on container startup
ENTRYPOINT cron start&& tail -f /var/log/cron.log