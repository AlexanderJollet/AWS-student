# Installer un serveur Web public sur l'instance

## Se connecter sur l'instance en SSH
~~~~
$ ssh -i chemin/vers/firstkeypair.pem ubuntu@ip_publique_de_l'instance
~~~~

## Mettre à jour la base des paquets disponible, mettre à jour la distribution et installer Apache2 (par exemple)
~~~~
ubuntu@ip-...$ sudo apt -y update && sudo -y apt upgrade
ubuntu@ip-...$ sudo apt -y install apache2
~~~~

## Vérifier le fonctionnement du site Web
~~~~
ubuntu@ip-...$ sudo wget -O - http://localhost/
ubuntu@ip-...$ sudo apt -y install w3m
ubuntu@ip-...$ sudo w3m http://localhost/
~~~~

## Ajouter une règle entrante dans le groupe de sécurité

Ajouter une règle entrante autorisant HTTP (80/TCP) de n'importe où au groupe
de sécurité créé automatiquement lors du lancement de l'instance (sg...-launch-wizard)

Si le nom est dans le dns dynamique (my.noip.com par example) une page Web
est visible sur (par exemple) : http://gudule.zapto.org/


