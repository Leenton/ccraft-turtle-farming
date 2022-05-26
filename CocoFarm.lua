slot = 1
y = 23

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

function Plant()
    while true do 
        if turtle.place() then
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

function CocoPlant()
    Result, Coco = turtle.inspect()
    if Result then 
        if Coco.state.age == 2 then 
            turtle.dig()
            Plant()
        end
    else
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

while true do 
    trigger = rs.getInput("back")
    if trigger then
        for i=1, 4 do
            for i=1, y do
                CocoPlant()
                Move("up")
            end
            CocoPlant()
            Move("right")
            turtle.turnLeft()
            CocoPlant()
            for i=1, y do
                Move("down")
                CocoPlant()
            end
            Move("right")
            Move("forward")
            Move("left")
            Move("forward")
            turtle.turnLeft()
        end
        Empty()
    end
    os.sleep(0.1)
end
