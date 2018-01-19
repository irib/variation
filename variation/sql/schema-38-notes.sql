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
-- SCHEMA notes
--
-- Module: Notes
--
-- Dependences: Notes Topics, Users, Institutions, Groups, Persons
--
SET search_path = notes, pg_catalog;

--
-- note
--
CREATE TABLE note (
    not_id serial PRIMARY KEY,
    not_date_saisie timestamp with time zone,
    not_date_evenement timestamp with time zone,
    not_objet character varying,
    not_texte text,
    uti_id_auteur integer REFERENCES login.utilisateur(uti_id),
    eta_id_auteur integer REFERENCES public.etablissement(eta_id)
);
COMMENT ON TABLE note IS 'Notes envoyées entre utilisateurs';
CREATE INDEX fki_note_eta_id_auteur_fkey ON note USING btree (eta_id_auteur);
CREATE INDEX fki_note_uti_id_auteur_fkey ON note USING btree (uti_id_auteur);

--
-- note_destinataire
--
CREATE TABLE note_destinataire (
    nde_id serial PRIMARY KEY,
    not_id integer REFERENCES notes.note,
    uti_id integer REFERENCES login.utilisateur,
    nde_pour_action boolean DEFAULT false NOT NULL,
    nde_pour_information boolean DEFAULT false NOT NULL,
    nde_action_faite boolean DEFAULT false NOT NULL,
    nde_information_lue boolean DEFAULT false NOT NULL,
    nde_supprime boolean DEFAULT false
);
COMMENT ON TABLE note_destinataire IS 'Destinataires d''une note';
CREATE INDEX fki_note_destinataire_not_id_fkey ON note_destinataire USING btree (not_id);
CREATE INDEX fki_note_destinataire_uti_id_fkey ON note_destinataire USING btree (uti_id);

--
-- note_groupe
--
CREATE TABLE note_groupe (
    ngr_id serial PRIMARY KEY,
    not_id integer REFERENCES notes.note,
    grp_id integer REFERENCES public.groupe
);
COMMENT ON TABLE note_groupe IS 'Rattachement d''une note à un groupe d''usagers';
CREATE INDEX fki_note_groupe_grp_id_fkey ON note_groupe USING btree (grp_id);
CREATE INDEX fki_note_groupe_not_id_fkey ON note_groupe USING btree (not_id);

--
-- note_theme
--
CREATE TABLE note_theme (
    nth_id serial PRIMARY KEY,
    not_id integer REFERENCES notes.note,
    the_id integer REFERENCES notes.theme
);
COMMENT ON TABLE note_theme IS 'Classification des notes dans des boîtes thématiques';
CREATE INDEX fki_note_theme_not_id_fkey ON note_theme USING btree (not_id);
CREATE INDEX fki_note_theme_the_id_fkey ON note_theme USING btree (the_id);

--
-- note_usager
--
CREATE TABLE note_usager (
    nus_id serial PRIMARY KEY,
    not_id integer REFERENCES notes.note,
    per_id integer REFERENCES public.personne
);
COMMENT ON TABLE note_usager IS 'Rattachement d''une note à un usager';
CREATE INDEX fki_note_usager_not_id_fkey ON note_usager USING btree (not_id);
CREATE INDEX fki_note_usager_per_id_fkey ON note_usager USING btree (per_id);
