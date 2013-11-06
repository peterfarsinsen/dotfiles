<?php
$projects = array(
	'spilnu.dk' => array(
		'path' => '/Users/peter/Shares/dev.spilnu.dk/dev.spilnu.dk/',
		'excludes' => array(
			'/Users/peter/Shares/dev.spilnu.dk/dev.spilnu.dk/migrations/*'
		),
		'extensions' => array('.php')
	)
);

class CtagsBuilder {
	protected $defaults = array(
		'excludes' => array(),
		'path' => null,
		'extensions' => array(
			'.php'
		)
	);

	protected $name = null;
	protected $config = null;

	public function __construct($name, $config) {
		$this->name = $name;
		$this->config = array_merge($this->defaults, $config);
		$this->config['excludes'] = array_merge($this->config['excludes'], array('\.svn', '\.git'));
	}

	protected function buildCmd() {
		$cmd = array();
		$cmd[] = sprintf('exec ctags -f ~/.ctags/%s', $this->name);
		$cmd[] = sprintf('-h "%s" -R', join(' ', $this->config['extensions']));

		foreach($this->config['excludes'] as $exclude) {
			$cmd[] = sprintf('--exclude=%s', $exclude);
		}

		$cmd[] = '--totals=yes';
		$cmd[] = '--PHP-kinds=+cf';
		$cmd[] = '--regex-PHP=\'/abstract class ([^ ]*)/\1/c/\'';
		$cmd[] = '--regex-PHP=\'/interface ([^ ]*)/\1/c/\'';
		$cmd[] = '--regex-PHP=\'/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/\'';
		$cmd[] = $this->config['path'];

		return implode(' ', $cmd);
	}

	public function execute() {
		$output = null;
		$result = null;
		$cmd = $this->buildCmd();

		exec($cmd, $output, $result);

		return $result;
	}
}

$builder = new CtagsBuilder('spilnu.dk', $projects['spilnu.dk']);
$builder->execute();
?>
