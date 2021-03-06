precision mediump float;

uniform sampler2D velocity;
uniform vec2 px;
varying vec2 uv;

#include "converse.glsl"

void main() {
    // neighboring velocities
    vec4 x0_c = texture2D(velocity, uv-vec2(px.x, 0));
    vec4 x1_c = texture2D(velocity, uv+vec2(px.x, 0));
    vec4 y0_c = texture2D(velocity, uv-vec2(0, px.y));
    vec4 y1_c = texture2D(velocity, uv+vec2(0, px.y));

    float x0 = unpack2FloatsTo4bytes(x0_c).x;
    float x1 = unpack2FloatsTo4bytes(x1_c).x;
    float y0 = unpack2FloatsTo4bytes(y0_c).y;
    float y1 = unpack2FloatsTo4bytes(y1_c).y;

    float divergence = (x1 - x0 + y1 - y0) * 0.5;
    gl_FragColor = packFloatTo4bytes(divergence);
}
