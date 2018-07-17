local myShader = love.graphics.newShader('shader.frag')
local w
local counter = 0

function love.update(dt)
    w = {love.graphics.getDimensions()}
    myShader:send('maxX', w[1])
    myShader:send('maxY', w[2])
    myShader:send('counter', counter)
    counter = counter + dt
end

function love.draw()
    love.graphics.setShader(myShader)
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle('fill', 0, 0, w[1], w[2])
end
