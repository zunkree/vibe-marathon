module marathon.model.v2.app;

import std.math;
import std.typecons;

import vibe.data.serialization;

import marathon.model.v2.task;
import marathon.model.v2.container;
import marathon.model.v2.health_check;
import marathon.model.v2.upgrade_strategy;


class Fetch
{
	string uri;
	bool executable;
	bool extract;
	bool cache;
}

class Deployment
{
	string id;
}

class App
{
	string id;
	@optional string cmd;
	int instances;
	float cpus = 0;
	float mem = 0;
	float disk = 0;
	Fetch[] fetch;
	string[][] constraints;
	@ignore string[] acceptedResourceRoles;
	Container container;
	string[string] env;
	string[string] labels;
	string executor;
	ushort[] ports;
	bool requirePorts;
	string[] dependencies;
	int backoffSeconds;
	float backoffFactor = 0;
	int maxLaunchDelaySeconds;
	@optional Task[] tasks;
	int tasksStaged;
	int tasksRunning;
	int tasksHealthy;
	int tasksUnhealthy;
	HealthCheck[] healthChecks;
	UpgradeStrategy upgradeStrategy;

	Deployment[] deployments;
	@optional TaskFailure lastTaskFailure;

	this() {}

	App withId (string id)
	{
		this.id = id;
		return this;
	}

	App withCmd (string cmd)
	{
		this.cmd = cmd;
		return this;
	}

	App withMem (float mem)
	{
		this.mem = mem;
		return this;
	}

	App withCpus (float cpus)
	{
		this.cpus = cpus;
		return this;
	}

	App withDisk (float disk)
	{
		this.disk = disk;
		return this;
	}

	App withInstances (uint instances)
	{
		this.instances = instances;
		return this;
	}
}


class GetAppsResp
{
	App[] apps;
}


class GetAppResp
{
	App app;
}


class GetAppTasksResp
{
	Task[] tasks;
}