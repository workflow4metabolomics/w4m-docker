# Galaxy - W4M
#
# VERSION       0.0.2

FROM quay.io/bgruening/galaxy:16.04

MAINTAINER Gildas Le Corguillé, lecorguille@sb-roscoff.fr

ENV GALAXY_CONFIG_BRAND=Workflow4Metabolomics \
GALAXY_CONFIG_CONDA_AUTO_INIT=True \
GALAXY_CONFIG_CONDA_AUTO_INSTALL=True

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
