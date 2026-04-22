bool inRange(vec3 value, vec3 minVal, vec3 maxVal) {
    return all(greaterThanEqual(value, minVal)) &&
           all(lessThanEqual(value, maxVal));
}

int getDimension(vec3 biomeFog, float cloudFogDistance) {
    vec3 fog = biomeFog * 255.0;

    // ---- Faewild ----
    if (inRange(fog,
                vec3(0.0, 0.0, 29.0),
                vec3(0.0, 0.0, 38.0)))
        return 1;

    // ---- Varskspace ----
    if (inRange(fog,
                vec3(9.0, 7.0, 20.0),
                vec3(10.0, 7.0, 22.0)))
        return 5;
    // ---- Varskspace NV ----
    if (inRange(fog,
                vec3(109.0, 81.0, 254.0),
                vec3(118.0, 93.0, 255.0)))
        return 5;

    // ---- Omnidrome ----
    if (inRange(fog,
                vec3(0.0, 152.0, 86.0),
                vec3(0.0, 255.0, 144.0)))
        return 3;
    // ---- Sanctum ----
    if (inRange(fog,
                vec3(125.0, 52.0, 47.0),
                vec3(152.0, 53.0, 48.0)))
        return 4;
    // ---- Glacium ----
    if (inRange(fog,
                vec3(61.0, 71.0, 92.0),
                vec3(66.0, 76.0, 99.0)))
        return 6;
    // ---- Glacium NV ----
    //if (inRange(fog,vec3(31.0, 40.0, 60.0),vec3(170.0, 196.0, 255.0))) return 6;
    // ---- Panacea ----
    if (inRange(fog,
                vec3(159.0, 216.0, 171.0),
                vec3(174.0, 224.0, 185.0)))
        return 2;
    // ---- Panacea NV ----
    if (inRange(fog,
                vec3(159.0, 216.0, 171.0),
                vec3(200.0, 255.0, 210.0)))
        return 2;
    // ---- Brine ----
    if (inRange(fog,
                vec3(190.0, 240.0, 225.0),
                vec3(193.0, 243.0, 255.0)))
        return 7;

    return 0;
}