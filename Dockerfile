# Galaxy - W4M
#
# VERSION       2.5.1.0

FROM quay.io/bgruening/galaxy:16.04

MAINTAINER Gildas Le Corguillé, lecorguille@sb-roscoff.fr

RUN apt-get update && \
    apt-get install -y --force-yes nginx-extras=1.4.6-1ubuntu3.4ppa1 nginx-common=1.4.6-1ubuntu3.4ppa1 

#RUN ln -s /export/galaxy-central/tool_deps/ /td

ENV GALAXY_CONFIG_BRAND=Workflow4Metabolomics \
GALAXY_CONFIG_CONDA_AUTO_INIT=True \
GALAXY_CONFIG_CONDA_AUTO_INSTALL=True \
GALAXY_CONFIG_CONDA_PREFIX=/shed_tools/_conda

#RUN add-tool-shed --url 'http://testtoolshed.g2.bx.psu.edu/' --name 'Test Tool Shed'

# Add the static welcome page
ADD files4galaxy/static/welcome.html /etc/galaxy/web/
ADD files4galaxy/static/W4M/ /etc/galaxy/web/W4M/

# Add config files
ADD files4galaxy/config/tool_conf.xml $GALAXY_ROOT/config/
ADD files4galaxy/config/dependency_resolvers_conf.xml $GALAXY_ROOT/config/

# Install Tools
ADD tools-playbook-list/tool_list_LCMS.yaml $GALAXY_ROOT/tools.yaml
RUN install-tools $GALAXY_ROOT/tools.yaml

# Mark folders as imported from the host.
VOLUME ["/export/", "/data/", "/var/lib/docker"]

# Expose port 80 (webserver), 21 (FTP server), 8800 (Proxy)
EXPOSE :80
EXPOSE :21
EXPOSE :8800

# Autostart script that is invoked during container start
CMD ["/usr/bin/startup"]