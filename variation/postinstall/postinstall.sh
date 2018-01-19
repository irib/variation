#! /bin/sh
##################################
## Scripts de post-installation ##
##################################
VARIATION_PASSWD=$1
ARRANGEMENT=$2

#  banquechamps.php
# Importe une banque de champs
php 005_banquechamps.php $VARIATION_PASSWD $ARRANGEMENT

# thematiques.php 
# Définit les noms et icônes des thématiques
php 010_thematiques.php $VARIATION_PASSWD $ARRANGEMENT

#  init.php :
# - ajoute une catégorie "Catégorie par défaut"
# - ajoute un portail "Portail par défaut"
# - ajoute un établissement "Établissement par défaut"
php 020_etablissement.php $VARIATION_PASSWD $ARRANGEMENT

#  sous_thematiques.php
# Ajoute des publics concernés à toutes les thématiques
php 040_sous_thematiques.php $VARIATION_PASSWD $ARRANGEMENT

#  types_documents.php
# Ajoute une liste de types de documents
php 050_types_documents.php $VARIATION_PASSWD $ARRANGEMENT

#  types_evenements.php
# Ajoute une liste de types d'événements
php 060_types_evenements.php $VARIATION_PASSWD $ARRANGEMENT

#  groupes_thematiques.php
# Ajoute des groupes de thématiques
php 065_groupes_thematiques.php $VARIATION_PASSWD $ARRANGEMENT

#  vues_evenements.php
# Ajoute des vues d'événements
php 070_vues_evenements.php $VARIATION_PASSWD $ARRANGEMENT

#  vues_documents.php
# Ajoute des vues de documents
php 080_vues_documents.php $VARIATION_PASSWD $ARRANGEMENT

#  vues_ressources.php
# Ajoute des vues de ressources
php 090_vues_ressources.php $VARIATION_PASSWD $ARRANGEMENT

#  vues_listes.php
# Ajoute des vues de listes
php 100_vues_listes.php $VARIATION_PASSWD $ARRANGEMENT

#  vues_affectations.php
# Ajoute des vues d'affectations aux groupes
php 105_vues_affectations.php $VARIATION_PASSWD $ARRANGEMENT

#  metiers.php
# Ajoute une liste de métiers
php 110_metiers.php $VARIATION_PASSWD $ARRANGEMENT

#  boites_notes.php
# Ajoute une liste de boîtes de notes et de vues de notes
php 120_boites_notes.php $VARIATION_PASSWD $ARRANGEMENT

#  portail.php
# Importe un portail de démonstration
php 130_portail.php $VARIATION_PASSWD $ARRANGEMENT

# utilisateur.php
# - ajoute un groupe "Prise en charge par défaut" à l'établissement précédent
# - affecte la thématique "Prise en charge" à ce groupe
# - ajoute un groupe d'utilisateurs "Administrateur système" ayant droit 
#   au portail et au groupe créés
# - ajoute un personnel appelé "Administrateur Système"
# - ajoute un utilisateur "admin" rattaché au personnel précédent
# - met le mot de passe de cet utilisateur à "admin"
php 140_utilisateur.php $VARIATION_PASSWD $ARRANGEMENT

# boites_notes_affectations.php
# Affecte les boîtes de notes à chacun des portails
php 150_boites_notes_affectations.php $VARIATION_PASSWD $ARRANGEMENT

# intitules.php
# Importe les intitules
php 160_intitules.php $VARIATION_PASSWD $ARRANGEMENT
