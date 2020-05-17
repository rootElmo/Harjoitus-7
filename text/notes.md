# Notes

Tässä muistiinpanoja.

MUISTA: java komento tarvitsee nykyään -Xmx ja -Xms parametreissä numeron lisäksi KIRJAIMEN (-Xmx1024M = 1Gb muistia)
lähde tälle: https://javarevisited.blogspot.com/2012/12/invalid-initial-and-maximum-heap-size.html

Tämä tapahtui kun asensin käsin minecraft serveriä palvelimelle ja yritin käynnistellä.

## Prosessi

Tarvitaan:

* Kansio ***minecraft*** käyttäjän kotihakemistossa
* openjdk (sudo apt install -y default-jre)
* _server.jar_ ja _eula.txt_ kansiossa ***minecraft***
  * Vie _server.jar_ herralta agenteille
  * _eula.txt:ssä_ luettava _eula=true_
* Scripti kansiossa ***/usr/local/bin***
  * Generoi scriptiin muuttuja 'USERNAME' grainsilla (jinja)
