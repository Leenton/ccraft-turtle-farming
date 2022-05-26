while true do 
    os.sleep(180)
    rs.setOutput("bottom", false)
    print("Activating Bots")
    os.sleep(3)
    print("Activation Complete")
    rs.setOutput("bottom", true)
end