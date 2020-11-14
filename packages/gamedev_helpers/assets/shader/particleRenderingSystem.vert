#version 100

uniform mat4 uViewProjection;
attribute vec2 aPosition;
attribute float aRadius;
attribute vec4 aColor;
varying vec4 vColor;

void main() {
    gl_Position = uViewProjection * vec4(aPosition, 0.0, 1.0);
    gl_PointSize = aRadius;
    vColor = aColor;
}