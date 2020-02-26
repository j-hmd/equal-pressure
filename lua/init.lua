wifi.setmode(wifi.STATION)
wifi.sta.config("CXNK00605F35","7783026654")
print(wifi.sta.getip())
led1 = 0
--led2 = 4
gpio.mode(led1, gpio.OUTPUT)
--gpio.mode(led2, gpio.OUTPUT)

if srv~=nil then
  srv:close()
end

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
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
        buf = buf.."<p>GPIO0 <a href=\"?pin=ON1\"><button>ON</button></a>&nbsp;<a href=\"?pin=OFF1\"><button>OFF</button></a></p>";
        buf = buf.."</body>"
        local _on,_off = "",""
        if(_GET.pin == "ON1")then
              gpio.write(led1, gpio.LOW); -- because pin 0 ia active low
        elseif(_GET.pin == "OFF1")then
              gpio.write(led1, gpio.HIGH);
        end
        client:send("HTTP/1.1 200 OK\n\n");
        client:send(buf);
        client:close()
        collectgarbage();
    end)
end)