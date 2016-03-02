# Galaxy - W4M
#
# VERSION       16.01

FROM quay.io/bgruening/galaxy:16.01

MAINTAINER Gildas Le Corguillé, lecorguille@sb-roscoff.fr

ENV GALAXY_CONFIG_BRAND Workflow4Metabolomics

# Install Tools
ADD tool_list_LCMS.yaml $GALAXY_ROOT/tools.yaml
RUN install-tools $GALAXY_ROOT/tools.yaml