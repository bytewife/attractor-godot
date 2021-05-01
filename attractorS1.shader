shader_type particles;

// https://docs.godotengine.org/en/stable/tutorials/3d/vertex_animation/controlling_thousands_of_fish.html

// Lorenz Attractor parameters
const float a = 10.0;
const float b = 28.0; // was 28
const float c = 2.6666666667;

// Notes:
// - transform matrix is TRANSFORM[3]
// - the Speed Scale in the inspector determines how quickly the particle 
//   applies the physics in the inspector. Set it to 0 to make it live forever
float rand_from_seed(in uint seed) {
  int k;
  int s = int(seed);
  if (s == 0)
    s = 305420679;
  k = s / 127773;
  s = 16807 * (s - k * 127773) - 2836 * k;
  if (s < 0)
    s += 2147483647;
  seed = uint(s);
  return float(seed % uint(65536)) / 65535.0;
}

uint hash(uint x) {
  x = ((x >> uint(16)) ^ x) * uint(73244475);
  x = ((x >> uint(16)) ^ x) * uint(73244475);
  x = (x >> uint(16)) ^ x;
  return x;
}

void vertex() {
	if (RESTART) {
		uint alt_seed1 = hash(NUMBER + uint(1) + RANDOM_SEED);
		uint alt_seed2 = hash(NUMBER + uint(27) + RANDOM_SEED);
		uint alt_seed3 = hash(NUMBER + uint(43) + RANDOM_SEED);
		uint alt_seed4 = hash(NUMBER + uint(111) + RANDOM_SEED);
		CUSTOM.x = rand_from_seed(alt_seed1);
		vec3 position = vec3(rand_from_seed(alt_seed2) * 2.0 - 1.0,
        rand_from_seed(alt_seed3) * 2.0 - 1.0,
        rand_from_seed(alt_seed4) * 2.0 - 1.0);
		TRANSFORM[3].xyz = position * 20.0;
		
		//float r = random(TRANSFORM[3].xyz);	
		//TRANSFORM[3].x = 1.0 + r;
		//TRANSFORM[3].y = 1.0 * r * r;
		//TRANSFORM[3].z = 1.0 - 2.0 * r;
	}
	else {
		/* Store previous xyz */
		vec4 p = TRANSFORM[3];
		float x = p.x;
		float y = p.y;
		float z = p.z;
		
		// Increments calculation
		float dx = (a * (y - x))   * DELTA;
		float dy = (x * (b-z) - y) * DELTA;
		float dz = (x * y - c * z) * DELTA;
		
		// Add the new increments to the previous position
		vec4 attractorForce = vec4(dx, dy, dz, 1) ; // TODO can we make this a vec3 insetad?
		//TRANSFORM[3] +=attractorForce;
		TRANSFORM[3].x += dx;
		TRANSFORM[3].y += dy;
		TRANSFORM[3].z += dz;
		//TRANSFORM[3].x += 1.0;
		
		//TRANSFORM[3].x += 0.05;
		//float dx = (a * (TRANSFORM[0].x - x))   * timestep;
		//float dy = (x * (b-z) - y) * timestep;
		//float dz = (x*y - c*z)     * timestep;	
	}
}
