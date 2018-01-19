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
-- Copyright (c) 2014 Kavarna SARL
SET search_path = vues, pg_catalog;

CREATE OR REPLACE FUNCTION vues_affectations_liste(prm_token integer) RETURNS SETOF vues.affectations
    LANGUAGE plpgsql
    AS $$
DECLARE
	row vues.affectations;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row IN SELECT * FROM vues.affectations ORDER BY aff_titre LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION vues_affectations_liste(prm_token integer) IS
'Retourne la liste des informations de configuration de pages d''affectation eux groupe, à placer dans le menu principal.
Remarque : 
Nécessite le droit de configuration de l''interface
';

CREATE OR REPLACE FUNCTION vues_affectations_get(prm_token integer, prm_aff_id integer) RETURNS vues.affectations
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret vues.affectations;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM vues.affectations WHERE aff_id = prm_aff_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION vues_affectations_get(prm_token integer, prm_aff_id integer) IS
'Retourne les informations sur la configuration d''une page d''affectations aux groupes.
Entrées :
 - prm_token : Token d''authentification
 - prm_aff_id : Identifiant de la configuration de la page d''affectation.
';

CREATE OR REPLACE FUNCTION vues_affectations_get_par_code(prm_token integer, prm_aff_code varchar) RETURNS vues.affectations
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret vues.affectations;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM vues.affectations WHERE aff_code = prm_aff_code;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION vues_affectations_get_par_code(prm_token integer, prm_aff_code varchar) IS
'Retourne les informations sur la configuration d''une page d''affectations aux groupes.
Entrées :
 - prm_token : Token d''authentification
 - prm_aff_code : Code de la configuration de la page d''affectation.
';

CREATE OR REPLACE FUNCTION vues_affectations_update(prm_token integer, prm_aff_id integer, prm_titre varchar, prm_code varchar, prm_inf_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	IF prm_aff_id NOTNULL THEN
		UPDATE vues.affectations SET 
		  aff_titre = prm_titre,
		  aff_code = prm_code,
		  inf_id = prm_inf_id
                  WHERE aff_id = prm_aff_id;
		RETURN prm_aff_id;
	ELSE
		INSERT INTO vues.affectations (aff_titre, aff_code, inf_id) VALUES (prm_titre, prm_code, prm_inf_id) RETURNING aff_id INTO ret;
		RETURN ret;
	END IF;
END;
$$;
COMMENT ON FUNCTION vues_affectations_update(prm_token integer, prm_aff_id integer, prm_titre varchar, prm_code varchar, prm_inf_id integer) IS
'Modifie les informations de configuration d''une page d''affectation aux groupes ou crée une nouvelle configuration.
Entrées :
 - prm_token : Token d''authentification
 - prm_aff_id : Identifiant de la configuration de page à modifier ou NULL pour créer une nouvelle configuration
 - prm_titre : Nouveau titre de page
 - prm_code : Nouveau code de page
 - prm_inf_id : Nouveau code de champ affectation d''usager
Remarque :
Nécessite le droit de configuration de l''interface';

CREATE OR REPLACE FUNCTION vues_affectation_supprime(prm_token integer, prm_aff_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM vues.affectations WHERE aff_id = prm_aff_id;
END;
$$;
COMMENT ON FUNCTION vues_affectation_supprime(prm_token integer, prm_aff_id integer) IS 
'Supprime une configuration de page d''affectations aux groupes.
Entrées :
 - prm_token : Token d''authentification
 - prm_aff_id : Identifiant de la configuration de page d''affectations aux groupes
Remarque :
Nécessite le droit de configuration de l''interface';

--
CREATE OR REPLACE FUNCTION vues_histoaffectations_liste(prm_token integer) RETURNS SETOF vues.histoaffectations
    LANGUAGE plpgsql
    AS $$
DECLARE
	row vues.histoaffectations;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row IN SELECT * FROM vues.histoaffectations ORDER BY haf_titre LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION vues_histoaffectations_liste(prm_token integer) IS
'Retourne la liste des informations de configuration de pages d''historique d''affectation eux groupe, à placer dans le menu principal.
Remarque : 
Nécessite le droit de configuration de l''interface
';

CREATE OR REPLACE FUNCTION vues_histoaffectations_get(prm_token integer, prm_haf_id integer) RETURNS vues.histoaffectations
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret vues.histoaffectations;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM vues.histoaffectations WHERE haf_id = prm_haf_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION vues_histoaffectations_get(prm_token integer, prm_haf_id integer) IS
'Retourne les informations sur la configuration d''une page d''historique d''affectations aux groupes.
Entrées :
 - prm_token : Token d''authentification
 - prm_haf_id : Identifiant de la configuration de la page d''historique d''affectation.
';

CREATE OR REPLACE FUNCTION vues_histoaffectations_get_par_code(prm_token integer, prm_haf_code varchar) RETURNS vues.histoaffectations
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret vues.histoaffectations;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM vues.histoaffectations WHERE haf_code = prm_haf_code;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION vues_histoaffectations_get_par_code(prm_token integer, prm_haf_code varchar) IS
'Retourne les informations sur la configuration d''une page d''historique d''affectations aux groupes.
Entrées :
 - prm_token : Token d''authentification
 - prm_haf_code : Code de la configuration de la page d''historique d''affectation.
';

CREATE OR REPLACE FUNCTION vues_histoaffectations_update(prm_token integer, prm_haf_id integer, prm_titre varchar, prm_code varchar, prm_inf_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	IF prm_haf_id NOTNULL THEN
		UPDATE vues.histoaffectations SET 
		  haf_titre = prm_titre,
		  haf_code = prm_code,
		  inf_id = prm_inf_id
                  WHERE haf_id = prm_haf_id;
		RETURN prm_haf_id;
	ELSE
		INSERT INTO vues.histoaffectations (haf_titre, haf_code, inf_id) VALUES (prm_titre, prm_code, prm_inf_id) RETURNING haf_id INTO ret;
		RETURN ret;
	END IF;
END;
$$;
COMMENT ON FUNCTION vues_histoaffectations_update(prm_token integer, prm_haf_id integer, prm_titre varchar, prm_code varchar, prm_inf_id integer) IS
'Modifie les informations de configuration d''une page d''historique d''affectation aux groupes ou crée une nouvelle configuration.
Entrées :
 - prm_token : Token d''authentification
 - prm_haf_id : Identifiant de la configuration de page à modifier ou NULL pour créer une nouvelle configuration
 - prm_titre : Nouveau titre de page
 - prm_code : Nouveau code de page
 - prm_inf_id : Nouveau code de champ affectation d''usager
Remarque :
Nécessite le droit de configuration de l''interface';

CREATE OR REPLACE FUNCTION vues_histoaffectation_supprime(prm_token integer, prm_haf_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM vues.histoaffectations WHERE haf_id = prm_haf_id;
END;
$$;
COMMENT ON FUNCTION vues_histoaffectation_supprime(prm_token integer, prm_haf_id integer) IS 
'Supprime une configuration de page d''historique d''affectations aux groupes.
Entrées :
 - prm_token : Token d''authentification
 - prm_haf_id : Identifiant de la configuration de page d''historique d''affectations aux groupes
Remarque :
Nécessite le droit de configuration de l''interface';
