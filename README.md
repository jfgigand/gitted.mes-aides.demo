# Gitted-wrapper around mes-aides.gouv.fr

Ce dépôt contient le profil SYSCONF [](sysconf.mes-aides) qui

[SYSCONF](https://github.com/geonef/sysconf.base) est une méthode (+
helper script) pour centraliser la configuration et autres fichiers
modifiers d'un système pour faciliter le contrôle.

[Gitted](https://github.com/geonef/sysconf.gitted) utilise SYSCONF
pour la création automatique de containers LXC et gère des
import/export de l'état de la VM à travers des git push/pull depuis
l'extérieur (en l'occurrence : les données MongoDB).


## Intérêt 

* Simplicité d'installation
* Isolation dans le container LXC
* Import/export automatique de la base MongoDB (et suivi par
  l'historique Git)
* Reproductibilité de l'état


## Installation

Ceci fonctionne pour une Ubuntu dernière version (ou pas loin). C'est
compatible avec toute distribution de Linux avec LXC 1.0+ avec le
bridge/DHCP configuré (c'est le cas pour Ubuntu mais pas pour Debian).

Exécuter (pas besoin d'être root) :
```
git clone https://github.com/jfgigand/gitted.mes-aides.demo.git && cd gitted.mes-aides.demo
sysconf/gitted-client register && sysconf/gitted-client add mes-aides
git push mes-aides master
```

C'est pas la dernière commande ```git push``` que se crée le container
LXC (Debian Wheezy) avec tous les paquets nécessaires ainsi qui le
site web _mes-aides_ construit "à la volée".

Quand la commande retour, le site _mes-aides_ doit tourner : ouvrir le
navigateur web sur ```<IP>:9000```, où ```<IP>``` est l'adresse IP du
container (obtenu avec ```lxc-ls -f```).

**Note** : il est possible que la commande ```sysconf/gitted-client```
  indique qu'il manque des fichiers de conf, auquel cas il faut suivre
  les instruction et copier-coller dans le shell les commandes
  suggérées (à faire la première fois qu'on utilise LXC en mode
  non-privilégié).
  

## Reproduire le système

Pour cloner le container ```mes-aides``` créé précédemment en
```mes-aides-bis``` :
```
git pull mes-aides master
sysconf/gitted-client register
sysconf/gitted-client add mes-aides-bis
git push mes-aides-bis
```

Ceci est évidemment possible entre différents utilisateurs, par
l'intermédiaire de GitHub ou autre.

Après quelque utilisation, pour fusionner l'état des 2 machines :
```
git pull mes-aides master
git pull mes-aides-bis master
git push mes-aides master
git push mes-aides-bis master
```

Pour écraser directement l'état de ```mes-aides-bis``` depuis
```mes-aides``` :
```
git fetch mes-aides
git push mes-aides-bis +mes-aides/master:master
```
