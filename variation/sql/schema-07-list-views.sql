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
-- SCHEMA liste
--
-- Module: List Views
--
-- Dependences: Entities, Fields
--
CREATE SCHEMA liste;
COMMENT ON SCHEMA liste IS 
'Configuration des pages liste.
Une page liste est définie par une liste de champs usager, personnel, contact ou famille.';

SET search_path = liste, pg_catalog;

--
-- liste
--
CREATE TABLE liste (
    lis_id serial PRIMARY KEY,
    lis_nom character varying,
    ent_id integer REFERENCES meta.entite,
    lis_inverse boolean,
    lis_pagination_tout boolean DEFAULT false NOT NULL,
    lis_code varchar UNIQUE
);
COMMENT ON TABLE liste IS 'Les configurations de page liste.';
COMMENT ON COLUMN liste.lis_id IS 'Identifiant';
COMMENT ON COLUMN liste.lis_nom IS 'Nom de la page';
COMMENT ON COLUMN liste.ent_id IS 'Identifiant du type d''entité décrit par la liste (usager, personnel, etc)';
COMMENT ON COLUMN liste.lis_inverse IS 'TRUE pour placer les libellés des champs à gauche plutôt qu''en haut du tableau.';
COMMENT ON COLUMN liste.lis_pagination_tout IS 'TRUE pour tout afficher par défaut';
CREATE INDEX fki_liste_ent_id_fkey ON liste USING btree (ent_id);

--
-- champ
--
CREATE TABLE champ (
    cha_id serial PRIMARY KEY,
    lis_id integer REFERENCES liste.liste,
    inf_id integer REFERENCES meta.info,
    cha__groupe_cycle boolean,
    cha__groupe_dernier boolean,
    cha_libelle character varying,
    cha_ordre integer,
    cha_filtrer boolean DEFAULT false NOT NULL,
    cha__groupe_contact boolean,
    cha_verrouiller boolean DEFAULT false,
    cha__famille_details boolean DEFAULT false NOT NULL,
    cha_champs_supp boolean DEFAULT false,
    cha__contact_filtre_utilisateur boolean
);
COMMENT ON TABLE champ IS 'Les champs constituant une page liste';
COMMENT ON COLUMN champ.cha_id IS 'Identifiant';
COMMENT ON COLUMN champ.lis_id IS 'Configuration de liste';
COMMENT ON COLUMN champ.inf_id IS 'Champ personne';
COMMENT ON COLUMN champ.cha__groupe_cycle IS 'Pour un champ groupe, afficher infos de cycle';
COMMENT ON COLUMN champ.cha__groupe_dernier IS 'Pour un champ groupe, afficher uniquement dernière appartenance';
COMMENT ON COLUMN champ.cha_libelle IS 'Libellé dans la liste';
COMMENT ON COLUMN champ.cha_ordre IS 'Ordre dans la liste';
COMMENT ON COLUMN champ.cha_filtrer IS 'Proposer de filtrer sur ce champ';
COMMENT ON COLUMN champ.cha__groupe_contact IS 'Pour un champ groupe, afficher le contact';
COMMENT ON COLUMN champ.cha_verrouiller IS 'Si valeurs par défaut, verrouiller ces valeurs';
COMMENT ON COLUMN champ.cha__famille_details IS 'Pour champ famille, afficher les détails';
COMMENT ON COLUMN champ.cha_champs_supp IS 'Pour champ Lien ou Famille, indique si on veut afficher des champs supplémentaires';
COMMENT ON COLUMN champ.cha__contact_filtre_utilisateur IS 'Pour un champ Contact, filtre par défaut sur l''utilisateur connecté';
CREATE INDEX fki_champ_inf_id_fkey ON champ USING btree (inf_id);
CREATE INDEX fki_champ_lis_id_fkey ON champ USING btree (lis_id);

--
-- defaut
--
CREATE TABLE defaut (
    def_id serial PRIMARY KEY,
    cha_id integer REFERENCES liste.champ,
    def_valeur_texte character varying,
    def_valeur_int integer,
    def_valeur_int2 integer,
    def_ordre integer
);
COMMENT ON TABLE defaut IS 'Valeurs de filtre d''un champ par défaut';
COMMENT ON COLUMN defaut.def_id IS 'Identifiant';
COMMENT ON COLUMN defaut.cha_id IS 'Champ dans liste auquel est rattachée cette valeur par défaut';
COMMENT ON COLUMN defaut.def_valeur_texte IS 'Valeur par défaut pour champ de type texte, etc';
COMMENT ON COLUMN defaut.def_valeur_int IS 'Valeur par défaut pour champ de type liste de sélection, etc';
COMMENT ON COLUMN defaut.def_valeur_int2 IS 'Valeur par défaut pour champ de type affectation, etc';
COMMENT ON COLUMN defaut.def_ordre IS 'Ordre de la valeur par défaut';
CREATE INDEX fki_defaut_cha_id_fkey ON defaut USING btree (cha_id);

--
-- supp
--
CREATE TABLE supp (
    sup_id serial PRIMARY KEY,
    cha_id integer REFERENCES liste.champ,
    inf_id integer REFERENCES meta.info,
    sup_ordre integer
);
COMMENT ON TABLE supp IS 'Champs supplémentaires à afficher pour un champ lien ou famille';
COMMENT ON COLUMN supp.sup_id IS 'Identifiant';
COMMENT ON COLUMN supp.cha_id IS 'Champ dans une liste pour lequel afficher le détail';
COMMENT ON COLUMN supp.inf_id IS 'Champ à afficher en détail';
COMMENT ON COLUMN supp.sup_ordre IS 'Ordre d''affichage';
-- TODO index cha_id, inf_id


