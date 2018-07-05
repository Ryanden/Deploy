#!/usr/bin/env bash

IDENTITY_FILE="$HOME/.ssh/fc-8th.pem"
USER="ubuntu"
HOST="ec2-13-209-89-37.ap-northeast-2.compute.amazonaws.com"
PROJECT_DIR="$HOME/projects/deploy/ec2-deploy"
SERVER_DIR="/home/ubuntu/project"

# 서버로 접속하는 명령어
CMD_CONNECT="ssh -i ${IDENTITY_FILE} ${USER}@${HOST}"

echo "Start deploy"

# 서버에서 실행중이던 runserver 프로세스들을 모두 종료
${CMD_CONNECT} "pkill -9 -ef runserver"
echo "kill sever"

# 서버의 파일을 지움
${CMD_CONNECT} rm -rf ${SERVER_DIR}
echo "- Delete server files"

# 로컬 자료를 서버에 업로드
scp -q -i ${IDENTITY_FILE} -r ${PROJECT_DIR} ${USER}@${HOST}:${SERVER_DIR}
echo "- Upload files"

# 서버의 경로에 있는 pipenv 정보를 받아옴
VENV_PATH=$(${CMD_CONNECT} "cd ${SERVER_DIR} && pipenv --venv")

# 가상경로의 bin/python 을 붙여 서버에서 사용하는 Python 경로 만들기
PYTHON_PATH="${VENV_PATH}/bin/python"
echo $PYTHON_PATH

# runserver 를 background 에서 실행 해주는 커멘드 (nohup)
# &>/dev/null & 가 없을경우 세션의 자동 종료가 되지 않음.
RUNSERVER_CMD="nohup ${PYTHON_PATH} manage.py runserver 0:8000 &>/dev/null &"
echo $RUNSERVER_CMD

#서버 접속후, 프로젝트 'app 폴더까지 이동후 runserver 명령어를 실행
${CMD_CONNECT} "cd ${SERVER_DIR}/app && ${RUNSERVER_CMD}"


echo "Deploy complete"