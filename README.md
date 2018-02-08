# Metal CIKernel vs GLSL CIKernel comparison

This repo is to host project example for this SO question: https://stackoverflow.com/questions/48683922/metal-vs-glsl-coreimage-performance

The project implements motion blur CIKernel in both metal and glsl, code is based on 510 WWDC session).
You'd need A8+ powered device, e.g. iPhone 6 or newer.

# sample measurements 

    glsl 1 took 189.602017402649ms
    glsl 2 took 179.841995239258ms
    glsl 3 took 176.070928573608ms
    glsl 4 took 172.598958015442ms
    glsl 5 took 181.746006011963ms
    glsl 6 took 187.82901763916ms
    glsl 7 took 347.339987754822ms
    glsl 8 took 174.313068389893ms
    glsl 9 took 163.807034492493ms
    glsl 10 took 168.918967247009ms
    metal 1 took 302.486062049866ms
    metal 2 took 225.558996200562ms
    metal 3 took 201.786994934082ms
    metal 4 took 247.116088867188ms
    metal 5 took 326.71594619751ms
    metal 6 took 379.544019699097ms
    metal 7 took 384.636998176575ms
    metal 8 took 394.250988960266ms
    metal 9 took 247.526049613953ms
    metal 10 took 356.340050697327ms
