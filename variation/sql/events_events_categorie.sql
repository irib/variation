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

SET search_path = events, pg_catalog;

--
-- Data for Name: events_categorie; Type: TABLE DATA; Schema: events; Owner: accueil
--

COPY events_categorie (eca_id, eca_nom, eca_code, eca_icone) FROM stdin;
1	Incidents	incidents	/Images/IS_Real_vista_Communications/originals/png/NORMAL/%d/warnings_%d.png
2	Dépenses	depenses	/Images/IS_Real_vista_Accounting/originals/png/NORMAL/%d/coins_%d.png
3	Tâches et Rendez-vous	rendezvous	\N
4	Absences / Présences	absences	/Images/IS_real_vista_transportation/png/NORMAL/%d/baggage_%d.png
\.


--
-- Name: events_categorie_eca_id_seq; Type: SEQUENCE SET; Schema: events; Owner: accueil
--

SELECT pg_catalog.setval('events_categorie_eca_id_seq', 5, true);


--
-- PostgreSQL database dump complete
--

