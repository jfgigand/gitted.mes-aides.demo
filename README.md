# Gitted-wrapper around mes-aides.gouv.fr

Ce dépôt contient le profil SYSCONF [](sysconf.mes-aides) qui

[SYSCONF](https://github.com/geonef/sysconf.base) est une méthode (+
helper script) pour centraliser la configuration et autres fichiers
modifiers d'un système pour faciliter le contrôle.

[Gitted](https://github.com/geonef/sysconf.gitted) utilise SYSCONF
pour la création automatique de containers LXC et gère des
import/export de l'état de la VM à travers des git push/pull depuis
l'extérieur.

## Intérêt 

## Installation

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
