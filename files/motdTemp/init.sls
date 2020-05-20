delete user motd:
  file.absent:
    - name: /etc/legal

{% if grains['os'] == 'Ubuntu' %}
/etc/update-motd.d:
  file.recurse:
    - clean: True
    - source: salt://motdTemp/update-motd.d
{% endif %}

/etc/motd:
  file.managed:
    - source: salt://motdTemp/motd
    - template: jinja
