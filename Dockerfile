FROM python:3.7-alpine

LABEL description="Damn Vulnerable GraphQL Application"
LABEL github="https://github.com/dolevf/Damn-Vulnerable-GraphQL-Application"
LABEL maintainers="Dolev Farhi & Connor McKinnon"


ARG TARGET_FOLDER=/opt/dvga
WORKDIR $TARGET_FOLDER/



RUN apk add --update curl gcc g++ git

COPY requirements.txt /opt/dvga/
RUN pip install -r requirements.txt

ADD core /opt/dvga/core
ADD db /opt/dvga/db
ADD static /opt/dvga/static
ADD templates /opt/dvga/templates
ADD fileless /opt/dvga/fileless
RUN chmod +x /opt/dvga/fileless/*

COPY app.py /opt/dvga
COPY config.py /opt/dvga
COPY setup.py /opt/dvga/
COPY version.py /opt/dvga/
COPY entrypoint.sh /opt/dvga

#RUN python setup.py

EXPOSE 5013/tcp
CMD ["sh", "entrypoint.sh"]
