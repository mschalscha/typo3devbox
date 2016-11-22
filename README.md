## Kurzanleitung

## Vorbeitung

ACHTUNG damit das im folgenden beschriebene funktioniert, muss docker2boot (docker.io) und nicht die docker App unter OSX verwendet werden!

1. Erstellung einer eigenen Docker-Machine mit der local.typo3.org IP Adresse


docker-machine create -d virtualbox --virtualbox-hostonly-cidr "192.168.144.1/24" typo3dev


# Hier kann der Bezeichner "typo3dev" natürlich nach den eigenen Bedürfnissen angepasst werden.

2. Starten der eigenen Docker-Machine


docker-machine start typo3dev


# Eine Übersicht der im System hinterlegten Docker-Machine bekommt man über "docker-machine ls"

3. Der docker-machine eine feste IP geben und den dhcp deaktivieren indem wir das bootsync.sh der docker-machine anpassen

echo -e $"kill \`more /var/run/udhcpc.eth1.pid\`\nifconfig eth1 192.168.144.120 netmask 255.255.255.0 broadcast 192.168.144.255 up" | docker-machine ssh typo3dev sudo tee /var/lib/boot2docker/bootsync.sh > /dev/null

4. docker-machine durchstarten und Zertifikate erneuern

docker-machine stop typo3dev
docker-machine start typo3dev

# Hier wird es eine Fehlermeldung geben, da die Zertifikate für die docker-machine nun natürlich nicht mehr mit der IP übereinstimmen. Daher erneuern wir diese und starten die docker-machine nochmals durch.

docker-machine regenerate-certs typo3dev
docker-machine stop typo3dev
docker-machine start typo3dev

5. Um nun mit der neuen Docker-machine arbeiten zu können, müssen wir auf diese wechseln.

eval "$(docker-machine env typo3dev)"

# Auf die default docker-machine wechselt man natürlich mit: eval "$(docker-machine env default)".

6. Nun kann der Container gebaut werden:

cd typo3devbox
docker build -t typo3-test .

# Hier ist typo3-test natürlich beliebig gegen einen eigenen Namen austauschbar

7. Erstens starten des Containers

docker run -p 80:80 -p 3306:3306 typo3test

# Hier sollte nun via http://local.typo3.org, http://php71.local.typo3.org sowie http://php70.local.typo3.org jeweils eine phpinfo() ausgegeben werden

8. Einbinden eines lokalen Documentroot

docker run -v ~/mein/lokaler/pfad:/srv/www:rw -p 192.168.144.120:80:80 -p 192.168.144.120:3306:3306 typo3-test

9. Zusammenfassung
Der Container enthält derzeit php7.0, php7.1, nginx, xdebug, composer, nodejs, redis, apc, apcu, memcached

Vom TYPO3 GmbH Base Image kommen:
mariaDB, git

Todo:
-Elasticsearch
-Mail handling
-Mehr php Versionen
-apc, apcu nicht nur für cli
-Bashscript zum Verwalten und Einrichten der Docker-Machine und des Containers
-Das Zusammenstellen der Installation konfigurierbar machen
uvm.

Nützliches:

In den Docker Container connecten:
1. Docker Container ID herausfinden

docker ps

2. In den laufenden Container mit einer bash connecten:

docker exec -it "Container ID" bash

Alle Docker Images entfernen:

docker rmi --force $(docker images -q)

Wirklich alles entfernen (auch Docker Caches etc)

docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v
docker images --no-trunc | grep '<none>' | awk '{ print $3 }'     | xargs docker rmi
docker volume ls -qf dangling=true | xargs docker volume rm



