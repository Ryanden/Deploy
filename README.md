Deploy excercise here

# Nginx = uWSGI - Django

**Web Server** <-> **WSGI** <-> **Web Application**

## Requirements

- Python (3.6)
- pipenv

### Secrets


#### ``.secrets/dev.json`
```json
{
  "DATABASES": {
    "default": {
      "ENGINE": "django.db.backends.postgresql",
      "HOST": "test-db.cgrq8bydv59x.ap-northeast-2.rds.amazonaws.com",
      "PORT": "5432",
      "USER": "<user>",
      "PASSWORD": "<password>",
      "NAME": "ec2_deploy_rds"
    }
  }
}

```