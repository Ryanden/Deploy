# settings.base
#

# settings.local
#   runserver

# settings.dev
#   RDS, S3, Debug 메시지 출력

# settings.production
#   배포용 설정. Debug 메시지 출력 안함

from .local import *
