# Gitted-wrapper around mes-aides.gouv.fr -- GIT information

Ceci est le dépôt _gitted_, c'est-à-dire la fusion du SYSCONF
(configuration du système) et de l'état de la VM (données MongoDB).

Le système est constitué de [sysconf/](sysconf/) lui-même réparti en
plusieurs profils.

Ces profils sont partagés avec d'autres dépôts _gitted_ et sont inclus
ici avec la méthode
[https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt](git-subtree)
(qui est une variante des
[http://git-scm.com/docs/git-submodule](git-submodule)).

Les commandes ci-dessous indiquent comment mettre à jour ces profils
depuis leur dépôt officiel respectif (pull) ou bien extraire les
nouveaux commits pour ces sous-répertoires afin de pousser sur le
dépôt spécifique.


## Git sub-trees

### PULL

```
git subtree pull -P sysconf/sysconf.base git@github.com:geonef/sysconf.base.git master
git subtree pull -P sysconf/sysconf.gitted git@github.com:geonef/sysconf.gitted.git master
git subtree pull -P sysconf/sysconf.nodejs git@github.com:geonef/sysconf.nodejs.git master
git subtree pull -P sysconf/sysconf.mes-aides git@github.com:geonef/sysconf.mes-aides.git master
```

### PUSH

```
git subtree push -P sysconf/sysconf.base git@github.com:geonef/sysconf.base.git master
git subtree push -P sysconf/sysconf.gitted git@github.com:geonef/sysconf.gitted.git master
git subtree push -P sysconf/sysconf.nodejs git@github.com:geonef/sysconf.nodejs.git master
git subtree push -P sysconf/sysconf.mes-aides git@github.com:geonef/sysconf.mes-aides.git master
```
