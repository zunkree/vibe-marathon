module marathon.model.v2.result;

import vibe.data.serialization;


class Result
{
	@name("version") string _version;
	string deploymentId;
}