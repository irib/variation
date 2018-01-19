<?php

/*

CalendarServer example

This server features CalDAV support

*/

// settings
date_default_timezone_set('UTC');

// If you want to run the SabreDAV server in a custom location (using mod_rewrite for instance)
// You can override the baseUri here.
// $baseUri = '/';

//Mapping PHP errors to exceptions
function exception_error_handler($errno, $errstr, $errfile, $errline) {
    throw new ErrorException($errstr, 0, $errno, $errfile, $errline);
}
set_error_handler("exception_error_handler");

// Files we need
require_once 'vendor/autoload.php';
require 'Accueil/AccueilDigestAuth.php';
require 'Accueil/AccueilCalPrincipal.php';
require 'Accueil/AccueilCalendars.php';

require '../../inc/config.inc.php';
require '../../inc/enums.inc.php';
require '../../inc/localise.inc.php';
require '../../inc/pgprocedures.class.php';
$base = new PgProcedures ($pghost, $pguser, $pgpass, $pgbase);

// Backends
$authBackend = new Sabre\Accueil\AccueilDigestAuth ($base);
$authBackend->setRealm('Accueil');
$calendarBackend = new Sabre\Accueil\AccueilCalendars($base, $authBackend);
$principalBackend = new Sabre\Accueil\AccueilCalPrincipal($base, $authBackend);

// Directory structure
$tree = [
    new Sabre\CalDAV\Principal\Collection($principalBackend),
    new Sabre\CalDAV\CalendarRoot($principalBackend, $calendarBackend),
];

$server = new Sabre\DAV\Server($tree);

if (isset($baseUri))
    $server->setBaseUri($baseUri);

/* Server Plugins */
$authPlugin = new Sabre\DAV\Auth\Plugin($authBackend);
$server->addPlugin($authPlugin);

$aclPlugin = new Sabre\DAVACL\Plugin();
$server->addPlugin($aclPlugin);

/* CalDAV support */
$caldavPlugin = new Sabre\CalDAV\Plugin();
$server->addPlugin($caldavPlugin);

/* Calendar subscription support */
/*$server->addPlugin(
    new Sabre\CalDAV\Subscriptions\Plugin()
    );*/

/* Calendar scheduling support */
/*$server->addPlugin(
    new Sabre\CalDAV\Schedule\Plugin()
    );*/

/* WebDAV-Sync plugin */
$server->addPlugin(new Sabre\DAV\Sync\Plugin());

// Support for html frontend
$browser = new Sabre\DAV\Browser\Plugin();
$server->addPlugin($browser);

// And off we go!
$server->exec();
