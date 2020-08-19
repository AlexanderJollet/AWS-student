# TP3 : modifier le plan pour créer deux instances et installer Wordpress

## Partir de TFex

L'objectif est de déployer deux instances, l'une installant et
configurant Apache2/PHP/Wordpress, l'autre MariaDB de façon
à ce que Wordpress soit fonctionnel 100% automatiquement.

Copier ici les répertoire ssh-keys, Scripts et Tf (et ajouter au git)
Supprimer les clefs `id_rsa*` du répertoire ssh-key si besoin.

Générer les clefs à nouveau.

Modifier le plan terraform (instances.tf) pour créer deux instances
avec deux IP privées différentes.

Modifier le plan pour exécuter des scripts distincts.
