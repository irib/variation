-- This file is part of Variation.

-- Variation is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as published
-- by the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- Variation is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.

-- You should have received a copy of the GNU Affero General Public License
-- along with Variation.  If not, see <http://www.gnu.org/licenses/>.
-- --------------------------------------------------------------------------------
-- Ce fichier fait partie de Variation.

-- Variation est un logiciel libre ; vous pouvez le redistribuer ou le modifier 
-- suivant les termes de la GNU Affero General Public License telle que publiée 
-- par la Free Software Foundation ; soit la version 3 de la licence, soit 
-- (à votre gré) toute version ultérieure.

-- Variation est distribué dans l'espoir qu'il sera utile, 
-- mais SANS AUCUNE GARANTIE ; sans même la garantie tacite de 
-- QUALITÉ MARCHANDE ou d'ADÉQUATION à UN BUT PARTICULIER. Consultez la 
-- GNU Affero General Public License pour plus de détails.

-- Vous devez avoir reçu une copie de la GNU Affero General Public License 
-- en même temps que Variation ; si ce n'est pas le cas, 
-- consultez <http://www.gnu.org/licenses>.
-- --------------------------------------------------------------------------------
-- Copyright (c) 2014-2015 Kavarna SARL
--
-- SCHEMA login
--
-- Module: Users
-- 
-- Dependences: Persons
--
CREATE SCHEMA login;
COMMENT ON SCHEMA login
  IS 'Procédures d''authentification de l''utilisateur. Gestion des utilisateurs et groupes d''utilisateurs.
L''utilisateur s''authentifie auprès du webservice avec son login et mot de passe à l''aide de la fonction utilisateur.utilisateur_login2 (prm_login, prm_mdp)
Cette fonction retourne :
 - son identifiant
 - un token d''authentification
 - les droits de l''utilisateur à configurer le réseau et/ou l''établissement
 - la liste des paires (etablissement/portail) auxquels l''utilisateur a droit de se connecter
 - si son mot de passe est provisoire

Le token d''authentification, qui devra être utilisé dans toute fonction à accès restreint, permet d''authentifier de nouveau l''utilisateur sans avoir à envoyer de nouveau le login et mot de passe.
Le token est valable durant un laps de temps configurable, et au plus tard jusqu''à la déconnexion de l''utilisateur.

Les droits de l''utilisateur à configurer le réseau et/ou l''établissement sont donnés pour information. L''interface graphique pourra par exemple, selon ces droits, afficher ou non les menus correspondants. Les fonctions de configuration du réseau et de l''établissement ont un accès restreint (un token devra être donné). Elles retourneront une erreur en cas d''accès illicite, et une alerte de sécurité pourra être levée.

Un certain nombre de fonctions demandent un établissement et/ou portail en paramètre. Ces paramètres devront être renseignés avec des établissement/portail auxquels l''utilisateur a accès. Elles retourneront une erreur en cas d''accès illicite à un établissement/portail. Si ces paramètres ne sont pas renseignés lors de l''appel à la fonction, celle-ci agira sur tous les établissements/portails auxquels à accès l''utilisateur.

Un mot de passe provisoire est stocké en clair dans la base de données. Un utilisateur ayant droit de configuration de l''établissement a accès en lecture à ces mots de passe provisoires, et a le droit d''écraser un mot de passe non provisoire avec un nouveau mot de passe provisoire. Un utilisateur peut à tout moment définir un nouveau mot de passe pour son compte, qui devient alors non provisoire.';

SET search_path = login, pg_catalog;

--
-- utilisateur
--
CREATE TABLE utilisateur (
    uti_id serial PRIMARY KEY,
    uti_login character varying,
    uti_salt character varying,
    uti_root boolean,
    uti_config boolean,
    per_id integer REFERENCES public.personne,
    uti_pwd character varying,
    uti_digest character varying
);
COMMENT ON TABLE utilisateur IS 'Utilisateurs de l''application';
COMMENT ON COLUMN utilisateur.uti_id IS 'Identifiant de l''utilisateur';
COMMENT ON COLUMN utilisateur.uti_login IS 'Login de connexion';
COMMENT ON COLUMN utilisateur.uti_salt IS 'Mot de passe crypté';
COMMENT ON COLUMN utilisateur.uti_root IS 'Droit de configuration "Réseau"';
COMMENT ON COLUMN utilisateur.uti_config IS 'Droit de configuration "Etablissement"';
COMMENT ON COLUMN utilisateur.per_id IS 'Identifiant du personnel associé à l''utilisateur';
COMMENT ON COLUMN utilisateur.uti_pwd IS 'Mot de passe temporaire en clair';
COMMENT ON COLUMN utilisateur.uti_digest IS 'Mot de passe crypté pour connexion par webdav';
CREATE INDEX fki_token_uti_id_fkey ON utilisateur USING btree (uti_id);
CREATE INDEX fki_utilisateur_per_id_fkey ON utilisateur USING btree (per_id);

--
-- token
--
CREATE TABLE token (
    tok_id serial PRIMARY KEY,
    uti_id integer REFERENCES login.utilisateur,
    tok_token integer UNIQUE,
    tok_date_creation timestamp with time zone
);
COMMENT ON TABLE token IS 'Token d''authentification (interne)';
COMMENT ON COLUMN token.tok_id IS 'Identifiant ';
COMMENT ON COLUMN token.uti_id IS 'Utilisateur ayant reçu ce token';
COMMENT ON COLUMN token.tok_token IS 'Valeur du token';
COMMENT ON COLUMN token.tok_date_creation IS 'Date de création (à la connexion de l''utilisateur)';
