// Assignment Advanced Computer Graphics perlin* noise map
// Code based on https://www.youtube.com/watch?v=zXsWftRdsvU
// And help from this playlist https://www.youtube.com/playlist?list=PLGmrMu-IwbgsVjE7SAtFaWyhZXyBjJNnO
    
    
int octaves = 8;
    
    // Noise generator
float Noise21(vec2 p){
    // edit these numbers for different noise
    return fract(sin(p.x*650.+p.y*8016.)*5841.);
}

    // Convert normal 0-255 RGB to 0-1 RGB 
vec3 RGB33(float r, float g, float b){
    return vec3(r,g,b)/255.;
}

    // Smooth out the noise function
float SmoothNoise21(vec2 uv){
    // Make a grid
    vec2 lv = fract(uv);
    vec2 id = floor(uv);
    
    // SmoothStep, remove edges
    lv = lv*lv*(3.-2.*lv);
    
    // Noise value corner of each box of the grid
    float bl = Noise21(id);
    float br = Noise21(id+vec2(1.,0.));
    float b = mix(bl, br, lv.x);
   
    float tl = Noise21(id+vec2(0.0,1.0));
    float tr = Noise21(id+vec2(1.0,1.0));
    float t = mix(tl, tr, lv.x);
    
    return mix(b,t, lv.y);
    
}

    // Set color of the landscape
vec3 Color33(vec3 col){
    // Change the value after < to increase/decrease the amount of the color in the if statement
    // Change the value in the vec3 to change the color of that area
    
    // Water
    if(col.x < 0.35){
    col = vec3(RGB33(35.,137.,218.));;
    }
    // Sand
    else if(col.x < 0.40){
    col = vec3(RGB33(194., 178., 128.));
    }
    // Grass
    else if(col.x < 0.70){
    col = vec3(RGB33(0.,154.,23.));
    }
    // Low Mountains
    else if(col.x < 0.85){
    col = vec3(RGB33(139.,69.,19.));
    }
    // Mountains
    else if(col.x < 1.0){
    col =  vec3(RGB33(64.,64.,64.));
    }
    // Mountain peak Snow
    else{
    col =  vec3(1.0,1.0,1.0);
    }
    return col;
}

    // Math for Octaves of the noise
float NoiseOctaves21(vec2 uv, int octaves){
    float c;
    float amp = 1.0;
    float mult = 4.0;
    for(int i = 0; i < octaves; i++){
        c += SmoothNoise21(uv*mult)*amp;
        mult *= 2.0;
        amp /= 2.0;
    }
    // Change the number below the division to create more or less peaks
    return c /= float(octaves)/2.5;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Comment this in to see the scene change between octaves also change global octaves to 0 for the best effect
    //octaves += int(floor(iTime)/3);
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    // Comment this in to see the scene move
    uv += 0.1*iTime;
    
    float c = NoiseOctaves21(uv, octaves);
    vec3 col = vec3(c);
    //col *= vec3(1.0,1.0,1.0);
    col = Color33(col);
    
    // Output to screen
    fragColor = vec4(col,1.0);
}
