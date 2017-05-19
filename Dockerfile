FROM jenkinsci/slave

COPY jenkins-slave /usr/local/bin/jenkins-slave

RUN apt-get update \
  && apt-get -y install bash git curl zip \
  && curl --sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get -y install yarn \
  && apt-get clean \
  && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
  && chmod 755 $NVM_DIR/nvm.sh \
  && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
  && nvm install v7.9.0 \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["jenkins-slave"]
