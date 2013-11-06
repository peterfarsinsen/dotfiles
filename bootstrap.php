<?php

foreach(glob(__DIR__ . '/symlinks/.*') as $symlink) {
	$filename = basename($symlink);
	$home = trim(`echo ~/`);
	$dest = $home . $filename;

	if($filename === '.' || $filename === '..') {
		continue;
	}

	if(file_exists($dest)) {
		if(is_link($dest)) {
			unlink($dest);
		} else {
			$cmd = sprintf('mv %s %s', $dest, $dest . '.backup');
			`$cmd`;
		}
	}

	$cmd = sprintf('ln -s %s %s', $symlink, $dest);
	`$cmd`;
}

$cmd = sprintf('ln -s %s %s`', __DIR__ . '/bin', '~/bin');