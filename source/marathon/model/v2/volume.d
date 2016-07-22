module marathon.model.v2.volume;


class Volume
{
	private string _containerPath;
	private string _hostPath;
	private string _mode;

	@property string containerPath () { return _containerPath; }
	@property void containerPath (string containerPath) { _containerPath = containerPath; }

	@property string hostPath () { return _hostPath; }
	@property void hostPath (string hostPath) { _hostPath = hostPath; }

	@property string mode () { return _mode; }
	@property void mode (string mode) { _mode = mode; }
}

