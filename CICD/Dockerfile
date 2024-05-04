FROM ubuntu:22.04

RUN apt update
# Install cron
RUN apt -y install cron docker.io python3 docker-compose git 

# Create the log file to be able to run tail
RUN touch /var/log/cron.log
RUN mkdir /scripts
COPY ci.py /scripts
# Setup cron job
RUN (crontab -l ; echo "* * * * * python3 /scripts/ci.py  >> /var/log/cron.log  2>&1") | crontab
# Run the command on container startup
ENTRYPOINT echo "starting cron" && cron start && tail -f /var/log/cron.log