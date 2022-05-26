z = 18

function Fuel()
    turtle.select(14)
    turtle.digUp()
    turtle.placeUp()
    turtle.suckUp()
    turtle.refuel()
    turtle.dropUp()
    turtle.digUp()
    item = turtle.getItemDetail()
    if item.name == "minecraft:bucket" then
        turtle.select(16)
        turtle.placeUp()
        turtle.select(14)
        turtle.dropUp()
        turtle.digUp()
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

function Empty()
    turtle.select(16)
    turtle.placeUp()
    for i=1, 13 do
        turtle.select(i)
        turtle.dropUp()
    end
    turtle.digUp()
    turtle.transferTo(16)
    turtle.select(1)
end


while true do
    local signal = rs.getInput("bottom")
    if signal then
        for i=1, z do 
            Move("forward")
            result, block = turtle.inspectDown()
            if result then
                turtle.digDown()
            end
        end
        Move("right")
        turtle.digDown()
        turtle.turnRight()
        for i=1, z do 
            Move("forward")
            result, block = turtle.inspectDown()
            if result then
                turtle.digDown()
            end
        end
        Move("right")
        turtle.turnRight()
        Move("back")
        Empty()
    end
    os.sleep(0.1)
end
