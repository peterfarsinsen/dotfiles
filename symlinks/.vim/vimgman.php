#!/opt/local/bin/php
<?php

$plugins = array(
	'NERDCommenter' => 'http://github.com/jc00ke/nerdcommenter.git',
	'taglist.vim' => 'http://github.com/jc00ke/taglist.vim.git',
	'phpcomplete' => 'http://github.com/shawncplus/phpcomplete.vim.git',
	'checksyntax' => 'http://github.com/tomtom/checksyntax_vim.git',
	'ack.vim' => 'http://github.com/mileszs/ack.vim.git',
	'camelCaseMotion' => 'http://github.com/vim-scripts/camelcasemotion.git',
	'solarized' => 'git://github.com/altercation/vim-colors-solarized.git',
	'jshint.vim' => 'https://github.com/Townk/vim-autoclose.git',
	'ultisnips' => 'https://github.com/SirVer/ultisnips.git',
	'Command-T' => array(
		'url' => 'http://github.com/wincent/Command-T.git',
		'callback' => function($vimgman, $path) {
			$cmd = sprintf( 'cd %s/ruby/command-t' .
				'&& ruby extconf.rb' .
				'&& make', $path
			);

			$out = null;
			system($cmd, $out);
			return $out;
		}
	),
	'Pathogen.vim' => array(
		'url' => 'http://github.com/tpope/vim-pathogen.git',
		'callback' => function($vimgman, $path) {
			$source = $path .'/autoload/pathogen.vim';
			$destination = $vimgman->getPath() .'/autoload/pathogen.vim';
			$out = null;
			if(!file_exists($destination)) {
				$cmd = sprintf('ln -s %s %s', $source, $destination);
				system($cmd, $out);
			}
			return $out;
		},
		'path' => 'vimgman'
	)
);

$vimgman = new Vimgman($plugins);

class Vimgman {
	protected $path = null;
	protected $plugins = array();
	protected $stdout = null;

	public function __construct($plugins, $path=null) {
		$this->plugins = $plugins;
		if(is_null($path)) {
			$path = `echo ~/`;
			$this->path = trim($path).'.vim';
		} else {
			$this->path = $path;
		}

		$this->setup();
		$this->updatePlugins();
	}

	public function getPath() {
		return $this->path;
	}

	protected function setup() {
		$dirs = array('autoload', 'bundle', 'vimgman');

		foreach($dirs as $dir) {
			$path = $this->path . '/' . $dir;
			if(!file_exists($path) || !is_dir($path)) {
				$this->out(sprintf('Creating missing directory: %s', $path));
				mkdir($path);
			}
		}
	}

	protected function out($str, $trailingNewline=true) {
		if($trailingNewline) {
			$str .= "\n";
		}
		fwrite(STDOUT, $str);
	}

	protected function updatePlugins() {
		foreach($this->plugins as $name => $plugin) {
			if(is_array($plugin)) {
				$url = $plugin['url'];
				$callback = $plugin['callback'];
			} else {
				$url = $plugin;
			}

			$this->out(sprintf("Upgrading plugin: %s", $name));

			if(is_array($plugin) && isset($plugin['path'])) {
				$path = $this->path . '/'. $plugin['path'] .'/'. $name;
			} else {
				$path = $this->path .'/bundle/'. $name;
			}

			if($this->updatePlugin($name, $url, $path)) {
				$this->out(sprintf("Done upgrading plugin: %s", $name));
				if(isset($callback) && is_callable($callback)) {
					$this->out(sprintf("Triggering callback for %s", $name));
					$out = $callback($this, $path);
					$this->out($out);
				}
			} else {
				$this->out(sprintf("Failed upgrading plugin: %s", $name));
			}
		}
	}

	protected function updatePlugin($name, $url, $path) {
		switch(true) {
			case (bool) strstr($url, 'github.com'):
				return $this->updatePluginFromGithub($name, $url, $path);
				break;
			default;
				$this->out(sprintf("Couldn't decide on an upgrade strategy for the plugin: %s", $name));
				return false;
				break;
		}
	}

	protected function updatePluginFromGithub($name, $url, $path) {
		$out = null;

		if(!file_exists($path) || !is_dir($path)) {
			mkdir($path);
			system(sprintf('cd %s && git clone %s .', $path, $url, $name), $out);
		} else {
			system(sprintf('cd %s && git pull origin master', $path), $out);
		}
		$this->out($out);
		return true;
	}
}
?>