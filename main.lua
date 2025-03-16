

local background = display.newImageRect( "images/background.png", 360, 570 )
background.x = display.contentCenterX
background.y = display.contentCenterY

local platform = display.newImageRect( "images/platform.png", 300, 50 )
platform.x = display.contentCenterX
platform.y = display.contentHeight-25

local balloon = display.newImageRect( "images/balloon.png", 112, 112 )
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloonAlpha = 0.8

local tapCount = 0
tapText = display.newText( tapCount, display.contentCenterX, 20, native.systemFont, 40 )
tapText:toFront()
tapText:setFillColor( 0, 0, 0 )

local gameOverText = display.newText( "", display.contentCenterX, display.contentCenterY, native.systemFont, 50 )
gameOverText:setFillColor( 1, 0, 0 )

local physics = require( "physics" )
physics.start()

physics.addBody( platform, "static" )
physics.addBody( balloon, "dynamic", { radius=50, bounce=0.3 } )

local function pushBalloon()
    balloon:applyLinearImpulse( 0, -0.75, balloon.x, balloon.y )
    tapCount = tapCount + 1
    tapText.text = tapCount
end

local function restartGame()
    if gameOver then
        gameOver = false 
        gameOverText.text = ""
        tapCount = 0
        tapText.text = tapCount
        balloon.x = display.contentCenterX
        balloon.y = display.contentCenterY
        balloon:setLinearVelocity( 0, 0 )
    end
end

local function onCollision(event)
    if event.phase == 'began' then
        if (event.object1 == balloon and event.object2 == platform) or (event.object1 == platform and event.object2 == balloon) then
            gameOver = true
            gameOverText.text = 'Game Over'
        end 
    end  
end


balloon:addEventListener( "tap", pushBalloon )
Runtime:addEventListener( "collision", onCollision )
Runtime:addEventListener( "tap", restartGame)