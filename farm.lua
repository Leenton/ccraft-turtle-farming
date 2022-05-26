slot = 1
x = 11
z = 5
function Fuel()
    turtle.select(14)
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
 
function Plant()
    while true do 
        if turtle.placeDown() then
            break
        else 
            if slot == 13 then
                slot = 1
                turtle.select(slot)
            else 
                slot = slot + 1
                turtle.select(slot)
            end 
        end
    end
end
 
function Harvest()
    local Result, CropLevel = turtle.inspectDown()
    if Result then
        if CropLevel.state.age == 7 then
            turtle.digDown()
            Plant()
        end
    else
        turtle.digDown()
        Plant()
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
 
function Move()
    CheckFuel()
    turtle.forward()
end
 
function TurnR()
    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()
end
 
function TurnL()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
end
 
function Farm()
    for i=1, z do
        for t=1, x do 
            Harvest()
            if t ~= x then
                Move()
            end
        end
        if i == z then
            turtle.turnLeft()
            turtle.turnLeft()
        elseif i % 2 == 0 then
            TurnL()
        else
            TurnR()
        end
    end
end

while true do
    local signal = rs.getInput("bottom")
    if signal then
        CheckFuel()
        turtle.up()
        turtle.forward()
        Farm()
        Farm()
        turtle.back()
        turtle.down()
        Empty()
    end
    os.sleep(0.1)
end

 