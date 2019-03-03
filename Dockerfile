# Galaxy - W4M
#
# VERSION       3.2.0-18.05

FROM bgruening/galaxy-stable:19.01

MAINTAINER Gildas Le Corguillé, lecorguille@sb-roscoff.fr

ENV GALAXY_CONFIG_BRAND=Workflow4Metabolomics \
    GALAXY_CONFIG_CONDA_AUTO_INSTALL=True \
    GALAXY_CONFIG_CONDA_AUTO_INIT=True

# Add config files
ADD w4m-config/config/tool_conf.xml $GALAXY_ROOT/config/
ADD w4m-config/config/dependency_resolvers_conf.xml $GALAXY_ROOT/config/

# Install Tools
ADD w4m-config/tool_list.yaml $GALAXY_ROOT/tools.yaml
RUN install-tools $GALAXY_ROOT/tools.yaml

# Duplicate tools in the tools panel
#ADD galaxy_utils/galaxy_duplicate_tools.py $GALAXY_ROOT/galaxy_duplicate_tools.py
#RUN $GALAXY_ROOT/galaxy_duplicate_tools.py $GALAXY_ROOT/tools.yaml $GALAXY_ROOT/config/shed_tool_conf.xml -i

# Add the static welcome page
ADD w4m-config/static/welcome.html /etc/galaxy/web/
ADD w4m-config/static/W4M/ /etc/galaxy/web/W4M/

# Mark folders as imported from the host.
VOLUME ["/export/", "/data/", "/var/lib/docker"]

# Expose port 80 (webserver), 21 (FTP server), 8800 (Proxy)
EXPOSE :80
EXPOSE :21
EXPOSE :22
EXPOSE :8800

# Autostart script that is invoked during container start
CMD ["/usr/bin/startup"]
