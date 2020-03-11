FROM bitnami/postgresql:10.8.0
LABEL maintainer "Alexander Awitin Jr <me@alexanderawitin.com>"

USER 0

# Install postgis postgresql extension
RUN install_packages wget build-essential libxml2-dev libgeos-dev libproj-dev libgdal-dev \
	&& cd /tmp \
    && wget "https://download.osgeo.org/postgis/source/postgis-2.5.1.tar.gz" \
    && export C_INCLUDE_PATH=/opt/bitnami/postgresql/include/:/opt/bitnami/common/include/ \
    && export LIBRARY_PATH=/opt/bitnami/postgresql/lib/:/opt/bitnami/common/lib/ \
    && export LD_LIBRARY_PATH=/opt/bitnami/postgresql/lib/:/opt/bitnami/common/lib/ \
    && tar zxf postgis-2.5.1.tar.gz && rm -f postgis-${POSTGIS_VERSION}.tar.gz \
    && cd postgis-2.5.1 \
    && ./configure --with-pgconfig=/opt/bitnami/postgresql/bin/pg_config \
    && make \
    && make install \
	&& apt-get remove --purge --auto-remove -y wget build-essential

USER 1001
