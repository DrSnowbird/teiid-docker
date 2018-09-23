#FROM jboss/wildfly:14.0.1.Final
FROM jboss/wildfly

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

###########################
#### ---- Wildfly ---- ####
###########################
ENV JBOSS_HOME=${JBOSS_HOME:-/opt/jboss/wildfly}

###########################
#### ----  Teiid  ---- ####
###########################
# Set the TEIID_VERSION env variable
ENV TEIID_VERSION=${TEIID_VERSION:-11.1.1}

# Download and unzip Teiid server
# https://oss.sonatype.org/service/local/repositories/releases/content/org/teiid/teiid/11.1.1/teiid-11.1.1-wildfly-dist.zip
RUN cd ${JBOSS_HOME} \
    && curl -O https://oss.sonatype.org/service/local/repositories/releases/content/org/teiid/teiid/${TEIID_VERSION}/teiid-$TEIID_VERSION-wildfly-dist.zip \
    && bsdtar -xf teiid-${TEIID_VERSION}-wildfly-dist.zip \
    && chmod +x ${JBOSS_HOME}/bin/*.sh \
    && rm teiid-${TEIID_VERSION}-wildfly-dist.zip
    
USER jboss

ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Expose Teiid server ports 
EXPOSE 8080 9990 31000 35432 

# Run Teiid server and bind to all interface
# CMD ["/bin/sh", "-c", "${JBOSS_HOME}/bin/standalone.sh -c standalone-teiid.xml -b 0.0.0.0 -bmanagement 0.0.0.0"]

###################################
#### ----  Users: setup   ---- ####
###################################

## -- setup ManagementRealm password
ARG ADMIN_USER=${ADMIN_USER:-admin}
ENV ADMIN_USER=${ADMIN_USER}
ARG ADMIN_PASSWORD=${ADMIN_PASSWORD:-Password12345_}
ENV ADMIN_PASSWORD=${ADMIN_PASSWORD}

## -- org.jboss.as.domain-add-user: assume 
##       1st arg=$admin_user, 2nd_arg=$admin_password, 3rd_arg (default)="ManagementRealm"
## RUN add-user.sh -u user1 -p Password12345_ -r ManagementRealm --silient --enable
RUN /opt/jboss/wildfly/bin/add-user.sh ${ADMIN_USER} ${ADMIN_PASSWORD} --silent --enable

## -- setup ApplicationRealm password
ARG APP_USER=${APP_USER:-user1}
ARG APP_PASSWORD=${APP_PASSWORD:-Password12345_}
ARG APP_GROUP=${APP_GROUP:-"odata,rest"}
ARG APP_REALM=${APP_REALM:-ApplicationRealm}

## RUN add-user.sh -a user1 -p Password12345_ -r ApplicationRealm -g "odata,rest" --silient --enable
RUN /opt/jboss/wildfly/bin/add-user.sh -a ${APP_USER} -p ${APP_PASSWORD} -r ${APP_REALM} -g ${APP_GROUP} --silent --enable

###################################
#### -- Volume: Declaration -- ####
###################################
#VOLUME ["$JBOSS_HOME/standalone", "$JBOSS_HOME/domain"]
VOLUME ["$JBOSS_HOME/standalone/configuration", "$JBOSS_HOME/domain/configuration"]

###################################
#### ---- ENV: Setup ---- ####
###################################
ENV PATH=$PATH:${JBOSS_HOME}/bin

###################################
#### -_- Deploy: node-info --- ####
###################################
#### ref: https://github.com/goldmann/wildfly-docker-deployment-example
ADD node-info.war /opt/jboss/wildfly/standalone/deployments/

###################################
#### ---- Deploy: Teiid  ---- ####
###################################
WORKDIR ${JBOSS_HOME}
#### CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
CMD ["/bin/sh", "-c", "${JBOSS_HOME}/bin/standalone.sh -c standalone-teiid.xml -b 0.0.0.0 -bmanagement 0.0.0.0"]
