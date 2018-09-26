# Teiid Docker

Docker with [Teiid Runtime engine on Wildfly](http://teiid.io/).

# Run (recommended for easy-start)
Image is pulling from openkbs/teiid-docker
```
./run.sh
```

# Build
If you want to build older Eclipse like "oxygen", you can following instruction in next section
```
./build.sh
```

## Usage
Once the container is up, shell into the container
```
./shell.sh
```
And, run the setup user command below to enter admin/password setup
```
/opt/jboss/wildfly/bin/add-user.sh
```

To access example Node-info
```
http://0.0.0.0:8080/node-info/
```

## To boot in domain mode:

    docker run -it openkbs/teiid-docker /opt/jboss/wildfly/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0

## Extending the image

    FROM openkbs/teiid-docker
    # Do your stuff here

## Application deployment

With the Teiid server you can deploy your application in multiple ways:

- You can use CLI
- You can use the web console
- You can use the management API directly
- You can use the deployment scanner

## Example
https://developer.jboss.org/wiki/QuickstartExampleWithDockerizedTeiid

# User Add 
## Setup initial Wildfly Admin user
```
./shell.sh  (get into Docker shell)
Then, run
/opt/jboss/wildfly/bin/add-user.sh admin password --silent --enable
```

## Setup Application User for Teiid
* The following example show you how to set up Teiid user
```
[jboss@17bfa830de34 wildfly]$ /opt/jboss/wildfly/bin/add-user.sh

What type of user do you wish to add? 
 a) Management User (mgmt-users.properties) 
 b) Application User (application-users.properties)
(a): b

Enter the details of the new user to add.
Using realm 'ApplicationRealm' as discovered from the existing property files.
Username : application
Password recommendations are listed below. To modify these restrictions edit the add-user.properties configuration file.
 - The password should be different from the username
 - The password should not be one of the following restricted values {root, admin, administrator}
 - The password should contain at least 8 characters, 1 alphabetic character(s), 1 digit(s), 1 non-alphanumeric symbol(s)
Password : 
Re-enter Password : 
What groups do you want this user to belong to? (Please enter a comma separated list, or leave blank for none)[  ]: odata,rest
About to add user 'application' for realm 'ApplicationRealm'
Is this correct yes/no? yes
Added user 'application' to file '/opt/jboss/wildfly/standalone/configuration/application-users.properties'
Added user 'application' to file '/opt/jboss/wildfly/domain/configuration/application-users.properties'
Added user 'application' with groups odata,rest to file '/opt/jboss/wildfly/standalone/configuration/application-roles.properties'
Added user 'application' with groups odata,rest to file '/opt/jboss/wildfly/domain/configuration/application-roles.properties'
Is this new user going to be used for one AS process to connect to another AS process? 
e.g. for a slave host controller connecting to the master or for a Remoting connection for server to server EJB calls.
yes/no? no
```
## Guide for Properties
```
# Properties declaration of users for the realm 'ManagementRealm' which is the default realm
# for new installations. Further authentication mechanism can be configured
# as part of the <management /> in standalone.xml.
#
# Users can be added to this properties file at any time, updates after the server has started
# will be automatically detected.
#
# By default the properties realm expects the entries to be in the format: -
# username=HEX( MD5( username ':' realm ':' password))
#
# A utility script is provided which can be executed from the bin folder to add the users: -
# - Linux
#  bin/add-user.sh
#
# - Windows
#  bin\add-user.bat
#
#$REALM_NAME=ManagementRealm$ This line is used by the add-user utility to identify the realm name already used in this file.
#
# On start-up the server will also automatically add a user $local - this user is specifically
# for local tools running against this AS installation.
#
# The following illustrates how an admin user could be defined, this
# is for illustration only and does not correspond to a usable password.
#admin=2a0923285184943425d1f53ddd58ec7a
```
# See Also - Docker-based IDE
* [openkbs/docker-atom-editor](https://hub.docker.com/r/openkbs/docker-atom-editor/)
* [openkbs/eclipse-photon-docker](https://hub.docker.com/r/openkbs/eclipse-photon-docker/)
* [openkbs/eclipse-oxygen-docker](https://hub.docker.com/r/openkbs/eclipse-oxygen-docker/)
* [openkbs/intellj-docker](https://hub.docker.com/r/openkbs/intellij-docker/)
* [openkbs/netbeans9-docker](https://hub.docker.com/r/openkbs/netbeans9-docker/)
* [openkbs/netbeans](https://hub.docker.com/r/openkbs/netbeans/)
* [openkbs/papyrus-sysml-docker](https://hub.docker.com/r/openkbs/papyrus-sysml-docker/)
* [openkbs/pycharm-docker](https://hub.docker.com/r/openkbs/pycharm-docker/)
* [openkbs/scala-ide-docker](https://hub.docker.com/r/openkbs/scala-ide-docker/)
* [openkbs/sublime-docker](https://hub.docker.com/r/openkbs/sublime-docker/)
* [openkbs/webstorm-docker](https://hub.docker.com/r/openkbs/webstorm-docker/)

# See Also - Docker-based SQL GUI
* [Sqlectron SQL GUI at openkbs/sqlectron-docker](https://hub.docker.com/r/openkbs/sqlectron-docker/)
* [Mysql-Workbench at openkbs/mysql-workbench](https://hub.docker.com/r/openkbs/mysql-workbench/)
* [PgAdmin4 for PostgreSQL at openkbs/pgadmin-docker](https://hub.docker.com/r/openkbs/pgadmin-docker/)

# Resources
- [Containerize Teiid linked with MariaDB](https://developer.jboss.org/wiki/QuickstartExampleWithDockerizedTeiid)
- [Teiid Designer 11.1 with Eclipse Oxygen](http://teiiddesigner.jboss.org/designer_summary/downloads)
- [Teiid Cloud - Data Virtualization Services](http://teiid.io/teiid_cloud/)
- [Deploying Teiid VDB](http://teiid.github.io/teiid-documents/master/content/admin/Deploying_VDBs.html)

