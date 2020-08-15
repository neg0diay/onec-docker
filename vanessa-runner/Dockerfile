ARG DOCKER_USERNAME
FROM ${DOCKER_USERNAME}/oscript:1.0.21
#FROM ${DOCKER_USERNAME}/oscript:1.4.0

LABEL maintainer="Anton Kvashenkin <anton.jugatsu@gmail.com> (@jugatsu)"

ARG runner_ver=1.7.0
ARG gitsync_ver=3.0.0

RUN opm install vanessa-runner@$runner_ver \
  # https://github.com/silverbulleters/vanessa-runner/pull/301
  && sed -i 's/#Использовать JSON/#Использовать json/g' \
    /usr/share/oscript/lib/vanessa-runner/src/Модули/ГенерацияОтчетов.os

RUN set -xe \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      git-all

ADD https://github.com/oscript-library/gitsync/releases/download/$gitsync_ver/gitsync.exe /gitsync.exe

#ENTRYPOINT ["bash"]
ENTRYPOINT ["/init"]
#ENTRYPOINT ["runner"]
#CMD ["help"]
