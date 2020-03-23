wifi.setmode(wifi.STATION)

ssid = "***"
pwd= "***"
wifi.sta.config(ssid, pwd)

wifi.sta.getip()

-- Only one server is allowed
if srv then srv:close() end

-- Crating TCP connection
srv=net.createServer(net.TCP)
srv:listen(80,function(conn) -- net.server.listen([port],[ip],function(net.socket))
    conn:on("receive", function(client,request) -- "connection", "reconnection", "disconnection", "receive" or "sent", and 
        print(request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        -- Buffering message to be sent
        buf = buf.."<!DOCTYPE html>"
        but = buf.."<body>"
        buf = buf.."<h1> ESP8266 Web Server</h1>";
        buf = buf.."<p>Read Pressure <a href=\"?pin=ON1\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF1\"><button>OFF</button></a></p>";
        buf = buf.."</body>"
        local _on,_off = "",""
        local pressureTable = {}
        if(_GET.pin == "ON1")then
            for i=1,100 do    
                buf = buf..adc.read(0)
                buf = buf.."<br>"
            end
              --end
              --gpio.write(led1, gpio.LOW); -- because pin 0 ia active low
        elseif(_GET.pin == "OFF1")then
            -- reset
        end
        
        client:send("HTTP/1.1 200 OK\n\n");
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)

