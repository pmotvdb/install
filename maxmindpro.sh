#!/usr/bin/env bash
#
# Description: Maxmind GeoLite2 Datbase Fetcher
#
# Copyright (C) 2018 - JUICYCODES.COM <hello@juicycodes.com>
#
# https://juicycodes.com/products/system-administration-service/
#

mmdblookup() {
	cd /etc/nginx/geo.d/; wget -q https://github.com/maxmind/libmaxminddb/releases/download/1.4.3/libmaxminddb-1.4.3.tar.gz; tar -zxvf libmaxminddb-1.4.3.tar.gz; cd libmaxminddb-1.4.3; ./configure; make && make install; ldconfig; sh -c "echo /usr/local/lib  >> /etc/ld.so.conf.d/local.conf"; ldconfig; cd ../; rm -rf libmaxminddb*
}

mmdblookup

countrydb() {
	cd /etc/nginx/geo.d/; wget -q "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country&license_key=8VDOTsTMqioe&suffix=tar.gz" -O GeoLite2-Country_wget.tar.gz; tar -zxf GeoLite2-Country_wget.tar.gz; cd GeoLite2-Country_*; mv GeoLite2-Country.mmdb /etc/nginx/geo.d/maxmind-country.mmdb; cd /etc/nginx/geo.d/; rm -rf GeoLite2-Country_*
}

countrydb

citydb() {
	cd /etc/nginx/geo.d/; wget -q "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=8VDOTsTMqioe&suffix=tar.gz" -O GeoLite2-City_wget.tar.gz; tar -zxf GeoLite2-City_wget.tar.gz; cd GeoLite2-City_*; mv GeoLite2-City.mmdb /etc/nginx/geo.d/maxmind-city.mmdb; cd /etc/nginx/geo.d/; rm -rf GeoLite2-City_*
}

citydb
