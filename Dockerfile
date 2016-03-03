# Galaxy - W4M
#
# VERSION       16.01

FROM quay.io/bgruening/galaxy:16.01

MAINTAINER Gildas Le Corguillé, lecorguille@sb-roscoff.fr

ENV GALAXY_CONFIG_BRAND Workflow4Metabolomics


RUN add-tool-shed --url 'http://testtoolshed.g2.bx.psu.edu/' --name 'Test Tool Shed'

# Add the static welcome page
ADD files4galaxy/static/welcome.html /etc/galaxy/web/
ADD files4galaxy/static/W4M/ /etc/galaxy/web/W4M/
ADD files4galaxy/config/tool_conf.xml $GALAXY_ROOT/config/

# Install Tools
ADD tools-playbook-list/tool_list_LCMS.yaml $GALAXY_ROOT/tools.yaml
RUN install-tools $GALAXY_ROOT/tools.yaml