<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //

/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress_db' );


/** Database username */
define( 'DB_USER', 'wp_user' );


/** Database password */
define( 'DB_PASSWORD', 'secure_user_password' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          'BcJm,zAx$Lr97BQGNhdVih#&W9of{LN1}5<ZY{AfCGllBgr]>STp(tv6&Pd*fSrz' );
define( 'SECURE_AUTH_KEY',   '/m@fq2+R*vP_|Q1`qi!V].k9h3HbjVK$g[&9{T{O0$!O kG=t`^/u$O%*.?Pf]$D' );
define( 'LOGGED_IN_KEY',     '=&MF{ill+ui7:0=fFHT*]q^zVJbpR<F6aT2cu Ty@MdZqw^Q6@ZWhw>Hj(eK,wG9' );
define( 'NONCE_KEY',         'vv(qU(Ja`PgH7-gD*,*W dWl,ReK]p%H9saV+(:z0;F_04wM*7djzgvqCMu?Z5JS' );
define( 'AUTH_SALT',         'gwv^!dd;DaI!8l<.w,0}ArnH,HJpy-eejH@>- [;f$)c:<NDWkzXc3Zw%k<1ElRj' );
define( 'SECURE_AUTH_SALT',  ':4_Fflead^IY#l-K+5^N^[{seXyN+c0tw3 $k>}>qv8JQN(TJi~f7)8+`+*)~ChT' );
define( 'LOGGED_IN_SALT',    '_diERPj0^Ix~)k{Byu;5j~oAwAjOcKfjmP O>7ckcfd<c ANS$cr=/5SXSSZCJY:' );
define( 'NONCE_SALT',        '!uQEDLVt/!,|2OQ)wo,sC)&)YGzC>mJKT/U:JzBwU<%^}u!KbtB{zBonl9.:DTy-' );
define( 'WP_CACHE_KEY_SALT', 'qG[jsm:L^<jMl67?G7x_d4-wZ<bqzK=S;iLauNuB2`(?m6&DiMi&@Zyn)XBL+(#|' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
