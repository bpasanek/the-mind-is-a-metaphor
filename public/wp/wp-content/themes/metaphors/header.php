<?php
/**
 * @package WordPress
 * @subpackage Metaphors_Theme
 */
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" <?php language_attributes(); ?>>
	
<head profile="http://gmpg.org/xfn/11">
	<meta http-equiv="Content-Type" content="<?php bloginfo('html_type'); ?>; charset=<?php bloginfo('charset'); ?>" />
	<title><?php wp_title('&laquo;', true, 'right'); ?> <?php bloginfo('name'); ?></title>
	<link href="http://yui.yahooapis.com/combo?2.7.0/build/reset-fonts-grids/reset-fonts-grids.css&amp;2.7.0/build/base/base-min.css" media="screen" rel="stylesheet" type="text/css"/>
	<link rel="alternate" type="application/rss+xml" title="Mind is a Metaphor RSS Feed" href="/metaphors.rss"/>
	<link rel="stylesheet" href="<?php bloginfo('stylesheet_url'); ?>" type="text/css" media="screen" />
	<link rel="pingback" href="<?php bloginfo('pingback_url'); ?>" />
	<style type="text/css" media="screen">
		<?php
		// Checks to see whether it needs a sidebar or not
		if ( empty($withcomments) && !is_single() ) {
		?>
		<?php } ?>
	</style>
	
	<?php if ( is_singular() ) wp_enqueue_script( 'comment-reply' ); ?>
	<?php wp_head(); ?>
	
</head>
<body>
	<div id="doc3" class="yui-t2">
		<div id="yui-main">
		<div id="hd" class="banner">
			<div id="header_nav">
				<ul>
					<li><a href="/metaphors">Home</a></li>
					<li><a href="/blog">Blog</a></li>
					<li><a href="/about">About</a></li>
					<li><a href="/contact">Contact</a></li>
					<li><a href="/metaphors">Search</a></li>
				</ul>
			</div>
			
			<div id="logo_band">
				<img src="<?php bloginfo('template_directory'); ?>/images/logo.jpg" class="logo" alt="The Mind is a Metaphor Logo" title="The Mind is a Metaphor Logo">
			</div>
		</div>
		
		<div id="bd">
			<div id="main_content">
