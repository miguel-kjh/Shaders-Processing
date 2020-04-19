#ifdef GL_ES
precision mediump float;
#endif

#define RADIUS    0.0005
#define THICKNESS 0.001
#define LEN       128

uniform vec2  u_resolution;
uniform vec2  u_mouse;
uniform float u_time;
uniform float u_vecX[LEN];
uniform float u_vecY[LEN];
uniform int   u_size;
uniform bool  u_paintPoint;
uniform int   u_typeSpeed;

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);


float rand(float n){
    return fract(sin(n) * 43758.5453123);
}

float noise(float p){
	float fl = floor(p);
    float fc = fract(p);
	return mix(rand(fl), rand(fl + 1.0), fc);
}

vec2 getSpeed(float time){
    if(u_typeSpeed == 2){
        float v = sin(u_time)/2;
        return vec2(v);
    }
    if(u_typeSpeed == 3){
        float vx = sin(u_time)/2 * noise(u_time);
        float vy = cos(u_time)/2 * noise(u_time);
        return vec2(vx,vy);
    }
    if(u_typeSpeed == 4){
        float vx = sin(u_time)/2;
        float vy = cos(u_time)/2;
        return vec2(vx,vy);
    }
    return vec2(0.0);
}

vec2 calculePosition(vec2 pos, vec2 speed){
    vec2 result = pos + speed;
    if(result.x < 0.0){
        result.x = 0.0;
    }
    if(result.x > 0.99){
        result.x = 0.99;
    }
    if(result.y < 0.0){
        result.y = 0.0;
    }
    if(result.y > 0.99){
        result.y = 0.99;
    }
    return result;
}

float circle(in vec2 _st, in float _radius){
    vec2 dist = _st;
	return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(dist,dist)*4.0);
}

void drawCircle(vec2 pos){
    vec3 color    = vec3(circle(pos,RADIUS));
    gl_FragColor += vec4( color, 1.0 ) * vec4(colorB,1.0);
} 


float drawLine(vec2 p1, vec2 p2, vec2 st) {

  float a = abs(distance(p1, st));
  float b = abs(distance(p2, st));
  float c = abs(distance(p1, p2));

  if ( a >= c || b >=  c ) return 0.0;

  float p = (a + b + c) * 0.5;

  float h = 2. / c * sqrt( p * ( p - a) * ( p - b) * ( p - c));

  return mix(1.0, 0.0, smoothstep(0.5 * THICKNESS, 1.5 * THICKNESS, h));
}

void drawGraph(vec2 st){
    for(int index = 0; index < u_size; index++){
        vec2 speed = getSpeed(u_time);
        drawCircle(st - (calculePosition(vec2(u_vecX[index], u_vecY[index]), speed)));
        for(int secondIndex = index + 1; secondIndex < u_size; secondIndex++){
            gl_FragColor += drawLine(
                calculePosition(vec2(u_vecX[index],       u_vecY[index]),       speed),
                calculePosition(vec2(u_vecX[secondIndex], u_vecY[secondIndex]), speed),
                st) * vec4(colorA,1.0);
        }
    }

}

void paintLastPoint(vec2 st){
    vec2 speed = getSpeed(u_time);
    vec2 mouse = u_mouse/u_resolution;
    drawCircle(st - mouse);

    for(int index = 0; index < u_size; index++){
        gl_FragColor += drawLine(
            mouse,
            calculePosition(vec2(u_vecX[index], u_vecY[index]), speed),
            st) * vec4(colorA,1.0);
    }
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;
    drawGraph(st);
    if(u_paintPoint)paintLastPoint(st);
}