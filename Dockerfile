
FROM        ec2-deploy:base
ENV         PROJECT_DIR /srv/project


# nginx, Supervisor install
RUN         apt -y install nginx supervisor


# Copy project files
COPY        .   ${PROJECT_DIR}
WORKDIR     ${PROJECT_DIR}

# Virtualenv path
RUN         export VENV_PATH=$(pipenv --venv); echo $VENV_PATH
#ENV         VENV_PATH $VENV_PATH

# Nginx cinfig
            # avaiable에 있는 파일 복사
RUN         cp -f   ${PROJECT_DIR}/.config/nginx.conf \
                    /etc/nginx/nginx.conf &&\

            # avaiable 에 nginx_app.conf 파일 복사
            cp -f   ${PROJECT_DIR}/.config/nginx_app.conf \
                    /etc/nginx/sites-available/ && \
            # 이미 sites-enabled 에 있던 모든 내용 삭제
            rm -f   /etc/nginx/sites-enabled/* &&\

            # 링크 연결
            ln -sf  /etc/nginx/sites-available/nginx_app.conf \
                    /etc/nginx/sites-enabled

RUN         cp -f   ${PROJECT_DIR}/.config/supervisor_app.conf \
                    /etc/supervisor/conf.d/

# Run supervisord
CMD         supervisord -n

# Run uWSGI
#CMD         pipenv run uwsgi --ini ${PROJECT_DIR}/.config/uwsgi_http.ini

# Run Nginx
#CMD          nginx -g 'daemon off;'