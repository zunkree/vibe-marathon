module marathon.model.v2.docker;

import marathon.model.v2.port;
import marathon.model.v2.parameter;


enum networkType {
	Host = "HOST",
	Bridge = "BRIDGE",
	None = "NONE"
}

class Docker
{
	string image;
	networkType network;
	bool forcePullImage;
	Port[] portMappings;
	Parameter[] parameters;
	bool privileged;
}

