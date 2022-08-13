#FROM python:3.9.7-slim
FROM python:slim

WORKDIR /opt

ENV PORT=9000

ENV UID=1000

ENV GID=1000

RUN groupadd nut -g $GID

RUN useradd -u $UID -g $GID -ms /bin/bash nut

RUN apt update && apt install -y libcurl4-openssl-dev libssl-dev git gcc

RUN git clone --depth 1 https://github.com/blawar/nut.git

RUN chown -R nut:nut nut

WORKDIR /opt/nut

RUN pip install -r requirements.txt

USER nut

RUN mkdir titledb titles scan

VOLUME [ "/opt/nut/titledb" ]

VOLUME [ "/opt/nut/scan" ]

VOLUME [ "/opt/nut/titles" ]

EXPOSE ${PORT}

COPY --chown=nut:nut keys.txt .

RUN cp conf/nut.default.conf conf/nut.conf

COPY --chown=nut:nut *.conf conf/

RUN sed -i 's/\".\"/\"\/opt\/nut\/scan\/\"/' conf/nut.conf

ENTRYPOINT python3 nut.py -s -p ${PORT} -S