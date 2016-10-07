-- Check incoming request
-- Should contain either
-- - PHPSessionID
-- - OAuth Access-Token
-- - JWT token








-- Extending the Base Plugin handler is optional, as there is no real
-- concept of interface in Lua, but the Base Plugin handler's methods
-- can be called from your child implementation and will print logs
-- in your `error.log` file (where all logs are printed).
local BasePlugin = require "kong.plugins.base_plugin"
local http = require "socket.http"
local ShowpadHandler = BasePlugin:extend()

-- Your plugin handler's constructor. If you are extending the
-- Base Plugin handler, it's only role is to instantiate itself
-- with a name. The name is your plugin name as it will be printed in the logs.
function ShowpadHandler:new()
  ShowpadHandler.super.new(self, "showpad")


end

-- Executed upon every Nginx worker process's startup.
function ShowpadHandler:init_worker(config)
  -- Eventually, execute the parent implementation
  -- (will log that your plugin is entering this context)
  ShowpadHandler.super.init_worker(self)

  -- Implement any custom logic here

end

-- Executed during the SSL certificate serving phase of the SSL handshake.
function ShowpadHandler:certificate(config)
  ShowpadHandler.super.certificate(self)

  -- Implement any custom logic here
end

-- Executed for every request upon it's reception from a client and before it is being proxied to the upstream service.
function ShowpadHandler:access(config)
  ShowpadHandler.super.access(self)

  local  body, code, headers, status = http.request {
    method = "GET",
    url = "https://www.google.com"
  }

  ngx.header["X-My-Header"] = "status: " .. status;
end

-- Executed when all response headers bytes have been received from the upstream service.
function ShowpadHandler:header_filter(config)
  ShowpadHandler.super.header_filter(self)

  -- Implement any custom logic here
end

-- Executed for each chunk of the response body received from the upstream service. Since the response is streamed back to the client, it can exceed the buffer size and be streamed chunk by chunk. hence this method can be called multiple times if the response is large. See the lua-nginx-module documentation for more details.
function ShowpadHandler:body_filter(config)
  ShowpadHandler.super.body_filter(self)

  -- Implement any custom logic here

end

-- Executed when the last response byte has been sent to the client.
function ShowpadHandler:log(config)
  ShowpadHandler.super.log(self)

  -- Implement any custom logic here

end

-- This module needs to return the created table, so that Kong
-- can execute those functions.
return ShowpadHandler
