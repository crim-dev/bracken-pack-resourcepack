int getDimension(vec3 biomeFog, float cloudFogDistance) {
    float faewildCFD        = 2040.0031;
    float panaceaCFD        = 512.0032;
    float omnidromeCFD      = 2040.0033;
    float sanctumCFD        = 128.0034;
    float varskspaceCFD     = 2040.0035;
    float glaciumCFD        = 2040.0036;
    float brineCFD          = 2040.0037;

    if      (approxEquals(cloudFogDistance, faewildCFD, 0.00001)) return 1; // faewild 
    else if (approxEquals(cloudFogDistance, panaceaCFD, 0.00001))      return 2; // panacea
    else if (approxEquals(cloudFogDistance, omnidromeCFD, 0.00001))     return 3; // omnidrome
    else if (approxEquals(cloudFogDistance, sanctumCFD, 0.00001))    return 4; // sanctum
    else if (approxEquals(cloudFogDistance, varskspaceCFD, 0.00001))   return 5; // varskspace
    else if (approxEquals(cloudFogDistance, glaciumCFD, 0.00001))     return 6; // glacium
    else if (approxEquals(cloudFogDistance, brineCFD, 0.00001))     return 7; // brine
    return 0;
}
