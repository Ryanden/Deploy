#!/usr/bin/env bash

IDENTITY_FILE="$HOME/.ssh/fc-8th.pem"
USER="ubuntu"
HOST="ec2-13-209-89-37.ap-northeast-2.compute.amazonaws.com"
PROJECT_DIR="$HOME/projects/deploy/ec2-deploy"
SERVER_DIR="/home/ubuntu/project"

# 서버로 접속하는 명령어
CMD_CONNECT="ssh -i ${IDENTITY_FILE} ${USER}@${HOST}"

# 서버의 경로에 있는 pipenv 정보를 받아옴
VENV_PATH=$(${CMD_CONNECT} "cd ${SERVER_DIR} && pipenv --venv")

# 가상경로의 bin/python 을 붙여 서버에서 사용하는 Python 경로 만들기

PYTHON_PATH="${VENV_PATH}/bin/python"
echo $PYTHON_PATH

# runserver 를 background 에서 실행 해주는 커멘드 (nohup)
RUNSERVER_CMD="nohup ${PYTHON_PATH} manage.py runserver 0:8000"
echo $RUNSERVER_CMD

#서버 접속후, 프로젝트 'app 폴더까지 이동후 runserver 명령어를 실행
${CMD_CONNECT} "cd ${SERVER_DIR}/app && ${RUNSERVER_CMD}"

echo "종료"
