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
    turtle.turnRight()
    turtle.turnRight()
    local Block, Leaves = turtle.inspect()
    if Block then
        if Leaves.name == "minecraft:warped_wart_block" or Leaves.name == "minecraft:crimson_wart_block" then
            trurtle.dig()
        end
    end
    turtle.turnRight()
    turtle.turnRight()
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

function Harvest()
    turtle.dig()
end

function PlaceFungus()
    turtle.select(1)
    local Count = turtle.getItemCount()
    if Count <= 0 then 
        for i =1 , 5 do
            Move("back")
        end
        rs.setOutput("back", false)
        os.sleep(24)
        rs.setOutput("back", true)
        for i = 1, 5 do
            Move("forward")
        end
    end
    turtle.place()
end

function PlaceBoneMeal()
    turtle.select(2)
    Count = turtle.getItemCount()
    if Count == 0 then 
        for i = 1, 5 do
            Move("back")
        end
        Move("left")
        rs.setOutput("left", false)
        os.sleep(24)
        rs.setOutput("left", true)
        Move("back")
        Move("right")
        for i = 1, 4 do
            Move("forward")
        end
    end
    turtle.place()
end

function Plant()
    local Block, Fungus = turtle.inspect()
    while Block == false do 
        PlaceFungus()
        Block, Fungus = turtle.inspect()
    end
    while Block == true do
        
        if Fungus.name == "minecraft:warped_stem" or Fungus.name == "minecraft:crimson_stem" then
            Block = false
        else
            PlaceBoneMeal()
            Block, Fungus = turtle.inspect()
        end
    end  
end

while true do
    local Result, Block = turtle.inspect()
    if Result then 
        if Block.name == "minecraft:warped_stem" or Block.name == "minecraft:crimson_stem" then
            Harvest()
        else
            Plant()
        end
    else
        Plant()
        Harvest()
    end
    Harvest()
end