module marathon.model.v2.container;

import marathon.model.v2.volume;
import marathon.model.v2.docker;


class Container
{
	string type;
	Docker docker;
	Volume[] volumes;
}

