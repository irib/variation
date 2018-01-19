<?php
/*
This file is part of Variation.

Variation is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Variation is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with Variation.  If not, see <http://www.gnu.org/licenses/>.
--------------------------------------------------------------------------------
Ce fichier fait partie de Variation.

Variation est un logiciel libre ; vous pouvez le redistribuer ou le modifier 
suivant les termes de la GNU Affero General Public License telle que publiée 
par la Free Software Foundation ; soit la version 3 de la licence, soit 
(à votre gré) toute version ultérieure.

Variation est distribué dans l'espoir qu'il sera utile, 
mais SANS AUCUNE GARANTIE ; sans même la garantie tacite de 
QUALITÉ MARCHANDE ou d'ADÉQUATION à UN BUT PARTICULIER. Consultez la 
GNU Affero General Public License pour plus de détails.

Vous devez avoir reçu une copie de la GNU Affero General Public License 
en même temps que Variation ; si ce n'est pas le cas, 
consultez <http://www.gnu.org/licenses>.
--------------------------------------------------------------------------------
Copyright (c) 2014 Kavarna SARL
*/
?>
<?php

namespace Sabre\Accueil;
use Sabre\DAV;
use Sabre\HTTP;
use Sabre\HTTP\RequestInterface;
use Sabre\HTTP\ResponseInterface;

class AccueilDigestAuth extends Dav\Auth\Backend\AbstractDigest {
  public $token;
  private $base;
  //  private $token;
  function __construct ($base) {
    $this->base = $base;
  }
  
  public function getDigestHash ($realm, $username) {
    $ret = $this->base->utilisateur_get_digest_hash ($username);
    return $ret;
  }  

    /**
     * When this method is called, the backend must check if authentication was
     * successful.
     *
     * The returned value must be one of the following
     *
     * [true, "principals/username"]
     * [false, "reason for failure"]
     *
     * If authentication was successful, it's expected that the authentication
     * backend returns a so-called principal url.
     *
     * Examples of a principal url:
     *
     * principals/admin
     * principals/user1
     * principals/users/joe
     * principals/uid/123457
     *
     * If you don't use WebDAV ACL (RFC3744) we recommend that you simply
     * return a string such as:
     *
     * principals/users/[username]
     *
     * @param RequestInterface $request
     * @param ResponseInterface $response
     * @return array
     */
    function check(RequestInterface $request, ResponseInterface $response) {

        $digest = new HTTP\Auth\Digest(
            $this->realm,
            $request,
            $response
        );
        $digest->init();

        $username = $digest->getUsername();

        // No username was given
        if (!$username) {
            return [false, "No 'Authorization: Digest' header found. Either the client didn't send one, or the server is mis-configured"];
        }

        $hash = $this->getDigestHash($this->realm, $username);
        // If this was false, the user account didn't exist
        if ($hash === false || is_null($hash)) {
            return [false, "Username or password was incorrect"];
        }
        if (!is_string($hash)) {
            throw new DAV\Exception('The returned value from getDigestHash must be a string or null');
        }

        // If this was false, the password or part of the hash was incorrect.
        if (!$digest->validateA1($hash)) {
            return [false, "Username or password was incorrect"];
        }

	$ret = $digest->getValidationString (); // Attention, rajouter cette fonction dans HTTP\DigestAuth                                                                                            
	
	$str = $ret['part'];
	$result = $this->base->utilisateur_login_digest ($username, $str, $ret['response']);
	
	if ($result) {
	  $this->token = $result;
	  global $_SESSION;
	  $_SESSION['token'] = $this->token;
	  $this->currentUser = $username;	  
	} else {
	  $digest->requireLogin();
	  throw new DAV\Exception\NotAuthenticated('Incorrect username');
	  return [false, "Incorrect"];
	}
	
        return [true, $this->principalPrefix . $username];

    }

}

?>