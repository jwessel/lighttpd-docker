# Dockerfile for lighttpd

FROM windriver/wrlx-image as build

RUN dnf install -y lighttpd lighttpd-module-auth \
  && sed -i -e 's/.*goal.add_protected.*filterm.*//;s/.*self.conf.protected_packages.*//' /usr/*/python*/site-packages/dnf/base.py \
  && ln -sf /bin/busybox /bin/sh \
  && dnf autoremove -y bash dnf openssh perl rpm \
  && rm -rf /var/lib/rpm /var/lib/opkg /var/lib/dnf /var/cache/* /usr/lib/python*

COPY etc/lighttpd/* /etc/lighttpd/
COPY start.sh /usr/local/bin/

EXPOSE 80

VOLUME /var/www/localhost
VOLUME /etc/lighttpd

CMD ["start.sh"]
