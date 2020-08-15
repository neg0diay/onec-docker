ARG DOCKER_USERNAME
FROM ${DOCKER_USERNAME}/oscript:1.0.21
#FROM ${DOCKER_USERNAME}/oscript:1.3.0

LABEL maintainer="Anton Kvashenkin <anton.jugatsu@gmail.com> (@jugatsu)"

ARG gitsync_ver=3.0.0

RUN opm install vanessa-runner \
  && opm install packman \
#  && opm install gitsync \
  && opm install deployka \
  && opm install add \
  && opm install vanessa-automation \
  # https://github.com/silverbulleters/vanessa-runner/pull/301
  && sed -i 's/#Использовать JSON/#Использовать json/g' \
    /usr/share/oscript/lib/vanessa-runner/src/Модули/ГенерацияОтчетов.os

ADD https://github.com/oscript-library/gitsync/releases/download/$gitsync_ver/gitsync.exe /gitsync.exe