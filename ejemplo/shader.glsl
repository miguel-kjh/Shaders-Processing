#ifdef GL_ES
precision mediump float;
#endif

#define RADIUS    0.0005
#define Thickness 0.003
#define LEN       4

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform float u_vecX[LEN];
uniform float u_vecY[LEN];
uniform bool u_paintPoint;

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

vec2 calculePosition(vec2 pos, float speed){
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

  return mix(1.0, 0.0, smoothstep(0.5 * Thickness, 1.5 * Thickness, h));
}

void drawGraph(vec2 st){
    for(int index = 0; index < LEN; index++){
        float speed = sin(u_time);
        drawCircle(st - (calculePosition(vec2(u_vecX[index], u_vecY[index]), speed)));
        for(int secondIndex = index + 1; secondIndex < LEN; secondIndex++){
            gl_FragColor += drawLine(
                calculePosition(vec2(u_vecX[index],       u_vecY[index]),       speed),
                calculePosition(vec2(u_vecX[secondIndex], u_vecY[secondIndex]), speed),
                st) * vec4(colorA,1.0);
        }
    }

}

void paintLastPoint(vec2 st){
    float speed = sin(u_time);
    vec2 mouse = u_mouse/u_resolution;
    drawCircle(st - mouse);

    for(int index = 0; index < LEN; index++){
        gl_FragColor += drawLine(
            mouse,
            calculePosition(vec2(u_vecX[index], u_vecY[index]), speed),
            st) * vec4(colorA,1.0);
    }
}

void main() {
    //gl_FragColor += vec4(colorA,1.0);
    vec2 st = gl_FragCoord.xy/u_resolution;
    drawGraph(st);
    if(u_paintPoint)paintLastPoint(st);
}