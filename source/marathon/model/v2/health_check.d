module marathon.model.v2.health_check;

import vibe.data.serialization;


class HealthCheckResult
{
	bool alive;
	int consecutiveFailures;
	string firstSuccess;
	@optional string lastFailure;
	string lastSuccess;
	string taskId;
}

class HealthCheck
{
	@optional string command;
	int gracePeriodSeconds;
	int intervalSeconds;
	int maxConsecutiveFailures;
	int portIndex;
	int timeoutSeconds;
	bool ignoreHttp1xx;
	@optional string path;
	string protocol;
}