slot = 1

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
    local Block, Leaves = turtle.inspect()
    if Block then
        if Leaves.name == "minecraft:spruce_leaves" then
            trurtle.dig()
        end
    end
    Block, Leaves = turtle.inspectUp()
    if Block then
        if Leaves.name == "minecraft:spruce_leaves" then
            trurtle.digUp()
        end
    end
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
end

function ChopDown()
    turtle.dig()
end

function PlantSaplings()
    print("planting")
    turtle.placeDown()
    Move("forward")
    turtle.placeDown()
    Move("right")
    turtle.placeDown()
    Move("right")
    turtle.placeDown()
    Move("right")
    turtle.turnRight()
    print("done planting")
end

function InspectTree()
    Move("forward")
    local Result, Sapling = turtle.inspect()
    if Result then
        if Sapling.name == "minecraft:spruce_log" then
            return true
        else
            return false
        end
    else
        return false
    end 
end

function Farm()
    Move("forward")
    Move("forward")
    Move("forward")
    local InspectionResult = InspectTree()
    if InspectionResult then 
        Move("up")
        ChopDown()
        Move("forward")
        PlantSaplings()
        Move("back")
        Move("back")
        Move("down")
    else
        Move("back")
    end
    Move("back")
    Move("back")
    Move("back")
    os.sleep(60)
end 

while true do 
    turtle.select(1)
    local held = turtle.getItemCount()
    while held < 4 do 
        rs.setOutput("back", false)
        os.sleep(0.1)
        held = turtle.getItemCount()
    end
    rs.setOutput("back", true)
    Farm()
end