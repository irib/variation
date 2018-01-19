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
-- Module: Persons
-- 
-- Dependences: Fields, Entities, Institutions, Groups
--
SET search_path = public, pg_catalog;
--
-- TABLE personne
--
CREATE TABLE personne (
    per_id serial PRIMARY KEY,
    ent_code character varying REFERENCES meta.entite(ent_code)
);
COMMENT ON TABLE personne IS 'Information de base sur les usagers/personnels/contacts/membres de famille.';
COMMENT ON COLUMN personne.per_id IS 'Identifiant de la personne';
COMMENT ON COLUMN personne.ent_code IS 'Code du type de personne';
CREATE INDEX personne_ent_code_idx ON personne USING btree (ent_code);

--
-- TABLE personne_etablissement
--
CREATE TABLE personne_etablissement (
    per_id integer NOT NULL REFERENCES public.personne,
    eta_id integer NOT NULL REFERENCES public.etablissement
);
COMMENT ON TABLE personne_etablissement IS 'Appartenance d''un usager à un établissement.
Cette table est mise à jour par la fonction personne_etablissement_update()';
COMMENT ON COLUMN personne_etablissement.per_id IS 'Identifiant de l''usager';
COMMENT ON COLUMN personne_etablissement.eta_id IS 'Identifiant de l''établissement';
ALTER TABLE ONLY personne_etablissement
    ADD CONSTRAINT personne_etablissement_pkey PRIMARY KEY (per_id, eta_id);
CREATE INDEX fki_personne_etablissement_eta_id_fkey ON personne_etablissement USING btree (eta_id);
CREATE INDEX fki_personne_etablissement_per_id_fkey ON personne_etablissement USING btree (per_id);

--
-- TABLE personne_groupe
--
CREATE TABLE personne_groupe (
    peg_id serial PRIMARY KEY,
    per_id integer REFERENCES public.personne,
    grp_id integer REFERENCES public.groupe,
    peg_debut date,
    peg_fin date,
    peg_cycle_statut integer,
    peg_cycle_date_demande date,
    peg_cycle_date_demande_renouvellement date,
    peg__hebergement_chambre character varying,
    peg_notes text,
    _inf_id integer REFERENCES meta.info(inf_id), -- TODO supprimer
    peg__decideur_financeur integer
);
COMMENT ON TABLE personne_groupe IS 'Affectation d''un usager à un groupe d''usagers.';
COMMENT ON COLUMN personne_groupe.peg_id IS 'Identifiant de la relation';
COMMENT ON COLUMN personne_groupe.per_id IS 'Identifiant de l''usager';
COMMENT ON COLUMN personne_groupe.grp_id IS 'Identifiant du groupe';
COMMENT ON COLUMN personne_groupe.peg_debut IS 'Date de début d''affectation de l''usager au groupe';
COMMENT ON COLUMN personne_groupe.peg_fin IS 'Date de fin d''affectation';
COMMENT ON COLUMN personne_groupe.peg_cycle_statut IS 'Statut du cyle :
 1: Demandé
 2: Accepté
 3: Terminé
-1: Refusé';
COMMENT ON COLUMN personne_groupe.peg_cycle_date_demande IS 'Date de demande d''affectation';
COMMENT ON COLUMN personne_groupe.peg_cycle_date_demande_renouvellement IS 'Date de demande de renouvellement de l''affectation';
COMMENT ON COLUMN personne_groupe.peg_notes IS 'Notes sur l''affectation';
COMMENT ON COLUMN personne_groupe._inf_id IS '(non utilisé)';
CREATE INDEX fki_personne_groupe_grp_id_fkey ON personne_groupe USING btree (grp_id);
CREATE INDEX fki_personne_groupe_inf_id_fkey ON personne_groupe USING btree (_inf_id);
CREATE INDEX fki_personne_groupe_per_id_fkey ON personne_groupe USING btree (per_id);
