#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:dynamictransforms.glsl>
#include <minecraft:projection.glsl>
//#include <minecraft:fog.glsl>
#include <bracken:compare_float.glsl>
#include <bracken:get_dimension.glsl>

layout(location = 0) in vec3 Position;
layout(location = 1) in vec2 UV0;

uniform sampler2D Sampler0;

layout(location = 0) out vec2 texCoord0;
layout(location = 1) flat out int isCelestial;
layout(location = 2) flat out float frames;
layout(location = 3) flat out float textureShift;
layout(location = 4) flat out float textureHeight;
layout(location = 5) flat out vec2 atlasSize;

bool isMarker(vec4 color, vec4 compareColor) {
    return all(lessThan(abs(color.rgb - compareColor.rgb), vec3(0.004)));
}

int detectMarker(vec2 uv) {
    vec2 cornerUV = uv;
    vec4 c = texture(Sampler0, cornerUV);

    if (isMarker(c, vec4(1.0, 1.0, 1.0, 1.0) / 255.0)) return 1;
    else if (isMarker(c, vec4(3.0, 3.0, 3.0, 1.0) / 255.0)) return 2;

    return 0;
}

mat3 rotateX(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat3(
        1.0, 0.0, 0.0,
        0.0,  c,  -s,
        0.0,  s,   c
    );
}

mat3 rotateZ(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat3(
         c, -s, 0.0,
         s,  c, 0.0,
        0.0, 0.0, 1.0
    );
}

mat3 rotateY(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat3(
         c, 0.0,  s,
        0.0, 1.0, 0.0,
        -s, 0.0,  c
    );
}

void main() {
    texCoord0 = UV0;
    atlasSize = vec2(textureSize(Sampler0, 0));

    float size = 1.0;
    float tilt = 0.0;
    float SunOffset = 0.0;

    switch (detectMarker(UV0))
    {
        // Sun
        case 1: {
            isCelestial = 1;
            frames = 8.0;
            textureHeight = 512.0;

            switch (getDimension(2040.0026))
            {
                case 1: textureShift = 1.0; size = 0.3;  break; // faewild
                case 2: textureShift = 2.0; size = 1.50; break; // panacea
                case 3: textureShift = 3.0; size = 0.75; break; // omnidrome
                case 4: textureShift = 4.0; size = 0.50; break; // sanctum
                case 5: textureShift = 5.0; size = 1.0;  break; // varskspace
                case 6: textureShift = 6.0; size = 1.0;  break; // glacium
                case 7: textureShift = 7.0; size = 2.0;  break; // brine
                default: textureShift = 0.0; size = 1.0;
            }
            break;
        }

        // Moon
        case 2: {
            isCelestial = 1;
            frames = 6.0;
            textureHeight = 193.0;

            switch (getDimension(2040.0026))
            {
                case 1: textureShift = 0.0; size = 0.5;  break; // faewild
                case 2: textureShift = 5.0; size = 1.50; break; // panacea
                case 3: textureShift = 3.0; size = 1.0;  break; // omnidrome
                case 4: textureShift = 1.0; size = 5.0;  break; // sanctum
                case 5: textureShift = 3.0; size = 1.0;  break; // varskspace
                case 6: textureShift = 4.0; size = 5.0;  break; // glacium
                case 7: textureShift = 2.0; size = 0.02; break; // brine
                default: textureShift = 0.0; size = 1.0;
            }
            break;
        }

        default: {
            isCelestial = 0;
            frames = 0.0;
            textureShift = 0.0;
            textureHeight = 0.0;
        }
    }

    vec3 rotated = rotateY(radians(tilt)) * Position;
    vec4 pos = vec4(rotated, size);
    pos.x += SunOffset;

    gl_Position = ProjMat * ModelViewMat * pos;
}