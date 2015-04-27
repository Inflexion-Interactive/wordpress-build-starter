<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, and ABSPATH. You can find more information by visiting
 * {@link http://codex.wordpress.org/Editing_wp-config.php Editing wp-config.php}
 * Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */

/** MySQL database username */

/** MySQL database password */

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
define('FS_METHOD', 'direct');
define('AUTH_KEY',         '[QwI.d2H,?W|u+HH#}5)6-_J46?G8f^vcg8*2 3?^_ep2$_sBQ1]1V|4l@A7a~?8');
define('SECURE_AUTH_KEY',  '(i|O~ag,Bd<}/|6aEn?^U}PA=;n4xDY2Qt7RB|q]AtlyD1VoFr!50-_2?e#$lPs-');
define('LOGGED_IN_KEY',    'JX8c-v]=-3bGk<otQ&U.$;7zu~V7U@$|u`.)3nP .s8 yjIM Q4-XLgfWzhDkx!]');
define('NONCE_KEY',        '+7!,E|j-t[moGkd}pR@SCE;zm@B48rbxO#;m!#}fn>?.0__-OP06n<* P#{QcPKU');
define('AUTH_SALT',        '-$4P*{f>BFu1B3AZoTKfl/,^:yqRf)WGnk#-bo2+)66*tpa{$3Nn;,0.Oq-KBmjM');
define('SECURE_AUTH_SALT', ':P>`ywPZq5-wKfQUJ]ep#pw@PK)+LdKGd/E|WhGv/ZDCc_:H/mDzB@%!: %;EY>x');
define('LOGGED_IN_SALT',   'x|}zR E(+?|lEm0nK|B^,EmS!tZuU</*2A{Mm:R86*^&tuBZlSdHjnugX|0yCWEb');
define('NONCE_SALT',       '9V7n_O}TC[C]BHv|M7W0U8^75xsVvo*Kg5i?W|;ErMKmV*2cve/kFE*FwLfWNh:r');
define('DB_NAME', 'wordpress_production');
define('DB_USER', 'wordpress');
define('DB_PASSWORD', '6nQpveKWQs');

require_once(ABSPATH . 'wp-settings.php');
