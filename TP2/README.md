# TP2: monter une infra pour Wordpress (ou autre CMS au choix)

Monter dans le cloud AWS un Wordpress (ou un autre CMS au choix)
avec l'archi suivante :

- Une instance fait tourner Apache2, PHP et Wordpress
- Une instance fait tourner un serveur MariaDB (ou PostgreSQL)

Testez avec un tunnel SSH que vous pouvez accéder au Wordpress à partir
de votre poste sans ouvrir l'accès HTTP/HTTPS dans le groupe de sécurité.
Ensuite ouvrez le port sur le groupe de sécurité et accédez y sur l'IP
publique directement.

Le site est accessible pour tous sur l'IP de l'instance Apache2/PHP (ouvrir
le groupe de sécurité correspondant)

N.B. Pour que les deux instance puissent communiquer il faut que
le port de la base de données soit ouvert sur toutes les adresses
de l'instance (pas seulement localhost) et que le groupe de sécurité
permette l'accès à ce port à partir de l'instance Apache2.

Bonus (si vous avez le temps et l'envie) :
- Créer une instance supplémentaire faisant tourner un NGINX configurer
en proxy entrant relayant les requètes sur l'instance Apache 2 
