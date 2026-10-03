#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:dynamictransforms.glsl>

#include <bracken:shift_texture.glsl>

layout(location = 0) in vec2 texCoord0;
layout(location = 1) flat in int isCelestial;
layout(location = 2) flat in float frames;
layout(location = 3) flat in float textureShift;
layout(location = 4) flat in float textureHeight;
layout(location = 5) flat in vec2 atlasSize;

uniform sampler2D Sampler0;

layout(location = 0) out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);

    if (isCelestial == 1)
    {
        vec2 uv = texCoord0 * atlasSize;

        if (texCoord0.x < 0.2)
        {
            uv = shiftTextureUV_special(
                uv,
                textureHeight,
                frames,
                textureShift
            );
        }
        else
        {
            uv = shiftTextureUV(
                uv,
                textureHeight,
                frames,
                textureShift
            );
        }

        color = texture(Sampler0, uv / atlasSize);
    }

    fragColor = color * ColorModulator;
}