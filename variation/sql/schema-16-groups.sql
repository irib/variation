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
-- Module: Groups
-- 
-- Dependences: Institutions, Topics, Fields
--
SET search_path = public, pg_catalog;

--
-- TABLE groupe
--
CREATE TABLE groupe (
    grp_id serial PRIMARY KEY,
    grp_nom character varying,
    grp_complet boolean DEFAULT false NOT NULL,
    eta_id integer REFERENCES public.etablissement,
    grp_debut date,
    grp_fin date,
    grp_hebergement_adresse character varying,
    grp_hebergement_cp character varying,
    grp_hebergement_ville character varying,
    grp_pedagogie_type integer,
    grp_pedagogie_niveau integer,
    grp_pedagogie_contact integer,
    grp_notes character varying,
    grp_sante_contact integer,
    grp_emploi_contact integer,
    grp_culture_contact integer,
    grp_education_contact integer,
    grp_hebergement_contact integer,
    grp_justice_contact integer,
    grp_social_contact integer,
    grp_sport_contact integer,
    grp_transport_contact integer,
    grp_decideur_contact integer,
    grp_financeur_contact integer,
    grp_prise_en_charge_contact integer,
    grp_divertissement_contact integer,
    grp_protection_juridique_contact integer,
    grp_restauration_contact integer,
    grp_entretien_contact integer,
    grp_aide_a_la_personne_contact integer,
    grp_social_type integer,
    grp_education_type integer,
    grp_sante_type integer,
    grp_justice_type integer,
    grp_emploi_type integer,
    grp_sport_type integer,
    grp_culture_type integer,
    grp_transport_type integer,
    grp_decideur_type integer,
    grp_hebergement_type integer,
    grp_financeur_type integer,
    grp_prise_en_charge_type integer,
    grp_divertissement_type integer,
    grp_protection_juridique_type integer,
    grp_restauration_type integer,
    grp_entretien_type integer,
    grp_aide_a_la_personne_type integer,
    grp_aide_financiere_directe_contact integer,
    grp_aide_financiere_directe_type integer,
    grp_equipement_personnel_contact integer,
    grp_equipement_personnel_type integer,
    grp_famille_contact integer,
    grp_famille_type integer,
    grp_projet_contact integer,
    grp_projet_type integer,
    grp_sejour_contact integer,
    grp_sejour_type integer,
    grp_soins_infirmiers_contact integer,
    grp_soins_infirmiers_type integer,
    grp_dietetique_contact integer,
    grp_dietetique_type integer,
    grp_ergotherapie_contact integer,
    grp_ergotherapie_type integer,
    grp_physiotherapie_contact integer,
    grp_physiotherapie_type integer,
    grp_kinesitherapie_contact integer,
    grp_kinesitherapie_type integer,
    grp_orthophonie_contact integer,
    grp_orthophonie_type integer,
    grp_psychomotricite_contact integer,
    grp_psychomotricite_type integer,
    grp_psychologie_contact integer,
    grp_psychologie_type integer,
    grp_droits_de_sejour_contact integer,
    grp_droits_de_sejour_type integer,
    grp_aide_formalites_contact integer,
    grp_aide_formalites_type integer
);
COMMENT ON TABLE groupe IS 'Groupe d''usagers';
COMMENT ON COLUMN groupe.grp_id IS 'Identifiant du groupe';
COMMENT ON COLUMN groupe.grp_nom IS 'Nom du groupe';
COMMENT ON COLUMN groupe.grp_complet IS 'Indique s''il est possible d''affecter des usagers à ce groupe (non utilisé)';
COMMENT ON COLUMN groupe.eta_id IS 'Identifiant de l''établissement/partenaire auquel appartient ce groupe';
COMMENT ON COLUMN groupe.grp_debut IS 'Date de début d''activité du groupe';
COMMENT ON COLUMN groupe.grp_fin IS 'Date de fin d''activité du groupe';
COMMENT ON COLUMN groupe.grp_notes IS 'Notes sur le groupe';
CREATE INDEX fki_groupe_eta_id_fkey ON groupe USING btree (eta_id);

--
-- TABLE groupe_info_secteur
--
CREATE TABLE groupe_info_secteur (
    gis_id serial PRIMARY KEY,
    grp_id integer REFERENCES public.groupe,
    sec_id integer REFERENCES meta.secteur,
    inf_id integer REFERENCES meta.info
);
COMMENT ON TABLE groupe_info_secteur IS 'Indique sur quel champ de fiche usager est faite l''affectation de l''usager à un groupe pour un secteur donné.';
COMMENT ON COLUMN groupe_info_secteur.gis_id IS 'Identifiant de la relation';
COMMENT ON COLUMN groupe_info_secteur.grp_id IS 'Identifiant du groupe';
COMMENT ON COLUMN groupe_info_secteur.sec_id IS 'Identifiant du secteur';
COMMENT ON COLUMN groupe_info_secteur.inf_id IS 'Identifiant du champ';
CREATE INDEX fki_groupe_info_secteur_inf_id_fkey ON groupe_info_secteur USING btree (inf_id);
CREATE INDEX fki_groupe_info_secteur_grp_id_fkey ON groupe_info_secteur USING btree (grp_id);
CREATE INDEX fki_groupe_info_secteur_sec_id_fkey ON groupe_info_secteur USING btree (sec_id);

--
-- TABLE groupe_secteur
--
CREATE TABLE groupe_secteur (
    grs_id serial PRIMARY KEY,
    grp_id integer REFERENCES public.groupe,
    sec_id integer REFERENCES meta.secteur
);
COMMENT ON TABLE groupe_secteur IS 'Liste des secteurs couverts par un groupe d''usagers.';
COMMENT ON COLUMN groupe_secteur.grs_id IS 'Identifiant de la relation';
COMMENT ON COLUMN groupe_secteur.grp_id IS 'Identifiant du groupe';
COMMENT ON COLUMN groupe_secteur.sec_id IS 'Identifiant du secteur';
CREATE INDEX fki_groupe_secteur_grp_id_fkey ON groupe_secteur USING btree (grp_id);
CREATE INDEX fki_groupe_secteur_sec_id_fkey ON groupe_secteur USING btree (sec_id);



