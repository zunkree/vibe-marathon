module marathon.model.v2.parameter;


class Parameter
{
	string key;
	string value;

	this() {}

	this(string key, string value)
	{
		this.key = key;
		this.value = value;
	}
}

