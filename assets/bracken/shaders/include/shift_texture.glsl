vec2 shiftTextureUV(vec2 uv, float texHeight, float frameCount, float shiftAmount) 
{
    float realHeight = texHeight + 1.0; 
    vec2 origin = vec2(0.0, (floor(uv.y / (realHeight)) * realHeight));
    float shiftBy = shiftAmount * realHeight / frameCount;
    uv -= origin;
    uv *= vec2(1.0, 1.0 / frameCount);
    uv += vec2(0.0, shiftBy);
    uv += origin;
    return uv;
}