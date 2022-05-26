local state, farm = ...sleep
local SiteList = {}
SiteList["Tree"] = 19
SiteList["Fungus"] = 21
SiteList["Honey"] = 22
SiteList["Food"] = 3
SiteList["Coco"] = 7


function TurnOn(Site)
    rednet.open("back")
    rednet.send(SiteList(Site), true)
    print("Message to turn on " .. Site .. " has been sent to the farm hopefully it should turn on")

end

function TurnOff(Site)
    rednet.open("back")
    rednet.send(SiteList(Site), false)
    print("Message to turn of " .. Site .. " has been sent, hopefylly it fucks off")
end


if state == "kill" or state == "Kill" then 
    TurnOff(farm)
    rednet.close()
elseif state == "on" or state == "On" then
    TurnOn(farm)
    rednet.close()
else
    print("Give me better parameters idiot")
end 