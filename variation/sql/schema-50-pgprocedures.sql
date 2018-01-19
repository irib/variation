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

-- SET statement_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- SET check_function_bodies = false;
-- SET client_min_messages = warning;
-- SET default_tablespace = '';
-- SET default_with_oids = false;

SET search_path = public, pg_catalog;
CREATE TYPE pgprocedures_search_arguments AS (
	argnames character varying[],
	argtypes oidvector
);
CREATE TYPE pgprocedures_search_function AS (
	proc_nspname name,
	proargtypes oidvector,
	prorettype oid,
	ret_typtype character(1),
	ret_typname name,
	ret_nspname name,
	proretset boolean
);
CREATE FUNCTION pgprocedures_search_arguments(prm_function character varying) RETURNS SETOF pgprocedures_search_arguments
    LANGUAGE plpgsql
    AS $$                                                                                                                                
DECLARE                                                                                                                           
 row pgprocedures_search_arguments%ROWTYPE;                                                                                       
BEGIN                                                                                                                             
 FOR row IN                                                                                                                       
   SELECT proargnames, proargtypes                                                                                                
    FROM pg_proc                                                                                                                  
     WHERE proname = prm_function                                                                                                 
     ORDER BY pronargs DESC                                                                                                       
 LOOP                                                                                                                             
   RETURN NEXT row;                                                                                                               
 END LOOP;                                                                                                                        
END;                                                                                                                              
$$;
CREATE FUNCTION pgprocedures_search_function(prm_method character varying, prm_nargs integer) RETURNS pgprocedures_search_function
    LANGUAGE plpgsql
    AS $$                                                                                                                            
DECLARE                                                                                                                           
      ret pgprocedures_search_function%ROWTYPE;                                                                                   
BEGIN            
	--PERFORM pgprocedures_add_call (prm_method, prm_nargs);
      SELECT                                                                                                                      
          pg_namespace_proc.nspname AS proc_nspname,                                                                              
          proargtypes,                                                                                                            
          prorettype,                                                                                                             
          pg_type_ret.typtype AS ret_typtype,                                                                                     
          pg_type_ret.typname AS ret_typname,                                                                                     
          pg_namespace_ret.nspname AS ret_nspname,                                                                                
          proretset                                                                                                               
      INTO ret                                                                                                                    
      FROM pg_proc                                                                                                                
          INNER JOIN pg_type pg_type_ret ON pg_type_ret.oid = pg_proc.prorettype                                                  
          INNER JOIN pg_namespace pg_namespace_ret ON pg_namespace_ret.oid = pg_type_ret.typnamespace                             
          INNER JOIN pg_namespace pg_namespace_proc ON pg_namespace_proc.oid = pg_proc.pronamespace                               
      WHERE proname = prm_method AND pronargs = prm_nargs;                                                                        
      RETURN ret;                                                                                                                 
END;                                                                                                                              
$$;
