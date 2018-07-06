
FROM        ec2-deploy:base
ENV         PROJECT_DIR /srv/project


# nginx
RUN         apt -y install nginx


# Copy project files
COPY        .   ${PROJECT_DIR}
WORKDIR     ${PROJECT_DIR}

# Virtualenv path
RUN         export VENV_PATH=$(pipenv --venv); echo $VENV_PATH
#ENV         VENV_PATH $VENV_PATH

# Run uWSGI
#CMD         pipenv run uwsgi --ini ${PROJECT_DIR}/.config/uwsgi_http.ini

# Run Nginx
#CMD          nginx -g 'daemon off;'