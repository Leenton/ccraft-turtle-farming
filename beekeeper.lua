x = 5
z = 26

function Fuel()
    turtle.select(14)
    turtle.placeDown()
    turtle.suckDown()
    turtle.refuel()
    turtle.dropDown()
    turtle.digDown()
    item = turtle.getItemDetail()
    if item.name == "minecraft:bucket" then
        turtle.select(16)
        turtle.placeDown()
        turtle.select(14)
        turtle.dropDown()
        turtle.digDown()
        turtle.transferTo(16)
        turtle.select(15)
        turtle.transferTo(14)
    end
    turtle.select(1)
end
 
function CheckFuel()
    local level = turtle.getFuelLevel()
    if level < 80 then
        Fuel()
    end 
end

function Move(Direction)
    CheckFuel()
    if Direction == "forward" then
        turtle.forward()
    elseif Direction == "back" then
        turtle.back()
    elseif Direction == "left" then
        turtle.turnLeft()
        turtle.forward()
    elseif Direction == "right" then
        turtle.turnRight()
        turtle.forward()
    elseif Direction == "up" then
        turtle.up()
    elseif Direction == "down" then
        turtle.down()
    end
end

function CheckGlass()
    turtle.select(1)
    GlassBottles = turtle.getItemCount()
    if GlassBottles < 1 then 
        turtle.select(13)
        turtle.placeDown()
        turtle.select(1)
        turtle.suckDown()
        turtle.select(13)
        turtle.digDown()
        turtle.select(1)
    end
end 

function FireDispenser()
    turtle.dropUp(1)
    rs.setOutput("top", true)
    os.sleep(0.1)
    rs.setOutput("top", false)
    turtle.suckUp()
end

function CollectHoney()
    Move("right")
    CheckGlass()
    FireDispenser()
    Move("back")
    turtle.turnLeft()
end

function CheckForHoney()
    local Result, HoneyLevel = turtle.inspectUp()
    if Result then
        if HoneyLevel.state.honey_level == 5 then
            CollectHoney()
            print("Hoeny Collected")
        else
            print("Not Enough Honey To Collect")
        end
    else
        print("No Block Detected Above")
    end
end

function Empty()
    turtle.select(16)
    turtle.placeDown()
    for i=2, 12 do
        turtle.select(i)
        turtle.dropDown()
    end
    turtle.digDown()
    turtle.transferTo(16)
    turtle.select(1)
end

while true do
    local signal = rs.getInput("bottom")
    if signal then
        Move("forward")
        for i=1, 2 do
            for i=1, z-2 do
                Move("forward")
                CheckForHoney()
            end
            Move("forward")
            turtle.turnLeft()
            for i=1, x-2 do
                Move("forward")
                CheckForHoney()
            end
            Move("forward")
            turtle.turnLeft()
        end
        Empty()
        Move("back")  
    end
    os.sleep(0.1)
end
