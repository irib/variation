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
-- SCHEMA public
--
-- Module: Fields Values
--
-- Dependences: Persons, Fields, Users, Family Relations
--
SET search_path = public, pg_catalog;

--
-- TABLE personne_info
--
CREATE TABLE personne_info (
    pin_id serial PRIMARY KEY,
    per_id integer REFERENCES public.personne,
    inf_code character varying REFERENCES meta.info(inf_code)
);
COMMENT ON TABLE personne_info IS 'Valeur d''un champ pour une personne.';
COMMENT ON COLUMN personne_info.pin_id IS 'Identifiant de la relation';
COMMENT ON COLUMN personne_info.per_id IS 'Identifiant de la personne';
COMMENT ON COLUMN personne_info.inf_code IS 'Code du champ';
CREATE INDEX fki_personne_info_inf_code_fkey ON personne_info USING btree (inf_code);
CREATE INDEX personne_info_per_id_inf_code_idx ON personne_info USING btree (per_id, inf_code);

--
-- TABLE personne_info_boolean
--
CREATE TABLE personne_info_boolean (
    pib_id serial PRIMARY KEY,
    pin_id integer REFERENCES public.personne_info,
    pib_valeur boolean,
    pib_debut timestamp with time zone,
    pib_fin timestamp with time zone,
    uti_id integer REFERENCES login.utilisateur -- TODO déplacer dans personne_info
);
COMMENT ON TABLE personne_info_boolean IS 'Valeur d''un champ de type "case à cocher" pour une personne.';
COMMENT ON COLUMN personne_info_boolean.pib_id IS 'Identifiant unique';
COMMENT ON COLUMN personne_info_boolean.pin_id IS 'Lien vers personne_info';
COMMENT ON COLUMN personne_info_boolean.pib_valeur IS 'Valeur du champ';
COMMENT ON COLUMN personne_info_boolean.pib_debut IS 'Date de début pour cette valeur (si champ historisé)';
COMMENT ON COLUMN personne_info_boolean.pib_fin IS 'Date de fin pour cette valeur (si champ historisé)';
COMMENT ON COLUMN personne_info_boolean.uti_id IS 'Identifiant de l''utilisateur ayant saisi cette valeur';
CREATE INDEX fki_personne_info_boolean_uti_id_fkey ON personne_info_boolean USING btree (uti_id);
CREATE INDEX personne_info_boolean_pin_id_idx ON personne_info_boolean USING btree (pin_id);

--
-- TABLE personne_info_date
--
CREATE TABLE personne_info_date (
    pid_id serial PRIMARY KEY,
    pin_id integer REFERENCES public.personne_info,
    pid_valeur date,
    pid_debut timestamp with time zone,
    pid_fin timestamp with time zone,
    uti_id integer REFERENCES login.utilisateur
);
COMMENT ON TABLE personne_info_date IS 'Valeur d''un champ de type "Champ date" pour une personne.';
COMMENT ON COLUMN personne_info_date.pid_id IS 'Identifiant unique';
COMMENT ON COLUMN personne_info_date.pin_id IS 'Lien vers personne_info';
COMMENT ON COLUMN personne_info_date.pid_valeur IS 'Valeur du champ';
COMMENT ON COLUMN personne_info_date.pid_debut IS 'Date de début pour cette valeur (si champ historisé)';
COMMENT ON COLUMN personne_info_date.pid_fin IS 'Date de fin pour cette valeur (si champ historisé)';
COMMENT ON COLUMN personne_info_date.uti_id IS 'Identifiant de l''utilisateur ayant saisi cette valeur';
CREATE INDEX fki_personne_info_date_uti_id_fkey ON personne_info_date USING btree (uti_id);
CREATE INDEX personne_info_date_pin_id_idx ON personne_info_date USING btree (pin_id);

--
-- TABLE personne_info_integer
--
CREATE TABLE personne_info_integer (
    pii_id serial PRIMARY KEY,
    pin_id integer REFERENCES public.personne_info,
    pii_valeur integer,
    pii_debut timestamp with time zone,
    pii_fin timestamp with time zone,
    uti_id integer REFERENCES login.utilisateur
);
COMMENT ON TABLE personne_info_integer IS 'Valeur d''un champ de type "Boîtier de sélection", "Lien", "Métier", "Affectation à organisme" ou "Statut usager" pour une personne.';
COMMENT ON COLUMN personne_info_integer.pii_id IS 'Identifiant unique';
COMMENT ON COLUMN personne_info_integer.pin_id IS 'Lien vers personne_info';
COMMENT ON COLUMN personne_info_integer.pii_valeur IS 'Valeur du champ';
COMMENT ON COLUMN personne_info_integer.pii_debut IS 'Date de début pour cette valeur (si champ historisé)';
COMMENT ON COLUMN personne_info_integer.pii_fin IS 'Date de fin pour cette valeur (si champ historisé)';
COMMENT ON COLUMN personne_info_integer.uti_id IS 'Identifiant de l''utilisateur ayant saisi cette valeur';
CREATE INDEX fki_personne_info_integer_pii_valeur_fkey ON personne_info_integer USING btree (pii_valeur);
CREATE INDEX fki_personne_info_integer_uti_id_fkey ON personne_info_integer USING btree (uti_id);
CREATE INDEX personne_info_integer_pin_id_idx ON personne_info_integer USING btree (pin_id);

--
-- TABLE personne_info_integer2
--
CREATE TABLE personne_info_integer2 (
    pij_id serial PRIMARY KEY,
    pin_id integer REFERENCES public.personne_info,
    pij_valeur1 integer,
    pij_valeur2 integer,
    pij_debut timestamp with time zone,
    pij_fin timestamp with time zone,
    uti_id integer REFERENCES login.utilisateur
);
COMMENT ON TABLE personne_info_integer2 IS 'Valeur d''un champ de type "Affectation de personnel" pour une personne.';
COMMENT ON COLUMN personne_info_integer2.pij_id IS 'Identifiant unique';
COMMENT ON COLUMN personne_info_integer2.pin_id IS 'Lien vers personne_info';
COMMENT ON COLUMN personne_info_integer2.pij_valeur1 IS 'Valeur du champ';
COMMENT ON COLUMN personne_info_integer2.pij_valeur2 IS 'Valeur du champ';
COMMENT ON COLUMN personne_info_integer2.pij_debut IS 'Date de début pour cette valeur (si champ historisé)';
COMMENT ON COLUMN personne_info_integer2.pij_fin IS 'Date de fin pour cette valeur (si champ historisé)';
COMMENT ON COLUMN personne_info_integer2.uti_id IS 'Identifiant de l''utilisateur ayant saisi cette valeur';
CREATE INDEX fki_personne_info_integer2_pij_valeur1_fkey ON personne_info_integer2 USING btree (pij_valeur1);
CREATE INDEX fki_personne_info_integer2_pij_valeur2_fkey ON personne_info_integer2 USING btree (pij_valeur2);
CREATE INDEX fki_personne_info_integer2_uti_id_fkey ON personne_info_integer2 USING btree (uti_id);
CREATE INDEX personne_info_integer2_pin_id_idx ON personne_info_integer2 USING btree (pin_id);

--
-- TABLE personne_info_lien_familial
--
CREATE TABLE personne_info_lien_familial (
    pif_id serial PRIMARY KEY,
    pin_id integer REFERENCES public.personne_info,
    per_id_parent integer REFERENCES public.personne(per_id),
    lfa_id integer REFERENCES meta.lien_familial,
    pif_droits character varying,
    pif_periodicite character varying,
    pif_autorite_parentale integer
);
COMMENT ON TABLE personne_info_lien_familial IS 'Valeur d''un champ de type "Lien familial" pour une personne.';
COMMENT ON COLUMN personne_info_lien_familial.pif_id IS 'Identifiant unique';
COMMENT ON COLUMN personne_info_lien_familial.pin_id IS 'Lien vers personne_info';
COMMENT ON COLUMN personne_info_lien_familial.per_id_parent IS 'Identifiant de la personne parente';
COMMENT ON COLUMN personne_info_lien_familial.lfa_id IS 'Type de lien familial';
COMMENT ON COLUMN personne_info_lien_familial.pif_droits IS 'Droits du parent sur l''usager :
rencontre : Rencontre médiatisée
visite : Visite
sortie : Sortie et visite
hebergement : Hébergement';
COMMENT ON COLUMN personne_info_lien_familial.pif_periodicite IS 'Périodicité du droit (texte libre)';
COMMENT ON COLUMN personne_info_lien_familial.pif_autorite_parentale IS 'Autorité du parent sur l''usager :
1 : Autorité parentale
2 : Tutelle
3 : Aucune autorité';
CREATE INDEX fki_personne_info_lien_familial_lfa_id_fkey ON personne_info_lien_familial USING btree (lfa_id);
CREATE INDEX fki_personne_info_lien_familial_per_id_parent_fkey ON personne_info_lien_familial USING btree (per_id_parent);
CREATE INDEX fki_personne_info_lien_familial_pin_id_fkey ON personne_info_lien_familial USING btree (pin_id);

--
-- TABLE personne_info_text
--
CREATE TABLE personne_info_text (
    pit_id serial PRIMARY KEY,
    pin_id integer REFERENCES public.personne_info,
    pit_valeur text,
    pit_debut timestamp with time zone,
    pit_fin timestamp with time zone,
    uti_id integer REFERENCES login.utilisateur
);
COMMENT ON TABLE personne_info_text IS 'Valeur d''un champ de type "Texte multi-ligne" pour une personne.';
COMMENT ON COLUMN personne_info_text.pit_id IS 'Identifiant unique';
COMMENT ON COLUMN personne_info_text.pin_id IS 'Lien vers personne_info';
COMMENT ON COLUMN personne_info_text.pit_valeur IS 'Valeur du champ';
COMMENT ON COLUMN personne_info_text.pit_debut IS 'Date de début pour cette valeur (si champ historisé)';
COMMENT ON COLUMN personne_info_text.pit_fin IS 'Date de fin pour cette valeur (si champ historisé)';
COMMENT ON COLUMN personne_info_text.uti_id IS 'Identifiant de l''utilisateur ayant saisi cette valeur';
CREATE INDEX fki_personne_info_text_uti_id_fkey ON personne_info_text USING btree (uti_id);
CREATE INDEX personne_info_text_pin_id_idx ON personne_info_text USING btree (pin_id);

--
-- TABLE personne_info_varchar
--
CREATE TABLE personne_info_varchar (
    piv_id serial PRIMARY KEY,
    pin_id integer REFERENCES public.personne_info,
    piv_valeur character varying,
    piv_debut timestamp with time zone,
    piv_fin timestamp with time zone,
    uti_id integer REFERENCES login.utilisateur
);
COMMENT ON TABLE personne_info_varchar IS 'Valeur d''un champ de type "Champ Texte" pour une personne.';
COMMENT ON COLUMN personne_info_varchar.piv_id IS 'Identifiant unique';
COMMENT ON COLUMN personne_info_varchar.pin_id IS 'Lien vers personne_info';
COMMENT ON COLUMN personne_info_varchar.piv_valeur IS 'Valeur du champ';
COMMENT ON COLUMN personne_info_varchar.piv_debut IS 'Date de début pour cette valeur (si champ historisé)';
COMMENT ON COLUMN personne_info_varchar.piv_fin IS 'Date de fin pour cette valeur (si champ historisé)';
COMMENT ON COLUMN personne_info_varchar.uti_id IS 'Identifiant de l''utilisateur ayant saisi cette valeur';
CREATE INDEX fki_personne_info_varchar_uti_id_fkey ON personne_info_varchar USING btree (uti_id);
CREATE INDEX personne_info_varchar_pin_id_idx ON personne_info_varchar USING btree (pin_id);


