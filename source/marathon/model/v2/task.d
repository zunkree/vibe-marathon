module marathon.model.v2.task;

import vibe.data.serialization;
import marathon.model.v2.health_check;


class Task
{
	string host;
	string id;
	string appId;
	ushort[] ports;
	string stagedAt;
	string startedAt;
	@optional HealthCheckResult[] healthCheckResults;
	@name("version") string _version;
}


class TaskFailure
{
	string appId;
	string host;
	string message;
	string state;
	string taskId;
	string timestamp;
	@name("version") string _version;
	string slaveId;
}


class GetTasksResp
{
	Task[] tasks;
}