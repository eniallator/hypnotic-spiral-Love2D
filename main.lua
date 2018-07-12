local myShader =
    love.graphics.newShader [[
    extern number counter;
    extern number maxX;
    extern number maxY;

    vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords ) {
        number PI = 3.141592653589793;
        number zoomLevel = 2;
        number speed = PI;

        number rScaleFactor = zoomLevel * 5;
        number gScaleFactor = zoomLevel * 7.5;
        number bScaleFactor = zoomLevel * 10;

        number x = screen_coords.x - maxX / 2;
        number y = maxY / 2 - screen_coords.y;

        number magnitude = sqrt(pow(x, 2) + pow(y, 2));
        number bearing = atan(abs(y / x));

        if (x >= 0 && y >= 0) {
            // top right
            bearing = PI * 0.5 - bearing;
        } else if (x >= 0 && y <= 0) {
            // bottom right
            bearing = PI * 0.5 + bearing;
        } else if (x <= 0 && y <= 0) {
            // bottom left
            bearing = PI * 1.5 - bearing;
        } else if (x <= 0 && y >= 0) {
            // top left
            bearing = PI * 1.5 + bearing;
        }

        number r = abs(sin(magnitude / rScaleFactor + bearing - counter * speed));
        number g = abs(sin(magnitude / gScaleFactor + bearing - counter * speed));
        number b = abs(sin(magnitude / bScaleFactor + bearing - counter * speed));

        return vec4(r, g, b, 1.0);
    }
]]

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
