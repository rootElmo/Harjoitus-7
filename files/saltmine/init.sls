minecontrol script:
  file.managed:
    - name: /usr/local/bin/minecontrol
    - source: salt://saltmine/2ndscript.sh
    - user: minecraft
    - mode: 774

minecraft directory:
  file.directory:
    - name: /home/minecraft/minecraft
    - user: minecraft
    - mode: 775

minecraft server.jar:
  file.managed:
    - name: /home/minecraft/minecraft/server.jar
    - source: salt://saltmine/minecraft/server.jar
    - user: minecraft
    - mode: 774
    - require: 
      - file: minecraft directory

minecraft eula.txt:
  file.managed:
    - name: /home/minecraft/minecraft/eula.txt
    - source: salt://saltmine/minecraft/eula.txt
    - user: minecraft
    - mode: 444
    - require: 
      - file: minecraft directory

install openjdk:
  pkg.installed:
    - name: openjdk-11-jre-headless
