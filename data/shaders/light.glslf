#include "third_party/lullaby/data/shaders/fragment_common.glslh"
#include "third_party/lullaby/data/shaders/light.glslh"

STAGE_INPUT mediump vec3 vNormal;
STAGE_INPUT mediump vec3 vVertPos;

LIGHT_DECL_AMBIENT(1);
LIGHT_DECL_DIRECTIONAL(1);
LIGHT_DECL_POINT(1);

uniform vec3 camera_dir;
uniform lowp vec4 color;

void main() {
  // Re-normalize the normal which been could have been scaled or interpolated
  // from the vertex stage.
  vec3 normal = normalize(vNormal);

  // Light calculaltions.
  vec3 light_color = vec3(0.0, 0.0, 0.0);
  LIGHT_CALCULATE_AMBIENTS(light_color)
  LIGHT_CALCULATE_DIRECTIONALS(light_color, vVertPos, normal, camera_dir)
  LIGHT_CALCULATE_POINTS(light_color, vVertPos, normal, camera_dir)

  gl_FragColor = vec4(light_color * color.rgb, color.a);
}
