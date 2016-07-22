module marathon.client;

import std.format;

import vibe.web.rest;
import vibe.inet.url;
import vibe.data.json;
import vibe.http.client;
import vibe.http.common;

import vibe.core.log;
import vibe.stream.operations;

import marathon.model.v2.app;
import marathon.model.v2.task;
import marathon.model.v2.result;


interface MarathonREST
{
	@path("/v2/apps")
	@method(HTTPMethod.GET)
	GetAppsResp getApps();

	@path("/v2/apps/:id")
	@method(HTTPMethod.GET)
	GetAppResp getApp(string _id);

	@path("/v2/apps/:id/tasks")
	@method(HTTPMethod.GET)
	GetAppTasksResp getAppTasks(string _id);

	@path("/v2/tasks")
	@method(HTTPMethod.GET)
	GetTasksResp getTasks();

	@path("/v2/apps")
	@method(HTTPMethod.POST)
	App createApp(App app);

	@path("/v2/apps/:id")
	@method(HTTPMethod.PUT)
	Result updateApp(string _id, App app);
}


class MarathonClient : MarathonREST
{
	private URL _url;
	
	this(string url)
	{
		_url = URL(url);
	}
	
	GetAppsResp getApps()
	{
		auto path = "/v2/apps";
		auto result = request(path, HTTPMethod.GET);
		return result.deserializeJson!GetAppsResp;
	}
	
	GetAppResp getApp(string _id)
	{
		auto path = format("/v2/apps/%s", _id);
		auto result = request(path, HTTPMethod.GET);
		return result.deserializeJson!GetAppResp;
	}
	
	GetAppTasksResp getAppTasks(string _id)
	{
		auto path = format("/v2/apps/%s/tasks", _id);
		auto result = request(path, HTTPMethod.GET);
		return result.deserializeJson!GetAppTasksResp;
	}
	
	GetTasksResp getTasks()
	{
		auto path = "/v2/tasks";
		auto result = request(path, HTTPMethod.GET);
		return result.deserializeJson!GetTasksResp;
	}
		
	App createApp(App app)
	{
		auto path = "/v2/apps";
		auto result = request(path, HTTPMethod.POST, app.serializeToJson);
		return result.deserializeJson!App;
	}
	
	Result updateApp(string _id, App app)
	{
		auto path = format("/v2/apps/%s", _id);
		auto result = request(path, HTTPMethod.PUT, app.serializeToJson);
		return result.deserializeJson!Result;
	}
	
	void restartApp(string _id, bool force)
	{
		auto path = format("/v2/apps/%s/restart?force=%s", _id, force);
		request(path, HTTPMethod.POST);
	}
	
	Result deleteApp(string _id)
	{
		auto path = format("/v2/apps/%s", _id);
		auto result = request(path, HTTPMethod.DELETE);
		return result.deserializeJson!Result;
	}
	
	private Json request(string path, HTTPMethod method, Json content = null)
	{
		auto url = _url;
		url.pathString = url.pathString ~ path;
		Json ret;
		logInfo("REST call: %s %s '%s'", httpMethodString(method),
				url.toString(), content.toString);
		requestHTTP(url,
			(scope req) {
				req.method = method;
				req.contentType = "application/json";
				if (content.sizeof) {
					req.writeJsonBody(content);
				}
			},
			(scope res) {
				ret = res.readJson;
				logInfo("REST resp: %d '%s'", res.statusCode, ret.toString);
				if (!isSuccessCode(cast(HTTPStatus)res.statusCode))
					throw new RestException(res.statusCode, ret);
			}
		);
		return ret;	
	}
}