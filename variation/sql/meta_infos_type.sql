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
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = meta, pg_catalog;

--
-- Data for Name: infos_type; Type: TABLE DATA; Schema: meta; Owner: accueil
--

COPY infos_type (int_id, int_code, int_libelle, int_multiple, int_historique) FROM stdin;
9	etablissement	Affectation à organisme	t	t
11	famille	Famille	t	f
1	texte	Champ texte	t	t
2	date	Champ date	t	t
3	textelong	Texte multi-ligne	f	f
4	coche	Case à cocher	f	t
5	selection	Boîtier de sélection	t	t
7	contact	Lien	t	t
8	metier	Métier	t	t
10	affectation	Affectation de personnel	t	f
12	statut_usager	Statut d'usager	f	f
6	groupe	Affectation d'usager	f	f
\.


--
-- Name: infos_type_int_id_seq; Type: SEQUENCE SET; Schema: meta; Owner: accueil
--

SELECT pg_catalog.setval('infos_type_int_id_seq', 12, true);


--
-- PostgreSQL database dump complete
--

