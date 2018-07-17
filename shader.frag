uniform highp float counter;
uniform lowp float maxX;
uniform lowp float maxY;

vec4 effect( in vec4 colour, in sampler2D texture, in vec2 texture_coords, in vec2 screen_coords ) {
    const highp float PI = 3.141592653589793;
    const highp float zoomLevel = 2.0;
    const highp float speed = PI;

    highp float rScaleFactor = zoomLevel * 5.0;
    highp float gScaleFactor = zoomLevel * 7.5;
    highp float bScaleFactor = zoomLevel * 10.0;

    mediump float x = screen_coords.x - maxX / 2.0;
    mediump float y = maxY / 2.0 - screen_coords.y;

    highp float magnitude = sqrt(pow(x, 2) + pow(y, 2));
    highp float bearing = atan(abs(y / x));

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

    highp float r = abs(sin(magnitude / rScaleFactor + bearing - counter * speed));
    highp float g = abs(sin(magnitude / gScaleFactor + bearing - counter * speed));
    highp float b = abs(sin(magnitude / bScaleFactor + bearing - counter * speed));

    return vec4(r, g, b, 1.0);
}