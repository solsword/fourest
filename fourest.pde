// vim: syn=java

import java.util.Collections;

int INITIAL_SETTLE_TIME = 1000;

int NEARBY_RANGE = 23;

int POWER_LOOP_LENGTH = 90;
int BUBBLE_LOOP_LENGTH = 120;

//double EVAPORATION_THRESHOLD = 0.001;
double EVAPORATION_THRESHOLD = 0.00001;
double LIQUID_DISPLAY_THRESHOLD = 0.015;

float TOOL_USE_DIST = 2.5;

float AI_CLOCK_MAX = 3600.0;
float AI_SLOW_UPDATE_DURATION = 0.1;
float AI_BEHAVIOR_DURATION = 10.0;
float AI_PAUSE_FREQUENCY = 0.01;
float AI_PAUSE_DURATION = 0.2;

int N_REGION_EXP_TRIES = 15;

float VEL_DRIFT_THRESHOLD = 0.05;

float SUPPORT_FUDGE_FACTOR = 0.005;
float COLLISION_OFFSET = 0.0001;

float JUMP_IMPULSE = 30.0;
float WADE_JUMP_IMPULSE = 25.0;
float JUMP_COOLDOWN = 0.2;

float DEFAULT_MAX_SPEED = 15.0;

float WADE_ACCEL = 0.4;
float SWIM_ACCEL = 0.4;
float CLIMB_ACCEL = 0.8;
float WALK_ACCEL = 0.6;
float JUMP_ACCEL = 0.2;

float WADE_SPEED = 0.5;
float SWIM_SPEED = 0.8;
float CLIMB_SPEED = 0.7;

float GRAVITY = 180.0;
float SWIM_GRAVITY = -50.0;
float WADE_GRAVITY = -220.0;

float FLOAT_SPEED = -5.0;

float DEFAULT_SIZE = 0.3;
float DEFAULT_TORCH_RADIUS = 8.5;

int WINDOW_WIDTH, WINDOW_HEIGHT;

int FRAME_RATE = 60;
int UPDATE_RATE = 8;

int FRAME_COUNT = 0;
int LAST_TIME = 0;
int TIME_ELAPSED = 0;
float REAL_FRAMERATE = 0;

boolean PAUSED = false;

//float TEXT_SIZE = 12;
float TEXT_SIZE = 18;

//int TILE_SIZE = 6;
int TILE_SIZE = 16;
//int TILE_SIZE = 128;

color TILES[];

//int BOARD_WIDTH = 128;
//int BOARD_HEIGHT = 128;
int BOARD_WIDTH = 52;
int BOARD_HEIGHT = 52;
//int BOARD_WIDTH = 8;
//int BOARD_HEIGHT = 8;

int REGION_WIDTH = 13;
int REGION_HEIGHT = 13;

int H_REGIONS = 4;
int V_REGIONS = 4;

ArrayList<Level> ALL_LEVELS;
int CURRENT_LEVEL = -1;

Agent LOST;

float JUMP_PATH_PENALTY = 0.1;
float FALL_PATH_PENALTY = 0.2;
float MINE_PATH_PENALTY = 20.0;

float PATH_MEDIATION = 0.0;

double MAX_COMPRESSED_FLOW = 1.1;
double FLOW_BALANCING_SPEED = 0.99;

int MAX_VINE_LENGTH = 9;
int DRY_DIRT_PENALTY = 4;

int N_TILES = 9;

int TILE_EMPTY = 0;
int TILE_WATER = 1;
int TILE_VINES = 2;
int TILE_DRY_DIRT = 3;
int TILE_WET_DIRT = 4;
int TILE_STONE = 5;
int TILE_FIRE = 6;
int TILE_MAGIC = 7;
int TILE_WALL = 8;
int TILE_ANY = 9;

int MOV_BLOCKED = 0;
int MOV_NORMAL = 1;
int MOV_WADE = 2;
int MOV_SWIM = 3;
int MOV_CLIMB = 4;
int MOV_MINEABLE = 5;

int AI_NONE = 0;
int AI_FOLLOW_CURSOR = 1;
int AI_EXPLORE_TILES = 2;
int AI_EXPLORE_REGIONS = 3;
int AI_COLLECT_POWERUPS = 4;
int AI_COOPERATE = 5;
int AI_PLAYER_CONTROLLED = 6;

int EMOTE_CONFUSED = 0;
int EMOTE_CELEBRATE = 1;
int EMOTE_EXPLORE = 2;
int EMOTE_WANDER = 3;
int EMOTE_FOLLOW = 4;
int EMOTE_CONTROLLED = 5;
int EMOTE_GET_FINS = 6;
int EMOTE_GET_ROPE = 7;
int EMOTE_GET_BUCKET = 8;
int EMOTE_GET_SATCHEL = 9;
int EMOTE_GET_SHOVEL = 10;
int EMOTE_GET_PICK = 11;
int EMOTE_GET_TORCH = 12;
int EMOTE_GET_KEY = 13;
int EMOTE_SEEK_ENTRANCE = 14;
int EMOTE_SEEK_EXIT = 15;
int EMOTE_TILE_WATER = 16;
int EMOTE_TILE_DIRT = 17;
int EMOTE_TILE_VINE = 18;
int EMOTE_TILE_STONE = 19;
int EMOTE_TILE_WALL = 20;

int TASK_NONE = 0;
int TASK_DECIDE_NEXT_TASK = 1;
int TASK_GET_WATER = 2;
int TASK_GET_SEED = 3;
int TASK_DIG_DIRT = 4;
int TASK_DIG_STONE = 5;
int TASK_DUMP_SEED = 6;
int TASK_DUMP_WATER = 7;
int TASK_DUMP_DIRT = 8;
int TASK_PLANT_SEED = 9;
int TASK_WATER_VINES = 10;
int TASK_PLACE_DIRT = 11;
int TASK_SEEK_POWER = 12;
int TASK_SEEK_ROPE = 13;
int TASK_SEEK_FINS = 14;
int TASK_SEEK_SATCHEL = 15;
int TASK_SEEK_BUCKET = 16;
int TASK_SEEK_SHOVEL = 17;
int TASK_SEEK_PICK = 18;
int TASK_SEEK_TORCH = 19;
int TASK_SEEK_KEY = 20;
int TASK_SEEK_ENTRANCE = 21;
int TASK_SEEK_EXIT = 22;
int TASK_ASCEND = 23;
int TASK_DESCEND = 24;
int TASK_EXPLORE = 25;
int TASK_WANDER = 26;

float TASK_PRIORITY_GET_POWERUP = 2.0;
float TASK_PRIORITY_EXPLORE = 2.0;
float TASK_PRIORITY_GET_KEY = 1.0;
float TASK_PRIORITY_LEAVE_LEVEL = 0.15;
float TASK_PRIORITY_GET_WATER = 0.05;
float TASK_PRIORITY_GET_SEED = 0.05;
float TASK_PRIORITY_GET_DIRT = 0.05;
float TASK_PRIORITY_WANDER = 0.05;

int POWER_NONE = 0;
int POWER_ROPE = 1;
int POWER_FINS = 2;
int POWER_SATCHEL = 3;
int POWER_BUCKET = 4;
int POWER_SHOVEL = 5;
int POWER_PICK = 6;
int POWER_TORCH = 7;
int POWER_KEY = 8;
int POWER_ENTRANCE = 9;
int POWER_EXIT = 10;
int POWER_INVALID = 11;

int SELECTED_POWER = POWER_INVALID;

PImage POWERUP_SPRITES[];
PImage UNLOCKED_EXIT_SPRITE;

int DIR_UP = 1;
int DIR_RIGHT = 2;
int DIR_DOWN = 4;
int DIR_LEFT = 8;

int PLAYER_STEERING = 0;
boolean PLAYER_DO_JUMP = false;
boolean PLAYER_USE_POWER = false;

boolean DO_CLIMB_UP = false;
boolean DO_CLIMB_DOWN = false;

float sigmoid(float x) {
  // Takes an input between 0 and 1 and smoothes it towards the extremes a bit,
  // using a sigmoid which has a slope of 0 at both endpoints.
  float remapped, result;
  if (x < 0.5) {
    remapped = x * 2;
    result = pow(remapped, 2) * 0.5;
  } else {
    remapped = 1 - (x - 0.5)*2;
    result = (1 - pow(remapped, 2))*0.5 + 0.5;
  }
  return result;
}

float angle_between(float heading_1, float heading_2) {
  float result = heading_2 - heading_1;
  if (result > PI) {
    result = -(2*PI - result);
  } else if (result < -PI) {
    result = 2*PI + result;
  }
  return result;
}

class Index {
  public int x, y;
  public Level level;
  Index(Level l, int x, int y) {
    this.level = l;
    while (x < 0) { x += this.level.width; }
    while (x >= this.level.width) { x -= this.level.width; }
    while (y < 0) { y += this.level.height; }
    while (y >= this.level.height) { y -= this.level.height; }
    this.x = x;
    this.y = y;
  }

  Index(Level l, float x, float y) {
    this.level = l;
    while (x < 0) { x += this.level.width; }
    while (x >= this.level.width) { x -= this.level.width; }
    while (y < 0) { y += this.level.height; }
    while (y >= this.level.height) { y -= this.level.height; }
    this.x = (int) x;
    this.y = (int) y;
  }

  Index(Index o) {
    this.level = o.level;
    this.x = o.x;
    this.y = o.y;
  }

  Index clone() {
    return new Index(this);
  }

  @Override
  public boolean equals(Object o) {
    return (
       o != null
    && o instanceof Index
    && this.level.height == ((Index) o).level.height
    && this.level.width == ((Index) o).level.width
    && this.x == ((Index) o).x
    && this.y == ((Index) o).y
    );
  }

  @Override
  public int hashCode() {
    return (((this.x + 8829) * 7871 + this.y) + 6743) * 1131;
  }

  Index neighbor(int direction) {
    if (direction == DIR_UP) {
      return new Index(this.level, this.x, this.y - 1);
    } else if (direction == DIR_RIGHT) {
      return new Index(this.level, this.x + 1, this.y);
    } else if (direction == DIR_DOWN) {
      return new Index(this.level, this.x, this.y + 1);
    } else if (direction == DIR_LEFT) {
      return new Index(this.level, this.x - 1, this.y);
    }
    println("Error: bad direction in Index.neighbor: ", direction);
    return new Index(this.level, 0, 0);
  }

  Index nearest_holo(Index o) {
    float best = this.dist_to(o);
    Index candidate = this;
    Index holo_up = this.clone();
    Index holo_right = this.clone();
    Index holo_down = this.clone();
    Index holo_left = this.clone();
    holo_up.y -= this.level.height;
    holo_right.x += this.level.width;
    holo_down.y += this.level.height;
    holo_left.x -= this.level.width;
    if (holo_up.dist_to(o) < best) {
      candidate = holo_up;
      best = holo_up.dist_to(o);
    }
    if (holo_right.dist_to(o) < best) {
      candidate = holo_right;
      best = holo_right.dist_to(o);
    }
    if (holo_down.dist_to(o) < best) {
      candidate = holo_down;
      best = holo_down.dist_to(o);
    }
    if (holo_left.dist_to(o) < best) {
      candidate = holo_left;
      best = holo_left.dist_to(o);
    }
    return candidate;
  }

  int idx() {
    return this.x + this.level.width * this.y;
  }

  float dist_to(Index o) {
    return sqrt(
      pow((float) (o.x - this.x), 2.0)
    + pow((float) (o.y - this.y), 2.0)
    );
  }

  int match_in(ArrayList<Index> list) {
    int i;
    for (i = 0; i < list.size(); ++i) {
      if (this.equals(list.get(i))) {
        return i;
      }
    }
    return -1;
  }

  boolean same_place(Index o) {
    if (o == null) {
      return false;
    }
    return this.x == o.x && this.y == o.y;
  }

  int same_place_in(ArrayList<PathIndex> list) {
    int i;
    for (i = 0; i < list.size(); ++i) {
      if (this.same_place(list.get(i))) {
        return i;
      }
    }
    return -1;
  }
}

class PathIndex extends Index implements Comparable<PathIndex> {
  public float pathCost;
  public float heurCost;
  public PathIndex from;
  PathIndex(
    Level l,
    int x,
    int y,
    float pathCost,
    float heurCost,
    PathIndex from
  ) {
    super(l, x, y);
    this.pathCost = pathCost;
    this.heurCost = heurCost;
    this.from = from;
  }

  PathIndex(Index i, float pathCost, float heurCost, PathIndex from) {
    super(i);
    this.pathCost = pathCost;
    this.heurCost = heurCost;
    this.from = from;
  }

  PathIndex(PathIndex o) {
    super((Index) o);
    this.pathCost = o.pathCost;
    this.heurCost = o.heurCost;
    this.from = o.from;
  }

  PathIndex clone() {
    return new PathIndex(
      this.level,
      this.x,
      this.y,
      this.pathCost,
      this.heurCost,
      this.from
    );
  }

  @Override
  public int compareTo(PathIndex other) {
    if (this.cost() < other.cost()) {
      return -1;
    } else if (this.cost() > other.cost()) {
      return 1;
    } else {
      return 0;
    }
  }

  float cost() {
    return this.pathCost + this.heurCost;
  }

  ArrayList<PathIndex> path_to_here() {
    ArrayList<PathIndex> result = new ArrayList<PathIndex>();
    PathIndex current = this;
    while (current.from != null) {
      result.add(current);
      current = current.from;
    }
    result.add(current);

    Collections.reverse(result);
    return result;
  }
}

void sort_by_cost(ArrayList<PathIndex> list) {
  Collections.sort(list);
}

class Point {
  public float x, y, z;
  Point(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  Point(Point o) {
    this.x = o.x;
    this.y = o.y;
    this.z = o.z;
  }

  float magnitude() {
    return sqrt(pow(this.x, 2) + pow(this.y, 2) + pow(this.z, 2));
  }

  float mag2() {
    return pow(this.x, 2) + pow(this.y, 2) + pow(this.z, 2);
  }

  float mag_in_terms_of(Point o) {
    float result = this.magnitude() / o.magnitude();
    if (this.dot(o) < 0) { return -result; }
    return result;
  }

  float dist(Point other) {
    return sqrt(
      pow(other.x - this.x, 2)
    + pow(other.y - this.y, 2)
    + pow(other.z - this.z, 2)
    );
  }

  void norm() {
    float m = this.magnitude();
    this.x /= m;
    this.y /= m;
    this.z /= m;
  }

  Point vector_to(Point other) {
    return new Point(other.x - this.x, other.y - this.y, other.z - this.z);
  }

  Point halfway_to(Point other) {
    return new Point(
      this.x + (other.x - this.x)/2.0,
      this.y + (other.y - this.y)/2.0,
      this.z + (other.z - this.z)/2.0
    );
  }

  Point spring_force_from(Point other, float eq, float k) {
    Point v = this.vector_to(other);
    float d = v.magnitude();
    float s = d - eq;
    v.norm();
    v.scale(s * k);
    return v;
  }

  void scale(float s) {
    this.x *= s;
    this.y *= s;
    this.z *= s;
  }

  float dot(Point o) {
    return this.x * o.x + this.y * o.y + this.z * o.z;
  }

  Point cross(Point o) {
    return new Point(
      this.y * o.z - this.z * o.y,
      -(this.x * o.z - this.z * o.x),
      this.x * o.y - this.y * o.x
    );
  }

  void add(Point o) {
    this.x += o.x;
    this.y += o.y;
    this.z += o.z;
  }

  Point project_onto(Point v) {
    Point result = new Point(v.x, v.y, v.z);
    float m = this.dot(v) / v.mag2();
    result.scale(m);
    return result;
  }

  void xy_rotate(float theta) {
    float tx = this.x;
    this.x = cos(theta) * this.x - sin(theta) * this.y;
    this.y = sin(theta) * tx + cos(theta) * this.y;
  }
}

class LineSegment {
  Point from, to;
  LineSegment(Point from, Point to) {
    this.from = from;
    this.to = to;
  }

  boolean xy_same_side(Point a, Point b) {
    Point va, vb, vto;
    Point cr1, cr2;
    va = this.from.vector_to(a);
    vb = this.from.vector_to(b);
    vto = this.from.vector_to(this.to);
    va.z = 0;
    vb.z = 0;
    vto.z = 0;
    cr1 = vto.cross(va);
    cr2 = vto.cross(vb);
    return cr1.z > 0 == cr2.z > 0;
  }

  Point closest_point(Point p) {
    Point proj;
    Point v;
    float m;
    v = this.from.vector_to(this.to);
    proj = this.from.vector_to(p).project_onto(v);
    m = proj.mag_in_terms_of(v);
    if (m < 0) {
      return new Point(this.from);
    } else if (m > 1.0) {
      return new Point(this.to);
    } else {
      proj.add(this.from);
      return proj;
    }
  }
}

class Triangle {
  Point a, b, c;
  Triangle(Point a, Point b, Point c) {
    this.a = a;
    this.b = b;
    this.c = c;
  }

  Triangle flattened() {
    return new Triangle(
      new Point(this.a.x, this.a.y, 0),
      new Point(this.b.x, this.b.y, 0),
      new Point(this.c.x, this.c.y, 0)
    );
  }

  boolean xy_contains(Point p) {
    // Ignores z.
    Point b = xy__barycentric(p);
    return (b.x >= 0 && b.y >= 0 && b.z >= 0);
  }

  Point xy__barycentric(Point p) {
    // Ignores z.
    float det, b1, b2, b3;
    det = (
      (this.b.y - this.c.y) * (this.a.x - this.c.x)
    +
      (this.c.x - this.b.x) * (this.a.y - this.c.y)
    );

    b1 = (
      (this.b.y - this.c.y) * (p.x - this.c.x)
    +
      (this.c.x - this.b.x) * (p.y - this.c.y)
    );
    b1 /= det;

    b2 = (
      (this.c.y - this.a.y) * (p.x - this.c.x)
    +
      (this.a.x - this.c.x) * (p.y - this.c.y)
    );
    b2 /= det;

    b3 = 1 - b1 - b2;
    return new Point(b1, b2, b3);
  }

  Point barycentric__xyz(Point b) {
    return new Point(
      b.x * this.a.x + b.y * this.b.x + b.z * this.c.x,
      b.x * this.a.y + b.y * this.b.y + b.z * this.c.y,
      b.x * this.a.z + b.y * this.b.z + b.z * this.c.z
    );
  }
}

class Powerup implements Comparable<Powerup> {
  public Index pos;
  int type;
  Powerup(Index i, int type) {
    this.pos = i.clone();
    this.type = type;
  }

  Powerup(Powerup o) {
    this.pos = o.pos.clone();
    this.type = o.type;
  }

  Powerup clone() {
    return new Powerup(this);
  }

  @Override
  public int compareTo(Powerup other) {
    if (this.pos.y < other.pos.y) {
      return -1;
    } else if (this.pos.y > other.pos.y) {
      return 1;
    } else {
      return 0;
    }
  }

  void draw(int t) {
    pushMatrix();
    translate(this.pos.x * TILE_SIZE, this.pos.y * TILE_SIZE);
    draw_powerup(this.type, t);
    popMatrix();
  }
}

void prect(color c, float ft) {
  fill(c);
  rect(
    ft * TILE_SIZE / 2.0,
    ft * TILE_SIZE / 2.0,
    (1 - ft) * TILE_SIZE,
    (1 - ft) * TILE_SIZE
  );
}

void draw_powerup(int type, int t) {
  color c;
  float ft = (t % POWER_LOOP_LENGTH) / (float) POWER_LOOP_LENGTH;
  ft = (1 + sin(ft*2*PI)) / 2.0;

  c = color(0, 0, 1);
  if (type == POWER_FINS) {
    //c = TILES[TILE_WATER];
    c = color(0.55, 0.6, 1);
  } else if (type == POWER_ROPE) {
    //c = TILES[TILE_VINES];
    c = color(0.28, 1.0, 0.9);
  } else if (type == POWER_SATCHEL) {
    //c = TILES[TILE_VINES];
    c = color(0.28, 1.0, 0.9);
  } else if (type == POWER_BUCKET) {
    //c = TILES[TILE_WATER];
    c = color(0.55, 0.6, 1);
  } else if (type == POWER_SHOVEL) {
    //c = TILES[TILE_DRY_DIRT];
    c = color(0.12, 0.7, 0.9);
  } else if (type == POWER_PICK) {
    //c = TILES[TILE_STONE];
    c = color(0, 0, 0.9);
  } else if (type == POWER_NONE) {
    c = color(0.0, 0.0, 1.0);
  } else if (type == POWER_TORCH) {
    c = color(0.08, 1, 1);
  } else if (type == POWER_KEY) {
    c = color(0.13, 1, 0.95);
  } else if (type == POWER_ENTRANCE) {
    c = color(0, 0, 1);
  } else if (type == POWER_EXIT) {
    if (LOST.has_powerup(POWER_KEY)) {
      c = color(0.12, 1, 1);
    } else {
      c = color(0, 0, 1);
    }
  }

  strokeWeight(2.0);
  stroke(c);
  noFill();
  rectMode(CENTER);
  rect(
    TILE_SIZE * 0.5,
    TILE_SIZE * 0.5,
    (0.3 + 0.8 * (1 - ft)) * TILE_SIZE,
    (0.3 + 0.8 * (1 - ft)) * TILE_SIZE
  );
  rectMode(CORNER);
  
  // draw the sprite on top:
  if (type == POWER_EXIT && LOST.has_powerup(POWER_KEY)) {
    image(UNLOCKED_EXIT_SPRITE, 0, 0);
  } else {
    image(POWERUP_SPRITES[type], 0, 0);
  }
}

class Agent {
  public float x, y;
  public float vx, vy;
  public float speed, heading;
  public float max_speed;
  public float size;
  public float torch_radius;
  public int AI;
  public float clock;
  public float last_jump;
  public boolean supported_last;
  public float pause_cooldown;
  public ArrayList<PathIndex> current_path;
  public Index current_goal;
  public int current_task;
  public int persistance;
  public PathIndex jump_target;
  public ArrayList<Integer> powerups;
  public boolean inv_water;
  public boolean inv_dirt;
  public boolean inv_seeds;
  public boolean trigger_repath;
  public int current_emote;

  Agent(float x, float y, float max_speed, float size, float vision, int AI) {
    this.x = x;
    this.y = y;
    this.vx = 0;
    this.vy = 0;
    this.speed = 0;
    this.heading = 0;
    this.max_speed = max_speed;
    this.size = size;
    this.torch_radius = vision;
    this.AI = AI;
    this.clock = 0;
    this.last_jump = -1;
    this.supported_last = false;
    this.pause_cooldown = 0;
    this.current_path = null;
    this.current_goal = null;
    this.current_task = TASK_DECIDE_NEXT_TASK;
    this.persistance = 0;
    this.jump_target = null;
    this.clear_powerups();
    this.trigger_repath = false;
    this.current_emote = EMOTE_CONFUSED;
  }

  Agent(Agent o) {
    int i;
    this.x = o.x;
    this.y = o.y;
    this.vx = o.vx;
    this.vy = o.vy;
    this.speed = o.speed;
    this.heading = o.heading;
    this.max_speed = o.max_speed;
    this.size = o.size;
    this.torch_radius = o.torch_radius;
    this.AI = o.AI;
    this.clock = o.clock;
    this.last_jump = o.last_jump;
    this.supported_last = o.supported_last;
    this.pause_cooldown = o.pause_cooldown;
    for (i = 0; i < o.current_path.size(); ++i) {
      this.current_path.add(o.current_path.get(i));
    }
    this.current_goal = o.current_goal;
    this.current_task = o.current_task;
    this.persistance = o.persistance;
    this.jump_target = o.jump_target;
    for (i = 0; i < o.powerups.size(); ++i) {
      this.powerups.add(o.powerups.get(i));
    }
    this.trigger_repath = o.trigger_repath;
    this.current_emote = o.current_emote;
  }

  Agent clone() {
    return new Agent(this);
  }

  Index center() {
    return new Index(current_level(), (int) this.x, (int) this.y);
  }

  boolean can_use(int power) {
    if (
       power == POWER_BUCKET
    || power == POWER_SHOVEL
    || power == POWER_SATCHEL
    || power == POWER_PICK
    ) {
      return this.has_powerup(power);
    }
    return false;
  }

  boolean has_powerup(int power) {
    return this.powerups.contains(power);
  }

  void add_powerup(int power) {
    this.powerups.add(power);
  }

  void remove_powerup(int power) {
    int i = this.powerups.indexOf(power);
    while (i != -1) {
      this.powerups.remove((int) i); // by index
      i = this.powerups.indexOf(power);
    }
  }

  void clear_powerups() {
    this.powerups = new ArrayList<Integer>();
    this.powerups.add(POWER_ENTRANCE);
    this.powerups.add(POWER_EXIT);
  }

  void clear_inventory() {
    this.inv_seeds = false;
    this.inv_water = false;
    this.inv_dirt = false;
  }

  float dist_to_center(Index i) {
    Index h = i.nearest_holo(this.center());
    return sqrt(
      pow((float) (h.x + 0.5 - this.x), 2.0)
    + pow((float) (h.y + 0.5 - this.y), 2.0)
    );
  }

  float dist_from_edge(int direction) {
    Index c = this.center();
    if (direction == DIR_UP) {
      return this.y - c.y;
    } else if (direction == DIR_DOWN) {
      return (c.y + 1) - this.y;
    } else if (direction == DIR_RIGHT) {
      return (c.x + 1) - this.x;
    } else if (direction == DIR_LEFT) {
      return this.x - c.x;
    }
    println("ERROR: invalid direction in Agent.dist_from_edge\n");
    return -1;
  }

  int movement_on(int tile) {
    if (
       tile == TILE_EMPTY
    || tile == TILE_FIRE
    || tile == TILE_MAGIC
    ) {
      return MOV_NORMAL;
    } else if (tile == TILE_WATER) {
      if (this.has_powerup(POWER_FINS)) {
        return MOV_SWIM;
      } else {
        return MOV_WADE;
      }
    } else if (tile == TILE_VINES) {
      if (this.has_powerup(POWER_ROPE)) {
        return MOV_CLIMB;
      } else {
        return MOV_NORMAL;
      }
    } else if (tile == TILE_STONE) {
      if (this.has_powerup(POWER_PICK)) {
        return MOV_MINEABLE;
      } else {
        return MOV_BLOCKED;
      }
    } else if (tile == TILE_DRY_DIRT || tile == TILE_WET_DIRT) {
      if (this.has_powerup(POWER_SHOVEL)) {
        return MOV_MINEABLE;
      } else {
        return MOV_BLOCKED;
      }
    } else if (tile == TILE_WALL) {
      return MOV_BLOCKED;
    }
    println("ERROR: Invalid tile in Agent.movement_on\n");
    return MOV_BLOCKED;
  }

  int movement_mode(int direction) {
    Index c = this.center();
    if (this.dist_from_edge(direction) <= this.size) {
      return this.movement_on(
        current_level().tiles[c.neighbor(direction).idx()]
      );
    } else {
      return this.movement_on(current_level().tiles[c.idx()]);
    }
  }

  boolean supported(int direction) {
    Index c = this.center();
    int mov;
    boolean result = false;
    if (this.dist_from_edge(direction) <= this.size + SUPPORT_FUDGE_FACTOR) {
      mov = this.movement_on(
        current_level().tiles[c.neighbor(direction).idx()]
      );
      if (
         mov == MOV_BLOCKED
      || mov == MOV_MINEABLE
      || mov == MOV_CLIMB
      || mov == MOV_SWIM
      || mov == MOV_WADE
      ) {
        result = true;
      }
    }
    mov = this.movement_on(current_level().tiles[c.idx()]);
    if (
       mov == MOV_SWIM
    || mov == MOV_WADE
    || mov == MOV_CLIMB
    ) {
      result = true;
    }
    return result;
  }

  void bfs_consider(
    Index consider,
    ArrayList<PathIndex> open,
    ArrayList<PathIndex> closed,
    PathIndex parent,
    int cost
  ) {
    PathIndex competitor;
    if (
       consider.same_place_in(open) == -1
    && consider.same_place_in(closed) == -1
    ) {
      open.add(
        new PathIndex(
          consider,
          parent.pathCost + cost,
          0,
          parent
        )
      );
    } else if (consider.same_place_in(open) != -1) {
      competitor = open.get(consider.same_place_in(open));
      if (competitor.pathCost > parent.pathCost + cost) {
        competitor.pathCost = parent.pathCost + cost;
        competitor.from = parent;
      }
    }
  }

  Index find_reachable_darkness(int max_range) {
    ArrayList<PathIndex> open = new ArrayList<PathIndex>();
    ArrayList<PathIndex> closed = new ArrayList<PathIndex>();
    open.add(
      new PathIndex(
        this.center(),
        0,
        0,
        null
      )
    );
    PathIndex here;
    while (open.size() > 0) {
      here = open.remove(0);
      if (
         current_level().explored[here.idx()] < 1
      && this.path_to(here) != null
      ) {
        // we found some!
        return here;
      }
      // If we can go through a space and it's still in-range, add is neighbors:
      if (
         this.movement_on(current_level().tiles[here.idx()]) != MOV_BLOCKED
      && here.pathCost < max_range
      ) {
        bfs_consider(here.neighbor(DIR_UP), open, closed, here, 1);
        bfs_consider(here.neighbor(DIR_RIGHT), open, closed, here, 1);
        bfs_consider(here.neighbor(DIR_DOWN), open, closed, here, 1);
        bfs_consider(here.neighbor(DIR_LEFT), open, closed, here, 1);
      }

      // close this node:
      closed.add(here);
    }
    return null;
  }

  Index find_nearby(int tile, int adj, int min_range, int max_range) {
    ArrayList<PathIndex> open = new ArrayList<PathIndex>();
    ArrayList<PathIndex> closed = new ArrayList<PathIndex>();
    open.add(
      new PathIndex(
        this.center(),
        0,
        0,
        null
      )
    );
    PathIndex here;
    while (open.size() > 0) {
      here = open.remove(0);
      if (
         current_level().tiles[here.idx()] == tile
      && current_level().any_adjacent(here, adj)
      && here.pathCost >= min_range
      ) {
        // we found one!
        return here;
      }
      // If we can go through a space and it's still in-range, add is neighbors:
      if (
         this.movement_on(current_level().tiles[here.idx()]) != MOV_BLOCKED
      && here.pathCost < max_range
      ) {
        bfs_consider(here.neighbor(DIR_UP), open, closed, here, 1);
        bfs_consider(here.neighbor(DIR_RIGHT), open, closed, here, 1);
        bfs_consider(here.neighbor(DIR_DOWN), open, closed, here, 1);
        bfs_consider(here.neighbor(DIR_LEFT), open, closed, here, 1);
      }

      // close this node:
      closed.add(here);
    }
    return null;
  }

  ArrayList<PathIndex> path_to(Index destination) {
    ArrayList<PathIndex> open = new ArrayList<PathIndex>();
    ArrayList<PathIndex> closed = new ArrayList<PathIndex>();
    PathIndex next;
    if (destination == null) { return null; }
    open.add(
      new PathIndex(
        this.center(),
        0.0,
        this.center().dist_to(destination.nearest_holo(this.center())),
        null
      )
    );
    while (open.size() > 0) {
      next = open.remove(0);
      if (next.same_place(destination)) {
        return next.path_to_here();
      }
      this.consider_options(open, closed, next, destination);
      closed.add(next);
      sort_by_cost(open);
    }
    return null;
  }

  void add_candidate(
    ArrayList<PathIndex> list,
    Index candidate,
    Index dest,
    PathIndex parent,
    float pcost
  ) {
    list.add(
      new PathIndex(
        candidate,
        parent.pathCost + pcost,
        candidate.dist_to(dest.nearest_holo(candidate)),
        parent
      )
    );
  }

  void consider_options(
    ArrayList<PathIndex> open,
    ArrayList<PathIndex> closed,
    PathIndex here,
    Index dest
  ) {
    int i, match;
    int mov = this.movement_on(current_level().tiles[here.idx()]);
    int mov_alt, mov_alt_alt;
    Index cndt;
    PathIndex nbr;
    ArrayList<PathIndex> neighbors = new ArrayList<PathIndex>();
    if (mov == MOV_BLOCKED || current_level().explored[here.idx()] == 0) {
      return;
    } else if (mov == MOV_MINEABLE) {
      mov = this.movement_on(
        current_level().tiles[here.neighbor(DIR_DOWN).idx()]
      );
      if (mov == MOV_BLOCKED || mov == MOV_MINEABLE) {
        add_candidate(
          neighbors,
          here.neighbor(DIR_UP),
          dest,
          here,
          1 + MINE_PATH_PENALTY
        );
        add_candidate(
          neighbors,
          here.neighbor(DIR_RIGHT),
          dest,
          here,
          1 + MINE_PATH_PENALTY
        );
        add_candidate(
          neighbors,
          here.neighbor(DIR_LEFT),
          dest,
          here,
          1 + MINE_PATH_PENALTY
        );
      }
      // In any case we should be able to go down:
      add_candidate(
        neighbors,
        here.neighbor(DIR_DOWN),
        dest,
        here,
        1 + MINE_PATH_PENALTY
      );
    } else if (mov == MOV_WADE) {
      add_candidate(neighbors, here.neighbor(DIR_RIGHT), dest, here, 1);
      add_candidate(neighbors, here.neighbor(DIR_LEFT), dest, here, 1);
      mov = this.movement_on(
        current_level().tiles[here.neighbor(DIR_UP).idx()]
      );
      if (mov == MOV_NORMAL) {
        add_candidate(
          neighbors,
          here.neighbor(DIR_UP),
          dest,
          here,
          1 + JUMP_PATH_PENALTY
        );
        add_candidate(
          neighbors,
          here.neighbor(DIR_UP).neighbor(DIR_RIGHT),
          dest,
          here,
          2 + JUMP_PATH_PENALTY*2
        );
        add_candidate(
          neighbors,
          here.neighbor(DIR_UP).neighbor(DIR_LEFT),
          dest,
          here,
          2 + JUMP_PATH_PENALTY*2
        );
      } else {
        add_candidate(neighbors, here.neighbor(DIR_UP), dest, here, 1);
      }
    } else if (mov == MOV_SWIM || mov == MOV_CLIMB) {
      mov = this.movement_on(
        current_level().tiles[here.neighbor(DIR_DOWN).idx()]
      );
      if (mov != MOV_WADE) {
        add_candidate(neighbors, here.neighbor(DIR_DOWN), dest, here, 1);
      }
      add_candidate(neighbors, here.neighbor(DIR_LEFT), dest, here, 1);
      add_candidate(neighbors, here.neighbor(DIR_RIGHT), dest, here, 1);
      // we can climb/swim upwards even if we can't jump upwards
      add_candidate(neighbors, here.neighbor(DIR_UP), dest, here, 1);
      // Jumping upwards:
      mov = this.movement_on(
        current_level().tiles[here.neighbor(DIR_UP).idx()]
      );
      if (mov == MOV_NORMAL) {
        add_candidate(
          neighbors,
          here.neighbor(DIR_UP).neighbor(DIR_UP),
          dest,
          here,
          2 + JUMP_PATH_PENALTY
        );
        add_candidate(
          neighbors,
          here.neighbor(DIR_UP).neighbor(DIR_RIGHT),
          dest,
          here,
          2 + JUMP_PATH_PENALTY
        );
        add_candidate(
          neighbors,
          here.neighbor(DIR_UP).neighbor(DIR_LEFT),
          dest,
          here,
          2 + JUMP_PATH_PENALTY
        );
        mov = this.movement_on(
          current_level().tiles[here.neighbor(DIR_UP).neighbor(DIR_UP).idx()]
        );
        if (mov == MOV_NORMAL) {
          add_candidate(
            neighbors,
            here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_RIGHT),
            dest,
            here,
            3 + JUMP_PATH_PENALTY
          );
          add_candidate(
            neighbors,
            here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_LEFT),
            dest,
            here,
            3 + JUMP_PATH_PENALTY
          );
        }
      }
    } else if (mov == MOV_NORMAL) {
      mov = this.movement_on(
        current_level().tiles[here.neighbor(DIR_DOWN).idx()]
      );
      if (
         mov == MOV_BLOCKED
      || mov == MOV_MINEABLE
      ) { // supported: we can jump from here
        // (restricted) Jumping possibilities:
        add_candidate(neighbors, here.neighbor(DIR_UP), dest, here, 1);
        mov = this.movement_on(
          current_level().tiles[here.neighbor(DIR_UP).idx()]
        );
        if (mov == MOV_NORMAL) {
          add_candidate(
            neighbors,
            here.neighbor(DIR_UP).neighbor(DIR_UP),
            dest,
            here,
            2 + JUMP_PATH_PENALTY
          );
          add_candidate(
            neighbors,
            here.neighbor(DIR_UP).neighbor(DIR_RIGHT),
            dest,
            here,
            2 + JUMP_PATH_PENALTY
          );
          add_candidate(
            neighbors,
            here.neighbor(DIR_UP).neighbor(DIR_LEFT),
            dest,
            here,
            2 + JUMP_PATH_PENALTY
          );
          mov = this.movement_on(
            current_level().tiles[here.neighbor(DIR_UP).neighbor(DIR_UP).idx()]
          );
          if (mov == MOV_NORMAL) {
            add_candidate(
              neighbors,
              here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_RIGHT),
              dest,
              here,
              3 + JUMP_PATH_PENALTY
            );
            add_candidate(
              neighbors,
              here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_LEFT),
              dest,
              here,
              3 + JUMP_PATH_PENALTY
            );
            mov = this.movement_on(
              current_level().tiles[
                here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_RIGHT)
                  .idx()
              ]
            );
            mov_alt = this.movement_on(
              current_level().tiles[
                here.neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()
              ]
            );
            if (mov == MOV_NORMAL && mov_alt == MOV_NORMAL) {
              add_candidate(
                neighbors,
                here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_RIGHT)
                  .neighbor(DIR_RIGHT),
                dest,
                here,
                4 + JUMP_PATH_PENALTY
              );
            }
            mov = this.movement_on(
              current_level().tiles[
                here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_LEFT).idx()
              ]
            );
            mov_alt = this.movement_on(
              current_level().tiles[
                here.neighbor(DIR_UP).neighbor(DIR_LEFT).idx()
              ]
            );
            if (mov == MOV_NORMAL && mov_alt == MOV_NORMAL) {
              add_candidate(
                neighbors,
                here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_LEFT)
                  .neighbor(DIR_LEFT),
                dest,
                here,
                4 + JUMP_PATH_PENALTY
              );
            }
          }
          mov = this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()
            ]
          );
          mov_alt = this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()
            ]
          );
          mov_alt_alt = this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_UP).idx()
            ]
          );
          if (
             mov == MOV_NORMAL
          && mov_alt == MOV_NORMAL
          && mov_alt_alt == MOV_NORMAL
          ) {
            mov = this.movement_on(
              current_level().tiles[
                here.neighbor(DIR_UP).neighbor(DIR_RIGHT).neighbor(DIR_RIGHT)
                  .idx()
              ]
            );
            mov_alt = this.movement_on(
              current_level().tiles[
                here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_RIGHT)
                  .neighbor(DIR_RIGHT).idx()
              ]
            );
            if (mov == MOV_NORMAL && mov_alt == MOV_NORMAL) {
              add_candidate(
                neighbors,
                here.neighbor(DIR_UP).neighbor(DIR_RIGHT).neighbor(DIR_RIGHT)
                  .neighbor(DIR_RIGHT),
                dest,
                here,
                4 + JUMP_PATH_PENALTY
              );
            }
          }
          mov = this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_UP).neighbor(DIR_LEFT).idx()
            ]
          );
          mov_alt = this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_LEFT).idx()
            ]
          );
          mov_alt_alt = this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_UP).idx()
            ]
          );
          if (
             mov == MOV_NORMAL
          && mov_alt == MOV_NORMAL
          && mov_alt_alt == MOV_NORMAL
          ) {
            mov = this.movement_on(
              current_level().tiles[
                here.neighbor(DIR_UP).neighbor(DIR_LEFT).neighbor(DIR_LEFT)
                  .idx()
              ]
            );
            mov_alt = this.movement_on(
              current_level().tiles[
                here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_LEFT)
                  .neighbor(DIR_LEFT).idx()
              ]
            );
            if (mov == MOV_NORMAL && mov_alt == MOV_NORMAL) {
              add_candidate(
                neighbors,
                here.neighbor(DIR_UP).neighbor(DIR_LEFT).neighbor(DIR_LEFT)
                  .neighbor(DIR_LEFT),
                dest,
                here,
                4 + JUMP_PATH_PENALTY
              );
            }
          }
        }
        // Walking possibilities:
        add_candidate(neighbors, here.neighbor(DIR_RIGHT), dest, here, 1);
        add_candidate(neighbors, here.neighbor(DIR_LEFT), dest, here, 1);
        add_candidate(neighbors, here.neighbor(DIR_DOWN), dest, here, 1);
      } else { // unsupported: we can only fall down...
        if (this.center().same_place(here) && this.vy < 0) {
          // if we're in this space *right now* and mid-jump:
          add_candidate(neighbors, here.neighbor(DIR_LEFT), dest, here, 1);
          add_candidate(neighbors, here.neighbor(DIR_RIGHT), dest, here, 1);
          add_candidate(neighbors, here.neighbor(DIR_UP), dest, here, 1);
        }
        add_candidate(neighbors, here.neighbor(DIR_DOWN), dest, here, 1);
      }
    }

    // Add all detected neighbors to our open list:
    for (i = 0; i < neighbors.size(); ++i) {
      nbr = neighbors.get(i);
      match = nbr.same_place_in(closed);
      if (match != -1) {
        if (nbr.cost() < closed.get(match).cost()) {
          closed.get(match).pathCost = nbr.pathCost; // use the better path
          closed.get(match).heurCost = nbr.heurCost;
          closed.get(match).from = nbr.from;
        } else {
          continue; // skip this one
        }
      }
      match = nbr.same_place_in(open);
      if (match != -1) {
        if (nbr.cost() < open.get(match).cost()) {
          open.get(match).pathCost = nbr.pathCost; // use the better path
          open.get(match).heurCost = nbr.heurCost;
          open.get(match).from = nbr.from;
        } else {
          continue; // skip this one
        }
      }
      open.add(nbr);
    }
  }

  void recenter() {
    float d = this.dist_to_center(this.center());
    this.heading = atan2(
      -(this.center().y + 0.5 - this.y),
      -(this.center().x + 0.5 - this.x)
    );
    if (d > 0.5) {
      d = 0.5;
    }
    this.speed = this.max_speed * (d / 0.5);
  }

  void steer_towards(float x, float y) {
    float dist;
    dist = sqrt(pow(x - this.x, 2) + pow(y - this.y, 2));
    this.heading = atan2(
      -(y - this.y),
      -(x - this.x)
    );
    dist = abs(dist);
    if (dist > 1.0) { dist = 1.0; }
    this.speed = this.max_speed * dist;
  }

  void steer_towards_horiz(float x) {
    float dist;
    dist = x - this.x;
    if (dist > 0) {
      this.heading = PI;
    } else if (dist < 0) {
      this.heading = 0;
    } else {
      this.heading = PI/2.0;
    }
    dist = abs(dist);
    if (dist > 1.0) { dist = 1.0; }
    this.speed = this.max_speed * dist;
  }


  float follow_path_with_pauses() {
    if (this.pause_cooldown == 0) {
      return this.follow_path();
    } else {
      this.recenter();
      return 0;
    }
  }

  // Sets our heading and speed to follow our current path.
  float follow_path() {
    int i;
    int tile, tile_below, tile_next;
    PathIndex next;
    Index h, holo;
    float do_jump = 0.0;
    // Follow our current path or jump target:
    // If we're near a mineable in our path, mine it!
    if (this.current_path != null) {
      for (i = 0; i < 2 && i < this.current_path.size(); ++i) {
        h = this.current_path.get(i);
        tile = current_level().tiles[h.idx()];
        if (this.movement_on(tile) == MOV_MINEABLE) {
          if (tile == TILE_DRY_DIRT || tile == TILE_WET_DIRT) {
            this.dig_dirt(h);
            this.trigger_repath = true;
            break; // only dig once/frame
          } else if (tile == TILE_STONE) {
            this.mine_stone(h);
            this.trigger_repath = true;
            break; // only dig once/frame
          }
        }
      }
    }
    tile = current_level().tiles[this.center().idx()];
    tile_below = current_level().tiles[this.center().neighbor(DIR_DOWN).idx()];
    tile_next = TILE_ANY;

    if (this.current_path == null || this.current_path.size() <= 1) {
      // stop if we have no path or have arrived:
      this.speed = 0;
    } else if (
       this.jump_target != null
    && (
          this.movement_on(tile) == MOV_NORMAL
       || this.movement_on(tile) == MOV_SWIM
       )
    && this.movement_on(tile_below) == MOV_NORMAL
    ) {
      // we're in the middle of a jump: just steer left/right towards our
      // landing spot:
      holo = this.jump_target.nearest_holo(this.center());
      this.steer_towards_horiz(holo.x + 0.5);
      if (
        abs(holo.x + 0.5 - this.x) < 0.3
      ) {
        // done with in-flight steering mode
        this.jump_target = null;
        this.speed = 0;
      }
    } else {
      // otherwise full speed ahead towards the next cell in the path:
      next = this.current_path.get(1);
      holo = next.nearest_holo(this.center());
      if (
         this.movement_on(tile) == MOV_NORMAL
      && this.movement_on(tile_below) == MOV_NORMAL
      ) {
        // we're airborne: no need to accelerate downwards...
        this.steer_towards_horiz(holo.x + 0.5);
      } else { // just go towards the center of the next cell:
        this.steer_towards(holo.x + 0.5, holo.y + 0.5);
      }
      tile = current_level().tiles[this.center().idx()];
      tile_below = current_level().tiles[
        this.center().neighbor(DIR_DOWN).idx()
      ];
      tile_next = current_level().tiles[next.idx()];
      if (
         this.movement_on(tile) == MOV_NORMAL
      && this.movement_on(tile_next) == MOV_WADE
      && this.center().neighbor(DIR_DOWN).equals(next)
      ) {
        // TODO: Get rid of this hack?
        this.steer_towards_horiz(holo.x + 0.5);
      }
      if (
         // A cell that we have to jump to because it's far away:
         (
           abs(holo.x
         - this.center().x)
         + abs(holo.y
         - this.center().y) > 1
         )
         // jump one up on land:
      || (
            this.movement_on(tile) == MOV_NORMAL
         && holo.x == this.center().x
         && holo.y == this.center().y - 1
         )
         // jump out of water/off of vines:
      || (
            (holo.y == this.center().y - 1)
         && this.movement_on(current_level().tiles[next.idx()]) == MOV_NORMAL
         && (
               this.movement_on(tile) == MOV_SWIM
            || this.movement_on(tile) == MOV_CLIMB
            )
         )
      ) {
        // this is a jump...
        this.jump_target = next.clone();
        if (
           this.supported(DIR_DOWN)
        && (
              (
                 abs(this.x - (this.center().x + 0.5)) < 0.1
              && (
                    abs(this.y - (this.center().y + 0.2)) < 0.25
                 || this.movement_on(tile) == MOV_NORMAL
                 || this.movement_on(tile) == MOV_WADE
                 )
              )
           || (
                 (
                    this.movement_on(tile) == MOV_WADE
                 || this.movement_on(tile) == MOV_SWIM
                 || this.movement_on(tile) == MOV_CLIMB
                 )
              && abs(this.y - (this.center().y)) < 0.2
              )
           || (
                 this.movement_on(tile) == MOV_NORMAL
              && (
                    this.movement_on(tile_below) == MOV_WADE
                 || this.movement_on(tile_below) == MOV_SWIM
                 || this.movement_on(tile_below) == MOV_CLIMB
                 )
              && abs(this.y - (this.center().y + 0.9)) < 0.2
              )
           )
        ) {
          this.steer_towards_horiz(holo.x + 0.5);
          if ( // steer up before jumping from water/vines:
             this.movement_on(tile) == MOV_SWIM
          || this.movement_on(tile) == MOV_CLIMB
          ) {
            this.heading = PI/2.0;
          }
          if (
             this.center().y - holo.y == 1
          || abs(this.center().x - holo.x) > 1
          ) {
            this.speed = this.max_speed;
          } else {
            this.speed = this.max_speed / 2.0;
          }
          if (
             this.center().y - holo.y == 1
          && abs(this.center().x - holo.x) == 1
          ) {
            do_jump = 0.8;
          } else {
            do_jump = 1.0;
          }
        } else {
          this.steer_towards(this.center().x + 0.5, this.center().y + 0.2);
        }
      } else {
        // we're not jumping atm:
        this.jump_target = null;
      }
    }
    return do_jump;
  }

  boolean gather_seeds(Index target) {
    if (
       current_level().tiles[target.idx()] == TILE_VINES
    && this.dist_to_center(target) <= TOOL_USE_DIST
    && this.has_powerup(POWER_SATCHEL)
    ) {
      current_level().tiles[target.idx()] = TILE_EMPTY;
      current_level().vine_lengths[target.idx()] = MAX_VINE_LENGTH + 1;
      if (!this.inv_seeds) {
        this.inv_seeds = true;
      }
      return true;
    }
    return false;
  }

  boolean plant_seeds(Index target) {
    if (
       current_level().tiles[target.idx()] == TILE_EMPTY
    && this.dist_to_center(target) <= TOOL_USE_DIST
    && this.has_powerup(POWER_SATCHEL)
    && this.inv_seeds
    ) {
      current_level().tiles[target.idx()] = TILE_VINES;
      this.inv_seeds = false;
      return true;
    }
    return false;
  }

  boolean draw_water(Index target) {
    if (
       current_level().tiles[target.idx()] == TILE_WATER
    && this.dist_to_center(target) <= TOOL_USE_DIST
    && this.has_powerup(POWER_BUCKET)
    && !this.inv_water
    ) {
      current_level().tiles[target.idx()] = TILE_EMPTY;
      current_level().water[target.idx()] = 0;
      this.inv_water = true;
      return true;
    }
    return false;
  }

  boolean pour_water(Index target) {
    if (
       (
          current_level().tiles[target.idx()] == TILE_EMPTY
       || current_level().tiles[target.idx()] == TILE_WATER
       )
    && this.dist_to_center(target) <= TOOL_USE_DIST
    && this.has_powerup(POWER_BUCKET)
    && this.inv_water
    ) {
      current_level().tiles[target.idx()] = TILE_WATER;
      current_level().water[target.idx()] = 2.0;
      this.inv_water = false;
      return true;
    }
    return false;
  }

  boolean dig_dirt(Index target) {
    if (
       (
          current_level().tiles[target.idx()] == TILE_DRY_DIRT
       || current_level().tiles[target.idx()] == TILE_WET_DIRT
       )
    && this.dist_to_center(target) <= TOOL_USE_DIST
    && this.has_powerup(POWER_SHOVEL)
    ) {
      current_level().tiles[target.idx()] = TILE_EMPTY;
      this.inv_dirt = true;
      return true;
    }
    return false;
  }

  boolean place_dirt(Index target) {
    if (
       (
          current_level().tiles[target.idx()] == TILE_EMPTY
       || current_level().tiles[target.idx()] == TILE_WATER
       )
    && this.dist_to_center(target) <= TOOL_USE_DIST
    && this.has_powerup(POWER_SHOVEL)
    && this.inv_dirt
    ) {
      current_level().tiles[target.idx()] = TILE_DRY_DIRT;
      this.inv_dirt = false;
      return true;
    }
    return false;
  }

  boolean mine_stone(Index target) {
    if (
       current_level().tiles[target.idx()] == TILE_STONE
    && this.dist_to_center(target) <= TOOL_USE_DIST
    && this.has_powerup(POWER_PICK)
    ) {
      current_level().tiles[target.idx()] = TILE_EMPTY;
      return true;
    }
    return false;
  }

  boolean climb_up() {
    int i;
    Powerup p;
    for (i = 0; i < current_level().powerups.size(); ++i) {
      p = current_level().powerups.get(i);
      if (p.type == POWER_ENTRANCE && this.center().same_place(p.pos)) {
        DO_CLIMB_UP = true;
        return true;
      }
    }
    return false;
  }

  boolean climb_down() {
    int i;
    Powerup p;
    for (i = 0; i < current_level().powerups.size(); ++i) {
      p = current_level().powerups.get(i);
      if (
         p.type == POWER_EXIT
      && this.center().same_place(p.pos)
      && this.has_powerup(POWER_KEY)
      ) {
        DO_CLIMB_DOWN = true;
        return true;
      }
    }
    return false;
  }


  boolean at_goal() {
    if (this.current_goal == null) { return false; }
    return this.center().same_place(this.current_goal);
  }

  boolean almost_at_goal() {
    if (this.current_goal == null) { return false; }
    return this.dist_to_center(this.current_goal) < 1.5;
  }

  boolean at_end_of_path() {
    return (
       this.current_path != null
    && this.center().same_place(
         this.current_path.get(this.current_path.size() - 1)
       )
    );
  }

  void update_current_path() {
    if (
       this.current_goal != null
    && (
          this.trigger_repath // only if we're triggered or supported
       || this.supported(DIR_DOWN)
       )
    ) {
      // update our path...
      this.current_path = this.path_to(this.current_goal);
    }
    // if we're at the goal, get rid of our current path:
    if (this.at_end_of_path() || this.at_goal()) {
      this.current_path = null;
    }
    this.trigger_repath = false;
  }

  void collect_powerups() {
    int i;
    Powerup p;
    for (i = 0; i < current_level().powerups.size(); ++i) {
      p = current_level().powerups.get(i);
      if (this.center().same_place(p.pos) && !this.has_powerup(p.type)) {
        this.powerups.add(p.type);
        current_level().powerups.remove(p);
        break;
      }
    }
  }

  void explore() {
    Index holo = new Index(current_level(), 0, 0);
    Index c = this.center();
    Index h;
    float d;
    float radius = this.torch_radius;
    if (this.has_powerup(POWER_TORCH)) {
      radius *= 1.5;
    }
    for (
      holo.x = (int) (c.x-radius);
      (float) holo.x < c.x+radius;
      ++holo.x
    ) {
      for (
        holo.y = (int) (c.y-radius);
        (float) holo.y < c.y+radius;
        ++holo.y
      ) {
        h = new Index(current_level(), holo.x, holo.y);
        d = sqrt(pow(holo.x - c.x, 2) + pow(holo.y - c.y, 2));
        if (d <= radius * 0.75) {
          current_level().explored[h.idx()] = 1.0;
        } else if (d <= radius) {
          if (current_level().explored[h.idx()] < 0.5) {
            current_level().explored[h.idx()] = 0.5;
          }
        }
      }
    }
  }

  ArrayList<Powerup> reachable_powerups() {
    int i;
    ArrayList<PathIndex> path;
    ArrayList<Powerup> result = new ArrayList<Powerup>();
    for (i = 0; i < current_level().powerups.size(); ++i) {
      path = this.path_to(current_level().powerups.get(i).pos);
      if (path != null) {
        result.add(current_level().powerups.get(i));
      }
    }
    return result;
  }

  void set_current_task(int task, int persistance) {
    this.current_task = task;
    this.persistance = persistance;
    this.current_goal = null;
    this.current_path = null;
  }

  int pursue_task(int task) {
    ArrayList<Powerup> reachable;
    Powerup p;
    int i;
    float tp_leave = TASK_PRIORITY_LEAVE_LEVEL;
    float tp_power = TASK_PRIORITY_GET_POWERUP;
    float tp_key = TASK_PRIORITY_GET_KEY;
    float tp_explore = TASK_PRIORITY_EXPLORE;
    float tp_dirt = TASK_PRIORITY_GET_DIRT;
    float tp_seed = TASK_PRIORITY_GET_SEED;
    float tp_water = TASK_PRIORITY_GET_WATER;
    float tp_wander = TASK_PRIORITY_WANDER;
    float choice;
    float total_priority = 0;
    boolean key_reachable = false;
    boolean power_reachable = false;
    float nearest_powerup = -1;
    boolean exit_reachable = false;
    float explored_total = 0;
    if (task == TASK_NONE) {
      this.current_emote = EMOTE_CONFUSED;
      return TASK_NONE;
    } else if (task == TASK_DECIDE_NEXT_TASK) {
      this.current_emote = EMOTE_CONFUSED;
      // reset our current goal and path:
      this.current_goal = null;
      this.current_path = null;

      // calculate various task priority factors:
      reachable = this.reachable_powerups();
      for (i = 0; i < reachable.size(); ++i) {
        p = reachable.get(i);
        if (p.type == POWER_KEY) {
          key_reachable = true;
        } else if (p.type == POWER_EXIT) {
          exit_reachable = true;
        } else if (p.type != POWER_ENTRANCE) {
          power_reachable = true;
          if (
             nearest_powerup < 0
           || this.dist_to_center(p.pos) < nearest_powerup
          ) {
            nearest_powerup = this.dist_to_center(p.pos);
          }
        }
      }
      if (!exit_reachable || !this.has_powerup(POWER_KEY)) {
        tp_leave = 0;
      } else {
        tp_leave *= 1 + (0.2 * this.powerups.size());
        if (reachable.size() == 0) {
          tp_leave *= 3.0;
        }
      }
      if (!power_reachable) {
        tp_power = 0;
      } else {
        if (nearest_powerup <= this.torch_radius * 2) {
          tp_power *= 1 + 2 * (1 - nearest_powerup / (this.torch_radius*2));
        }
      }
      if (!key_reachable) {
        tp_key = 0;
      }
      for (i = 0; i < current_level().width * current_level().height; ++i) {
        explored_total += current_level().explored[i];
      }
      tp_explore *= (
        1
      - (
          explored_total
        / (float) (current_level().width * current_level().height)
        )
      );
      if (!this.has_powerup(POWER_SATCHEL) || this.inv_seeds) { tp_seed = 0; }
      if (!this.has_powerup(POWER_BUCKET) || this.inv_water) { tp_water = 0; }
      if (!this.has_powerup(POWER_SHOVEL)) { tp_dirt = 0; }

      // select a task
      total_priority = (
        tp_leave
      + tp_power
      + tp_key
      + tp_explore
      + tp_dirt
      + tp_seed
      + tp_water
      + tp_wander
      );
      choice = random(total_priority);
      if (choice > tp_leave) {
        choice -= tp_leave;
      } else {
        println("Task :: Seek Exit (", tp_leave, ")");
        this.persistance = 2;
        return TASK_DESCEND;
      }
      if (choice > tp_power) {
        choice -= tp_power;
      } else {
        println("Task :: Seek Power (", tp_power, ")");
        this.persistance = 2;
        return TASK_SEEK_POWER;
      }
      if (choice > tp_key) {
        choice -= tp_key;
      } else {
        println("Task :: Seek Key (", tp_key, ")");
        this.persistance = 2;
        return TASK_SEEK_KEY;
      }
      if (choice > tp_explore) {
        choice -= tp_explore;
      } else {
        println("Task :: Explore (", tp_explore, ")");
        this.persistance = 1;
        return TASK_EXPLORE;
      }
      if (choice > tp_dirt) {
        choice -= tp_dirt;
      } else {
        println("Task :: Dig Dirt (", tp_dirt, ")");
        this.persistance = 0;
        return TASK_DIG_DIRT;
      }
      if (choice > tp_seed) {
        choice -= tp_seed;
      } else {
        println("Task :: Get Seed (", tp_seed, ")");
        this.persistance = 0;
        return TASK_GET_SEED;
      }
      if (choice > tp_water) {
        choice -= tp_water;
      } else {
        println("Task :: Get Water (", tp_water, ")");
        this.persistance = 0;
        return TASK_GET_WATER;
      }
      if (choice > tp_wander) {
        choice -= tp_wander;
      } else {
        println("Task :: Wander (", tp_wander, ")");
        this.persistance = 0;
        return TASK_WANDER;
      }
      // fallback:
      this.current_emote = EMOTE_CONFUSED;
      return TASK_DECIDE_NEXT_TASK;
    } else if (task == TASK_GET_WATER) {
      if (this.inv_water) { return TASK_DECIDE_NEXT_TASK; }
      if (this.current_goal == null) {
        this.current_goal = this.find_nearby(
          TILE_WATER,
          TILE_ANY,
          0,
          NEARBY_RANGE
        );
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.almost_at_goal()) {
        if (this.draw_water(this.current_goal)) {
          return TASK_DECIDE_NEXT_TASK;
        } else {
          this.current_goal = null;
        }
      }
      this.current_emote = EMOTE_TILE_WATER;
      return TASK_GET_WATER;
    } else if (task == TASK_GET_SEED) {
      if (this.current_goal == null) {
        this.current_goal = this.find_nearby(
          TILE_VINES,
          TILE_ANY,
          0,
          NEARBY_RANGE
        );
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.almost_at_goal()) {
        if (this.gather_seeds(this.current_goal)) {
          return TASK_DECIDE_NEXT_TASK;
        } else {
          this.current_goal = null;
        }
      }
      this.current_emote = EMOTE_TILE_VINE;
      return TASK_GET_SEED;
    } else if (task == TASK_DIG_DIRT) {
      if (this.current_goal == null) {
        this.current_goal = this.find_nearby(
          TILE_DRY_DIRT,
          TILE_ANY,
          0,
          NEARBY_RANGE
        );
        if (this.current_goal == null) {
          this.current_goal = this.find_nearby(
            TILE_WET_DIRT,
            TILE_ANY,
            0,
            NEARBY_RANGE
          );
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.almost_at_goal()) {
        if (this.dig_dirt(this.current_goal)) {
          return TASK_DECIDE_NEXT_TASK;
        } else {
          this.current_goal = null;
        }
      }
      this.current_emote = EMOTE_TILE_DIRT;
      return TASK_DIG_DIRT;
    } else if (task == TASK_DIG_STONE) {
      if (this.current_goal == null) {
        this.current_goal = this.find_nearby(
          TILE_STONE,
          TILE_ANY,
          0,
          NEARBY_RANGE
        );
      } else if (this.almost_at_goal()) {
        if (this.mine_stone(this.current_goal)) {
          return TASK_DECIDE_NEXT_TASK;
        } else {
          this.current_goal = null;
        }
      }
      this.current_emote = EMOTE_TILE_STONE;
      return TASK_DIG_STONE;
    } else if (task == TASK_DUMP_SEED) {
      if (!this.inv_seeds) { return TASK_DECIDE_NEXT_TASK; }
      if (this.current_goal == null) {
        this.current_goal = this.find_nearby(
          TILE_EMPTY,
          TILE_ANY,
          1,
          NEARBY_RANGE
        );
      } else if (this.almost_at_goal()) {
        if (this.plant_seeds(this.current_goal)) {
          return TASK_DECIDE_NEXT_TASK;
        } else {
          this.current_goal = null;
        }
      }
      this.current_emote = EMOTE_TILE_VINE;
      return TASK_DUMP_SEED;
    } else if (task == TASK_DUMP_WATER) {
      if (!this.inv_water) { return TASK_DECIDE_NEXT_TASK; }
      if (this.current_goal == null) {
        this.current_goal = this.find_nearby(
          TILE_EMPTY,
          TILE_ANY,
          1,
          NEARBY_RANGE
        );
      } else if (this.almost_at_goal()) {
        if (this.pour_water(this.current_goal)) {
          return TASK_DECIDE_NEXT_TASK;
        } else {
          this.current_goal = null;
        }
      }
      this.current_emote = EMOTE_TILE_WATER;
      return TASK_DUMP_WATER;
    } else if (task == TASK_DUMP_DIRT) {
      if (!this.inv_dirt) { return TASK_DECIDE_NEXT_TASK; }
      if (this.current_goal == null) {
        this.current_goal = this.find_nearby(
          TILE_EMPTY,
          TILE_ANY,
          2,
          NEARBY_RANGE
        );
      } else if (this.almost_at_goal()) {
        if (this.place_dirt(this.current_goal)) {
          return TASK_DECIDE_NEXT_TASK;
        } else {
          this.current_goal = null;
        }
      }
      this.current_emote = EMOTE_TILE_DIRT;
      return TASK_DUMP_DIRT;
    } else if (task == TASK_PLANT_SEED) {
      if (!this.inv_seeds) { return TASK_DECIDE_NEXT_TASK; }
      if (this.current_goal == null) {
        this.current_goal = this.find_nearby(
          TILE_EMPTY,
          TILE_WET_DIRT,
          0,
          NEARBY_RANGE
        );
        if (this.current_goal == null) {
          this.current_goal = this.find_nearby(
            TILE_EMPTY,
            TILE_DRY_DIRT,
            0,
            NEARBY_RANGE
          );
        }
        if (
           this.current_goal == null
        || this.path_to(this.current_goal) == null
        ) {
          return TASK_DUMP_SEED;
        }
      } else if (this.almost_at_goal()) {
        if (this.plant_seeds(this.current_goal)) {
          return TASK_DECIDE_NEXT_TASK;
        } else {
          this.current_goal = null;
        }
      }
      this.current_emote = EMOTE_TILE_VINE;
      return TASK_PLANT_SEED;
    } else if (task == TASK_WATER_VINES) {
      if (!this.inv_water) { return TASK_DECIDE_NEXT_TASK; }
      if (this.current_goal == null) {
        this.current_goal = this.find_nearby(
          TILE_EMPTY,
          TILE_DRY_DIRT,
          0,
          NEARBY_RANGE
        );
        if (
           this.current_goal == null
        || this.path_to(this.current_goal) == null
        ) {
          return TASK_DUMP_WATER;
        }
      } else if (this.almost_at_goal()) {
        if (this.pour_water(this.current_goal)) {
          return TASK_DECIDE_NEXT_TASK;
        } else {
          this.current_goal = null;
        }
      }
      this.current_emote = EMOTE_TILE_WATER;
      return TASK_WATER_VINES;
    } else if (task == TASK_PLACE_DIRT) {
      if (!this.inv_dirt) { return TASK_DECIDE_NEXT_TASK; }
      if (this.current_goal == null) {
        this.current_goal = this.find_nearby(
          TILE_EMPTY,
          TILE_WET_DIRT,
          0,
          NEARBY_RANGE
        );
        if (this.current_goal == null) {
          this.current_goal = this.find_nearby(
            TILE_EMPTY,
            TILE_DRY_DIRT,
            0,
            NEARBY_RANGE
          );
        }
        if (
           this.current_goal == null
        || this.path_to(this.current_goal) == null
        ) {
          return TASK_DUMP_DIRT;
        }
      } else if (this.almost_at_goal()) {
        if (this.place_dirt(this.current_goal)) {
          return TASK_DECIDE_NEXT_TASK;
        } else {
          this.current_goal = null;
        }
      }
      this.current_emote = EMOTE_TILE_DIRT;
      return TASK_PLACE_DIRT;
    } else if (task == TASK_SEEK_POWER) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        Collections.sort(reachable);
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (
             p.type != POWER_KEY
          && p.type != POWER_ENTRANCE
          && p.type != POWER_EXIT
          ) {
            this.current_goal = p.pos.clone();
            this.current_emote = emote_for_powerup(p.type);
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        return TASK_DECIDE_NEXT_TASK;
      }
      return TASK_SEEK_POWER;
    } else if (task == TASK_SEEK_ROPE) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (p.type == POWER_ROPE) {
            this.current_goal = p.pos.clone();
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_GET_ROPE;
      return TASK_SEEK_ROPE;
    } else if (task == TASK_SEEK_FINS) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (p.type == POWER_FINS) {
            this.current_goal = p.pos.clone();
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_GET_FINS;
      return TASK_SEEK_FINS;
    } else if (task == TASK_SEEK_SATCHEL) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (p.type == POWER_SATCHEL) {
            this.current_goal = p.pos.clone();
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_GET_SATCHEL;
      return TASK_SEEK_SATCHEL;
    } else if (task == TASK_SEEK_BUCKET) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (p.type == POWER_BUCKET) {
            this.current_goal = p.pos.clone();
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_GET_BUCKET;
      return TASK_SEEK_BUCKET;
    } else if (task == TASK_SEEK_SHOVEL) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (p.type == POWER_SHOVEL) {
            this.current_goal = p.pos.clone();
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_GET_SHOVEL;
      return TASK_SEEK_SHOVEL;
    } else if (task == TASK_SEEK_PICK) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (p.type == POWER_PICK) {
            this.current_goal = p.pos.clone();
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_GET_PICK;
      return TASK_SEEK_PICK;
    } else if (task == TASK_SEEK_TORCH) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (p.type == POWER_TORCH) {
            this.current_goal = p.pos.clone();
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_GET_TORCH;
      return TASK_SEEK_TORCH;
    } else if (task == TASK_SEEK_KEY) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (p.type == POWER_KEY) {
            this.current_goal = p.pos.clone();
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_GET_KEY;
      return TASK_SEEK_KEY;
    } else if (task == TASK_SEEK_ENTRANCE) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (p.type == POWER_ENTRANCE) {
            this.current_goal = p.pos.clone();
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_SEEK_ENTRANCE;
      return TASK_SEEK_ENTRANCE;
    } else if (task == TASK_SEEK_EXIT) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (p.type == POWER_EXIT) {
            this.current_goal = p.pos.clone();
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_SEEK_EXIT;
      return TASK_SEEK_EXIT;
    } else if (task == TASK_ASCEND) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (p.type == POWER_ENTRANCE) {
            this.current_goal = p.pos.clone();
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        this.climb_up();
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_SEEK_ENTRANCE;
      return TASK_ASCEND;
    } else if (task == TASK_DESCEND) {
      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        for (i = 0; i < reachable.size(); ++i) {
          p = reachable.get(i);
          if (p.type == POWER_EXIT) {
            this.current_goal = p.pos.clone();
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.at_goal()) {
        this.climb_down();
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_SEEK_EXIT;
      return TASK_DESCEND;
    } else if (task == TASK_EXPLORE) {
      if (this.current_goal == null) {
        this.current_goal = this.find_reachable_darkness(
          current_level().width * 3
        );
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.almost_at_goal()) {
        return TASK_DECIDE_NEXT_TASK;
      }
      this.current_emote = EMOTE_EXPLORE;
      return TASK_EXPLORE;
    } else if (task == TASK_WANDER) {
      if (this.current_goal == null) {
        for (i = 0; i < 100; ++i) {
          this.current_goal = current_level().random_visible_index();
          if (
             this.current_goal != null
          && this.path_to(this.current_goal) != null
          ) {
            break;
          }
        }
        if (this.current_goal == null) { return TASK_DECIDE_NEXT_TASK; }
      } else if (this.almost_at_goal()) {
        this.current_goal = null;
        // keep wandering to a new destination...
      }
      this.current_emote = EMOTE_WANDER;
      return TASK_WANDER;
    }
    // fallback:
    return TASK_DECIDE_NEXT_TASK;
  }

  float think(boolean change_behaviors) {
    float do_jump = 0.0;
    int i;
    // steer:
    if (this.AI == AI_NONE) {
      this.speed = 0;
      // heading is unchanged
    } else if (this.AI == AI_PLAYER_CONTROLLED) {
      float d_vx = 0;
      float d_vy = 0;
      if ((PLAYER_STEERING & DIR_UP) != 0) { d_vy += 1.0; }
      if ((PLAYER_STEERING & DIR_DOWN) != 0) { d_vy -= 1.0; }
      if ((PLAYER_STEERING & DIR_LEFT) != 0) { d_vx += 1.0; }
      if ((PLAYER_STEERING & DIR_RIGHT) != 0) { d_vx -= 1.0; }
      if (PLAYER_DO_JUMP) { do_jump = 1.0; PLAYER_DO_JUMP = false; }
      if (d_vx == 0 && d_vy == 0) {
        this.speed = 0;
      } else {
        this.heading = atan2(d_vy, d_vx);
        this.speed = this.max_speed;
      }
      this.current_emote = EMOTE_CONTROLLED;
    } else if (this.AI == AI_FOLLOW_CURSOR) {
      this.current_goal = mouse_index();

      if (random(1.0) < AI_PAUSE_FREQUENCY) {
        this.pause_cooldown = AI_PAUSE_DURATION;
      }

      do_jump = this.follow_path_with_pauses();
      this.current_emote = EMOTE_FOLLOW;
    } else if (this.AI == AI_EXPLORE_TILES) {
      int desired_tile;
      if (this.almost_at_goal()) {
        // close enough:
        this.current_goal = null;
      }

      if (this.current_goal == null || this.at_goal()) {
        desired_tile = (int) random(N_TILES);
        this.current_goal = this.find_nearby(
          desired_tile,
          TILE_ANY,
          0,
          current_level().width + current_level().height
        );
      }

      if (random(1.0) < AI_PAUSE_FREQUENCY) {
        this.pause_cooldown = AI_PAUSE_DURATION;
      }

      do_jump = this.follow_path_with_pauses();
    } else if (this.AI == AI_EXPLORE_REGIONS) {
      int target_x, target_y;
      if (this.almost_at_goal()) {
        // close enough:
        this.current_goal = null;
      }

      if (this.current_goal == null || this.at_goal()) {
        target_x = (int) random(H_REGIONS);
        target_y = (int) random(V_REGIONS);
        for (i = 0; i < N_REGION_EXP_TRIES; ++i) {
          this.current_goal = current_level().random_in_region(
            target_x,
            target_y
          );
          if (this.current_goal != null) {
            this.current_path = this.path_to(this.current_goal);
          }
          if (this.current_path != null) {
            break;
          }
        }
        if (this.current_path == null) {
          this.current_goal = null;
        }
      }

      if (random(1.0) < AI_PAUSE_FREQUENCY) {
        this.pause_cooldown = AI_PAUSE_DURATION;
      }

      do_jump = this.follow_path_with_pauses();
    } else if (this.AI == AI_COLLECT_POWERUPS) {
      ArrayList<Powerup> reachable;
      Powerup considering;
      if (this.at_goal()) {
        this.current_goal = null;
      }

      if (this.current_goal == null) {
        reachable = this.reachable_powerups();
        Collections.sort(reachable);
        this.current_path = null;
        for (i = 0; i < reachable.size(); ++i) {
          considering = reachable.get(i);
          if (this.has_powerup(considering.type)) {
            continue;
          }
          this.current_path = this.path_to(considering.pos);
          this.current_emote = emote_for_powerup(considering.type);
          break;
        }
        if (this.current_path == null) {
          this.current_goal = null;
          this.current_emote = EMOTE_CONFUSED;
        }
        if (current_level().powerups.size() <= 2) {
          this.current_emote = EMOTE_CELEBRATE;
        }
      }

      if (random(1.0) < AI_PAUSE_FREQUENCY) {
        this.pause_cooldown = AI_PAUSE_DURATION;
      }

      do_jump = this.follow_path_with_pauses();
    } else if (this.AI == AI_COOPERATE) {
      if (change_behaviors) {
        if (this.persistance > 0) {
          this.persistance -= 1;
        } else {
          this.set_current_task(TASK_DECIDE_NEXT_TASK, 0);
        }
      }
      if (PLAYER_USE_POWER) {
        if (SELECTED_POWER == POWER_INVALID) {
          println("Poke :: Decide");
          this.set_current_task(TASK_DECIDE_NEXT_TASK, 0);
        } else if (SELECTED_POWER == POWER_SATCHEL) {
          if (this.inv_seeds) {
            println("Poke :: Plant Seed");
            this.set_current_task(TASK_PLANT_SEED, 0);
          } else {
            println("Poke :: Get Seed");
            this.set_current_task(TASK_GET_SEED, 0);
          }
        } else if (SELECTED_POWER == POWER_BUCKET) {
          if (this.inv_water) {
            println("Poke :: Water Vines");
            this.set_current_task(TASK_WATER_VINES, 0);
          } else {
            println("Poke :: Get Water");
            this.set_current_task(TASK_GET_WATER, 0);
          }
        } else if (SELECTED_POWER == POWER_SHOVEL) {
          if (this.inv_dirt) {
            println("Poke :: Place Dirt");
            this.set_current_task(TASK_PLACE_DIRT, 0);
          } else {
            println("Poke :: Get Dirt");
            this.set_current_task(TASK_DIG_DIRT, 0);
          }
        } else if (SELECTED_POWER == POWER_PICK) {
          println("Poke :: Mine Stone");
          this.set_current_task(TASK_DIG_STONE, 0);
        }
        PLAYER_USE_POWER = false;
      }
      this.current_task = this.pursue_task(this.current_task);

      if (this.current_goal != null && this.current_path == null) {
        this.current_path = this.path_to(this.current_goal);
        if (this.current_path == null) {
          this.set_current_task(TASK_DECIDE_NEXT_TASK, 0);
        }
      }

      if (random(1.0) < AI_PAUSE_FREQUENCY) {
        this.pause_cooldown = AI_PAUSE_DURATION;
      }

      do_jump = this.follow_path_with_pauses();
    }
    return do_jump;
  }

  void update(float dt) {
    float d_vx, d_vy;
    float new_x, new_y;
    float new_left, new_top, new_right, new_bot;
    Index here;
    int dir;
    boolean can_jump = false;
    float do_jump = 0.0;
    boolean do_path_update = false;
    boolean change_behaviors = false;
    int i;

    this.clock += dt;
    if (this.clock > AI_CLOCK_MAX) {
      this.clock -= AI_CLOCK_MAX;
    }

    if (
       (
          floor(this.clock / AI_SLOW_UPDATE_DURATION)
       != floor((this.clock - dt) / AI_SLOW_UPDATE_DURATION)
       )
    || (this.supported(DIR_DOWN) && !this.supported_last)
    ) {
      do_path_update = true;
    }

    if (
       floor(this.clock / AI_BEHAVIOR_DURATION)
    != floor((this.clock - dt) / AI_BEHAVIOR_DURATION)
    ) {
      change_behaviors = true;
    }

    if (this.trigger_repath) {
      do_path_update = true;
    }

    this.last_jump -= dt;
    if (this.last_jump < 0) {
      this.last_jump = 0;
      can_jump = true;
    }

    this.pause_cooldown -= dt;
    if (this.pause_cooldown < 0) {
      this.pause_cooldown = 0;
    }

    // collect powerups:
    this.collect_powerups();

    this.explore();

    do_jump = this.think(change_behaviors);
    if (do_path_update) {
      this.update_current_path();
    }

    // Simple "universal" navigation:
    if (this.heading > -PI/4.0 && this.heading <= PI/4.0) {
      dir = DIR_RIGHT;
    } else if (this.heading > PI/4.0 && this.heading <= 3.0*PI/4.0) {
      dir = DIR_UP;
    } else if (this.heading > 3.0*PI/4.0 || this.heading <= -3.0*PI/4.0) {
      dir = DIR_LEFT;
    } else {
      dir = DIR_DOWN;
    }
    if (
       this.movement_mode(dir) == MOV_BLOCKED
    || this.movement_mode(dir) == MOV_MINEABLE
    ) {
      if (this.heading > 0) {
        do_jump = 1.0;
      } else if (this.heading < -PI/2.0) {
        this.heading = -PI;
        dir = DIR_LEFT;
      } else if (this.heading > -PI/2.0) {
        this.heading = 0;
        dir = DIR_RIGHT;
      } // otherwise we're stuck...
    }

    // Update based on desired velocity:
    if (this.speed < VEL_DRIFT_THRESHOLD) {
      this.speed = 0;
    }
    d_vx = -this.speed * cos(this.heading);
    d_vy = -this.speed * sin(this.heading);

    if (this.movement_mode(dir) == MOV_WADE) {
      this.vx = (1 - WADE_ACCEL) * this.vx + WADE_ACCEL * d_vx * WADE_SPEED;
      this.vy = (1 - WADE_ACCEL) * this.vy + WADE_ACCEL * d_vy * WADE_SPEED;
      if (this.vy > FLOAT_SPEED && this.supported_last) {
        this.vy += (
          WADE_GRAVITY
        * dt
        * (-0.2 + 0.8 * ((this.y - (int) this.y)) / 0.5)
        );
      }
    } else if (this.movement_mode(dir) == MOV_SWIM) {
      this.vy += SWIM_GRAVITY * dt;
      this.vx = (1 - SWIM_ACCEL) * this.vx + SWIM_ACCEL * d_vx * SWIM_SPEED;
      this.vy = (1 - SWIM_ACCEL) * this.vy + SWIM_ACCEL * d_vy * SWIM_SPEED;
    } else if (this.movement_mode(dir) == MOV_CLIMB) {
      this.vx = (1 - CLIMB_ACCEL) * this.vx + CLIMB_ACCEL * d_vx * CLIMB_SPEED;
      this.vy = (1 - CLIMB_ACCEL) * this.vy + CLIMB_ACCEL * d_vy * CLIMB_SPEED;
      // no gravity
    } else if (this.movement_mode(dir) == MOV_NORMAL) {
      this.vy += GRAVITY * dt;
      if (this.supported(DIR_DOWN)) {
        this.vx = (1 - WALK_ACCEL) * this.vx + WALK_ACCEL * d_vx;
        if (d_vy > 0) {
          this.vy = (1 - WALK_ACCEL) * this.vy + WALK_ACCEL * d_vy;
        } // only downwards vy is applied in MOV_NORMAL mode...
      } else {
        this.vx = (1 - JUMP_ACCEL) * this.vx + JUMP_ACCEL * d_vx;
        // no vy is applied while not supported
      }
    }
    if (this.supported(DIR_DOWN) && can_jump && do_jump > 0) {
      int mov = this.movement_on(current_level().tiles[this.center().idx()]);
      if (mov == MOV_WADE) {
        this.vy -= WADE_JUMP_IMPULSE * do_jump;
      } else {
        this.vy -= JUMP_IMPULSE * do_jump;
      }
      this.last_jump = JUMP_COOLDOWN;
    }
    new_x = this.x + this.vx * dt;
    new_y = this.y + this.vy * dt;

    // back-off if necessary (size had better be strictly < 0.5):
    here = this.center();
    new_top = new_y - this.size;
    new_bot = new_y + this.size;
    new_left = new_x - this.size;
    new_right = new_x + this.size;
    if (
       new_top < here.y
    && (
          this.movement_on(
            current_level().tiles[here.neighbor(DIR_UP).idx()]
          ) == MOV_BLOCKED
       || this.movement_on(
            current_level().tiles[here.neighbor(DIR_UP).idx()]
          ) == MOV_MINEABLE
       )
    ) {
      new_y = here.y + this.size + COLLISION_OFFSET;
      if (this.vy < 0) { this.vy = 0; }
    }
    if (
       new_bot > here.y + 1
    && (
          this.movement_on(
            current_level().tiles[here.neighbor(DIR_DOWN).idx()]
          ) == MOV_BLOCKED
       || this.movement_on(
            current_level().tiles[here.neighbor(DIR_DOWN).idx()]
          ) == MOV_MINEABLE
       )
    ) {
      new_y = here.y + 1 - this.size - COLLISION_OFFSET;
      if (this.vy > 0) { this.vy = 0; }
    }
    if (
       new_left < here.x
    && (
          this.movement_on(
            current_level().tiles[here.neighbor(DIR_LEFT).idx()]
          ) == MOV_BLOCKED
       || this.movement_on(
            current_level().tiles[here.neighbor(DIR_LEFT).idx()]
          ) == MOV_MINEABLE
       )
    ) {
      new_x = here.x + this.size + COLLISION_OFFSET;
      if (this.vx < 0) { this.vx = 0; }
    }
    if (
       new_right > here.x + 1
    && (
          this.movement_on(
            current_level().tiles[here.neighbor(DIR_RIGHT).idx()]
          ) == MOV_BLOCKED
       || this.movement_on(
            current_level().tiles[here.neighbor(DIR_RIGHT).idx()]
          ) == MOV_MINEABLE
       )
    ) {
      new_x = here.x + 1 - this.size - COLLISION_OFFSET;
      if (this.vx > 0) { this.vx = 0; }
    }
    // Diagonals:
    new_top = new_y - this.size;
    new_bot = new_y + this.size;
    new_left = new_x - this.size;
    new_right = new_x + this.size;
    if (
       new_right > here.x + 1
    && new_top < here.y
    && (
          this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()
            ]
          ) == MOV_BLOCKED
       || this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()
            ]
          ) == MOV_MINEABLE
       )
    ) {
      if (new_right - here.x + 1 > here.y - new_top) {
        new_y = here.y + this.size;
        if (this.vy < 0) { this.vy = 0; }
      } else {
        new_x = here.x + 1 - this.size;
        if (this.vx > 0) { this.vx = 0; }
      }
    } else if (
       new_left < here.x
    && new_top < here.y
    && (
          this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_UP).neighbor(DIR_LEFT).idx()
            ]
          ) == MOV_BLOCKED
       || this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_UP).neighbor(DIR_LEFT).idx()
            ]
          ) == MOV_MINEABLE
       )
    ) {
      if (here.x - new_left > here.y - new_top) {
        new_y = here.y + this.size;
        if (this.vy < 0) { this.vy = 0; }
      } else {
        new_x = here.x + this.size;
        if (this.vx < 0) { this.vx = 0; }
      }
    } else if (
       new_right > here.x + 1
    && new_bot > here.y + 1
    && (
          this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_DOWN).neighbor(DIR_RIGHT).idx()
            ]
          ) == MOV_BLOCKED
       || this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_DOWN).neighbor(DIR_RIGHT).idx()
            ]
          ) == MOV_MINEABLE
       )
    ) {
      if (new_right - here.x + 1 > new_bot - here.y + 1) {
        new_y = here.y + 1 - this.size;
        if (this.vy > 0) { this.vy = 0; }
      } else {
        new_x = here.x + 1 - this.size;
        if (this.vx > 0) { this.vx = 0; }
      }
    } else if (
       new_left < here.x
    && new_bot > here.y + 1
    && (
          this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_DOWN).neighbor(DIR_LEFT).idx()
            ]
          ) == MOV_BLOCKED
       || this.movement_on(
            current_level().tiles[
              here.neighbor(DIR_DOWN).neighbor(DIR_LEFT).idx()
            ]
          ) == MOV_MINEABLE
       )
    ) {
      if (here.x - new_left > new_bot - here.y + 1) {
        new_y = here.y + 1 - this.size;
        if (this.vy > 0) { this.vy = 0; }
      } else {
        new_x = here.x + this.size;
        if (this.vx < 0) { this.vx = 0; }
      }
    }

    // update supported_last before changing position:
    this.supported_last = this.supported(DIR_DOWN);

    this.x = new_x;
    this.y = new_y;

    // re-wrap coordinates:
    while (this.x < 0) { this.x += current_level().width; }
    while (this.x > current_level().width) { this.x -= current_level().width; }
    while (this.y < 0) { this.y += current_level().height; }
    while (this.y > current_level().height) { this.y -= current_level().height;}
  }
}

class Level {
  public int width, height;
  public int tiles[];
  public int next_tiles[];
  public double water[];
  public double flux[];
  public int vine_lengths[];
  public float explored[];
  public ArrayList<Powerup> powerups;

  Level(int width, int height) {
    this.width = width;
    this.height = height;
    this.tiles = new int[this.width * this.height];
    this.next_tiles = new int[this.width * this.height];
    this.water = new double[this.width * this.height];
    this.flux = new double[this.width * this.height];
    this.vine_lengths = new int[this.width * this.height];
    this.explored = new float[this.width * this.height];
    this.powerups = new ArrayList<Powerup>();
  }

  Level(Level o) {
    int i;
    this.width = o.width;
    this.height = o.height;

    this.tiles = new int[this.width * this.height];
    this.next_tiles = new int[this.width * this.height];
    this.water = new double[this.width * this.height];
    this.flux = new double[this.width * this.height];
    this.vine_lengths = new int[this.width * this.height];
    this.explored = new float[this.width * this.height];

    for (i = 0; i < this.width * this.height; ++i) {
      this.tiles[i] = o.tiles[i];
      this.next_tiles[i] = o.next_tiles[i];
      this.water[i] = o.water[i];
      this.flux[i] = o.flux[i];
      this.vine_lengths[i] = o.vine_lengths[i];
      this.explored[i] = o.explored[i];
    }

    for (i = 0; i < o.powerups.size(); ++i) {
      this.powerups.add(o.powerups.get(i));
    }
  }

  /*
  void save() {
    int i;
    this.width = BOARD_WIDTH;
    this.height = BOARD_HEIGHT;
    for (i = 0; i < this.width * this.height; ++i) {
      this.tiles[i] = BOARD[i];
      this.next_tiles[i] = NEXT[i];
      this.water[i] = WATER_FLOW[i];
      this.flux[i] = FLUX[i];
      this.vine_lengths[i] = VINE_LENGTH[i];
      this.explored[i] = EXPLORATION[i];
    }
    this.powerups = new ArrayList<Powerup>();
    for (i = 0; i < POWERUPS.size(); ++i) {
      this.powerups.add(POWERUPS.get(i));
    }
  }

  void load() {
    int i;
    BOARD_WIDTH = this.width;
    BOARD_HEIGHT = this.height;
    for (i = 0; i < this.width * this.height; ++i) {
      BOARD[i] = this.tiles[i];
      NEXT[i] = this.next_tiles[i];
      WATER_FLOW[i] = this.water[i];
      FLUX[i] = this.flux[i];
      VINE_LENGTH[i] = this.vine_lengths[i];
      EXPLORATION[i] = this.explored[i];
    }
    POWERUPS = new ArrayList<Powerup>();
    for (i = 0; i < this.powerups.size(); ++i) {
      POWERUPS.add(this.powerups.get(i));
    }
  }
  */

  void set_next(Index i, int tile) {
    if (this.next_tiles[i.idx()] < tile) {
      this.next_tiles[i.idx()] = tile;
    }
  }

  void clone_to_next() {
    int i;
    for (i = 0; i < this.width * this.height; ++i) {
      this.next_tiles[i] = this.tiles[i];
    }
  }

  void swap_from_next() {
    int i;
    for (i = 0; i < this.width * this.height; ++i) {
      this.tiles[i] = this.next_tiles[i];
    }
  }

  boolean powerup_exists_at(Index h) {
    int i;
    for (i = 0; i < this.powerups.size(); ++i) {
      if (this.powerups.get(i).pos.same_place(h)) {
        return true;
      }
    }
    return false;
  }

  void place_powerup_biased(int type, int dir) {
    ArrayList<Index> candidates = new ArrayList<Index>();
    ArrayList<Float> weights = new ArrayList<Float>();
    Index h;
    int tile, tile_below;
    int i;
    float weight, total_weight = 0;
    float choice;
    h = random_index();
    tile = this.tiles[h.idx()];
    tile_below = this.tiles[h.neighbor(DIR_DOWN).idx()];
    for (i = 0; i < 12; ++i) {
      h = random_index();
      tile = this.tiles[h.idx()];
      tile_below = this.tiles[h.neighbor(DIR_DOWN).idx()];
      while (
         tile != TILE_EMPTY
      || tile_below == TILE_EMPTY
      || tile_below == TILE_WATER
      || powerup_exists_at(h)
      || h.match_in(candidates) != -1
      ) {
        h = random_index();
        tile = this.tiles[h.idx()];
        tile_below = this.tiles[h.neighbor(DIR_DOWN).idx()];
      }
      candidates.add(h);
      weight = 0;
      if (dir == DIR_UP) {
        weight = 0.5 + (1 - h.y / (float) this.height);
      } else if (dir == DIR_DOWN) {
        weight = 0.5 + (h.y / (float) this.height);
      } else if (dir == DIR_RIGHT) {
        weight = 0.5 + (h.x / (float) this.width);
      } else if (dir == DIR_LEFT) {
        weight = 0.5 + (1 - h.x / (float) this.width);
      }
      total_weight += weight;
      weights.add(weight);
    }
    choice = random(total_weight);
    for (i = 0; i < candidates.size(); ++i) {
      choice -= weights.get(i);
      if (choice < 0) {
        this.powerups.add(new Powerup(candidates.get(i), type));
        return;
      }
    }
    // fallback:
    this.powerups.add(new Powerup(h, type));
  }

  void place_powerup(int power) {
    Index h;
    int tile, tile_below;
    h = random_index();
    tile = this.tiles[h.idx()];
    tile_below = this.tiles[h.neighbor(DIR_DOWN).idx()];
    while (
       tile != TILE_EMPTY
    || tile_below == TILE_EMPTY
    || tile_below == TILE_WATER
    || powerup_exists_at(h)
    ) {
      h = random_index();
      tile = this.tiles[h.idx()];
      tile_below = this.tiles[h.neighbor(DIR_DOWN).idx()];
    }
    this.powerups.add(new Powerup(h, power));
  }

  Index location_of(int power) {
    int i;
    for (i = 0; i < this.powerups.size(); ++i) {
      if (this.powerups.get(i).type == power) {
        return this.powerups.get(i).pos;
      }
    }
    return null;
  }

  void place_agent_randomly(Agent a) {
    // TODO: Something more sophisticated!
    a.x = random(this.width);
    a.y = random(this.height);
    while (
       a.movement_on(this.tiles[a.center().idx()]) == MOV_BLOCKED
    || a.movement_on(this.tiles[a.center().idx()]) == MOV_MINEABLE
    ) {
      a.x = random(this.width);
      a.y = random(this.height);
    }
  }

  void place_agent_at_entrance(Agent a) {
    Index h = this.location_of(POWER_ENTRANCE);
    if (h != null) {
      a.x = h.x + 0.5;
      a.y = h.y + 0.5;
    } else {
      // Fallback:
      this.place_agent_randomly(a);
    }
  }

  void place_agent_at_exit(Agent a) {
    Index h = this.location_of(POWER_EXIT);
    if (h != null) {
      a.x = h.x + 0.5;
      a.y = h.y + 0.5;
    } else {
      // Fallback:
      this.place_agent_randomly(a);
    }
  }

  boolean any_touching(Index i, int tile) {
    if (tile == TILE_ANY) { return true; }
    if (this.tiles[i.neighbor(DIR_UP).idx()] == tile) { return true; }
    if (this.tiles[i.neighbor(DIR_RIGHT).idx()] == tile) { return true; }
    if (this.tiles[i.neighbor(DIR_DOWN).idx()] == tile) { return true; }
    if (this.tiles[i.neighbor(DIR_LEFT).idx()] == tile) { return true; }
    if (this.tiles[i.neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()] == tile) {
      return true;
    }
    if (this.tiles[i.neighbor(DIR_RIGHT).neighbor(DIR_DOWN).idx()] == tile) {
      return true;
    }
    if (this.tiles[i.neighbor(DIR_DOWN).neighbor(DIR_LEFT).idx()] == tile) {
      return true;
    }
    if (this.tiles[i.neighbor(DIR_LEFT).neighbor(DIR_UP).idx()] == tile) {
      return true;
    }
    return false;
  }

  int count_touching(Index i, int tile) {
    int result = 0;
    if (tile == TILE_ANY) { return 8; }
    if (this.tiles[i.neighbor(DIR_UP).idx()] == tile) { result += 1; }
    if (this.tiles[i.neighbor(DIR_RIGHT).idx()] == tile) { result += 1; }
    if (this.tiles[i.neighbor(DIR_DOWN).idx()] == tile) { result += 1; }
    if (this.tiles[i.neighbor(DIR_LEFT).idx()] == tile) { result += 1; }
    if (this.tiles[i.neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()] == tile) {
      result += 1;
    }
    if (this.tiles[i.neighbor(DIR_RIGHT).neighbor(DIR_DOWN).idx()] == tile) {
      result += 1;
    }
    if (this.tiles[i.neighbor(DIR_DOWN).neighbor(DIR_LEFT).idx()] == tile) {
      result += 1;
    }
    if (this.tiles[i.neighbor(DIR_LEFT).neighbor(DIR_UP).idx()] == tile) {
      result += 1;
    }
    return result;
  }

  boolean any_adjacent(Index i, int tile) {
    if (tile == TILE_ANY) { return true; }
    if (this.tiles[i.neighbor(DIR_UP).idx()] == tile) { return true; }
    if (this.tiles[i.neighbor(DIR_RIGHT).idx()] == tile) { return true; }
    if (this.tiles[i.neighbor(DIR_DOWN).idx()] == tile) { return true; }
    if (this.tiles[i.neighbor(DIR_LEFT).idx()] == tile) { return true; }
    return false;
  }

  int count_adjacent(Index i, int tile) {
    int result = 0;
    if (tile == TILE_ANY) { return 4; }
    if (this.tiles[i.neighbor(DIR_UP).idx()] == tile) { result += 1; }
    if (this.tiles[i.neighbor(DIR_RIGHT).idx()] == tile) { result += 1; }
    if (this.tiles[i.neighbor(DIR_DOWN).idx()] == tile) { result += 1; }
    if (this.tiles[i.neighbor(DIR_LEFT).idx()] == tile) { result += 1; }
    return result;
  }

  void update_cells() {
    this.update_dirt();
    this.update_water();
    this.grow_vines();
  }

  void update_dirt() {
    Index i = new Index(this, 0, 0);
    int len;
    this.clone_to_next();
    for (i.x = 0; i.x < this.width; ++i.x) {
      for (i.y = 0; i.y < this.height; ++i.y) {
        if (this.tiles[i.idx()] == TILE_DRY_DIRT) {
          if (any_adjacent(i, TILE_WATER)) {
            this.next_tiles[i.idx()] = TILE_WET_DIRT;
          }
        } else if (this.tiles[i.idx()] == TILE_WET_DIRT) {
          if (!any_adjacent(i, TILE_WATER)) {
            this.next_tiles[i.idx()] = TILE_DRY_DIRT;
          }
        }
      }
    }
    this.swap_from_next();
  }

  void update_water() {
    Index i = new Index(this, 0, 0);
    double flow_here, balance_level, space_above;
    double surplus, surplus_left, surplus_right;
    for (i.x = 0; i.x < this.width; ++i.x) {
      for (i.y = 0; i.y < this.height; ++i.y) {
        if (this.tiles[i.idx()] > TILE_WATER && this.water[i.idx()] > 0) {
          this.water[i.idx()] = 0.0;
        }
        this.flux[i.idx()] = 0.0;
      }
    }
    // First pass: flow downwards
    for (i.y = 0; i.y < this.height; ++i.y) {
      for (i.x = 0; i.x < this.width; ++i.x) {
        flow_here = this.water[i.idx()];
        if (
           flow_here > 0
        && this.tiles[i.neighbor(DIR_DOWN).idx()] <= TILE_WATER
        ) { // can flow down
          if (
            flow_here + this.water[i.neighbor(DIR_DOWN).idx()]
          < MAX_COMPRESSED_FLOW
          ) {
            this.flux[i.idx()] -= flow_here;
            this.flux[i.neighbor(DIR_DOWN).idx()] += flow_here;
          } else {
            balance_level = (
              flow_here
            + this.water[i.neighbor(DIR_DOWN).idx()]
            - MAX_COMPRESSED_FLOW
            );
            this.flux[i.idx()] -= flow_here - balance_level;
            this.flux[i.neighbor(DIR_DOWN).idx()] += flow_here - balance_level;
          }
        }
      }
    }
    for (i.y = 0; i.y < this.height; ++i.y) {
      for (i.x = 0; i.x < this.width; ++i.x) {
        this.water[i.idx()] += this.flux[i.idx()];
        this.flux[i.idx()] = 0.0;
      }
    }
    // Second pass: flow side-to-side
    for (i.y = 0; i.y < this.height; ++i.y) {
      for (i.x = 0; i.x < this.width; ++i.x) {
        flow_here = this.water[i.idx()];
        if (
           this.tiles[i.neighbor(DIR_DOWN).idx()] <= TILE_WATER
        && this.water[i.neighbor(DIR_DOWN).idx()] < 1.0
        ) {
          // liquid can continue to flow downwards next step: no need to spread
          continue;
        }
        if ( // flow left but not right
           this.tiles[i.neighbor(DIR_LEFT).idx()] <= TILE_WATER
        && this.water[i.neighbor(DIR_LEFT).idx()] < flow_here
        && (
              this.tiles[i.neighbor(DIR_RIGHT).idx()] > TILE_WATER
           || this.water[i.neighbor(DIR_RIGHT).idx()] >= flow_here
           )
        ) {
          balance_level = (
            flow_here+this.water[i.neighbor(DIR_LEFT).idx()]
          ) / 2.0;
          this.flux[i.idx()] += (
            FLOW_BALANCING_SPEED
          * (balance_level - flow_here)
          );
          this.flux[i.neighbor(DIR_LEFT).idx()] += FLOW_BALANCING_SPEED * (
            flow_here
          - balance_level
          );
        } else if ( // flow right but not left
           this.tiles[i.neighbor(DIR_RIGHT).idx()] <= TILE_WATER
        && this.water[i.neighbor(DIR_RIGHT).idx()] < flow_here
        && (
              this.tiles[i.neighbor(DIR_LEFT).idx()] > TILE_WATER
           || this.water[i.neighbor(DIR_LEFT).idx()] >= flow_here
           )
        ) {
          balance_level = (flow_here+this.water[i.neighbor(DIR_RIGHT).idx()])/2.0;
          this.flux[i.idx()] += FLOW_BALANCING_SPEED * (balance_level - flow_here);
          this.flux[i.neighbor(DIR_RIGHT).idx()] += FLOW_BALANCING_SPEED * (
            flow_here
          - balance_level
          );
        } else if ( // flow both left and right
           this.tiles[i.neighbor(DIR_RIGHT).idx()] <= TILE_WATER
        && this.water[i.neighbor(DIR_RIGHT).idx()] < flow_here
        && this.tiles[i.neighbor(DIR_LEFT).idx()] <= TILE_WATER
        && this.water[i.neighbor(DIR_LEFT).idx()] < flow_here
        ) {
          surplus = flow_here - (
            flow_here
          + this.water[i.neighbor(DIR_LEFT).idx()]
          + this.water[i.neighbor(DIR_RIGHT).idx()]
          ) / 3.0;
          surplus_left = flow_here - this.water[i.neighbor(DIR_LEFT).idx()];
          surplus_right = flow_here - this.water[i.neighbor(DIR_RIGHT).idx()];
          this.flux[i.idx()] -= surplus * FLOW_BALANCING_SPEED;
          this.flux[i.neighbor(DIR_LEFT).idx()] += (
            surplus
          * FLOW_BALANCING_SPEED
          * (surplus_left / (surplus_left + surplus_right))
          );
          this.flux[i.neighbor(DIR_RIGHT).idx()] += (
            surplus
          * FLOW_BALANCING_SPEED
          * (surplus_right / (surplus_left + surplus_right))
          );
        } // else trapped; no flux
      }
    }
    for (i.y = 0; i.y < this.height; ++i.y) {
      for (i.x = 0; i.x < this.width; ++i.x) {
        this.water[i.idx()] += this.flux[i.idx()];
        this.flux[i.idx()] = 0.0;
      }
    }
    // Third pass: spring back up where compressed:
    for (i.y = this.height - 1; i.y > -1; --i.y) {
      for (i.x = 0; i.x < this.width; ++i.x) {
        flow_here = this.water[i.idx()];
        surplus = flow_here - 1.0;
        if (this.tiles[i.neighbor(DIR_UP).idx()] <= TILE_WATER && surplus > 0) {
          space_above = (
            1.0
          + ((flow_here - 1.0) * 0.5)
          - this.water[i.neighbor(DIR_UP).idx()]
          );
          if (space_above > 0) {
            if (space_above < surplus) {
              this.flux[i.idx()] -= space_above;
              this.flux[i.neighbor(DIR_UP).idx()] += space_above;
            } else {
              this.flux[i.idx()] -= surplus;
              this.flux[i.neighbor(DIR_UP).idx()] += surplus;
            }
          }
        }
      }
    }
    for (i.y = 0; i.y < this.height; ++i.y) {
      for (i.x = 0; i.x < this.width; ++i.x) {
        this.water[i.idx()] += this.flux[i.idx()];
        this.flux[i.idx()] = 0.0;
      }
    }
    /*
    // Fourth pass: flow side-to-side *again*
    for (i.y = 0; i.y < this.height; ++i.y) {
      for (i.x = 0; i.x < this.width; ++i.x) {
        flow_here = this.water[i.idx()];
        if (
           this.tiles[i.neighbor(DIR_DOWN).idx()] <= TILE_WATER
        && this.water[i.neighbor(DIR_DOWN).idx()] < 1.0
        ) {
          // liquid can continue to flow downwards next step: no need to spread
          continue;
        }
        if ( // flow left but not right
           this.tiles[i.neighbor(DIR_LEFT).idx()] <= TILE_WATER
        && this.water[i.neighbor(DIR_LEFT).idx()] < flow_here
        && (
              this.tiles[i.neighbor(DIR_RIGHT).idx()] > TILE_WATER
           || this.water[i.neighbor(DIR_RIGHT).idx()] >= flow_here
           )
        ) {
          balance_level = (flow_here+this.water[i.neighbor(DIR_LEFT).idx()]) /2.0;
          this.flux[i.idx()] += FLOW_BALANCING_SPEED * (balance_level - flow_here);
          this.flux[i.neighbor(DIR_LEFT).idx()] += FLOW_BALANCING_SPEED * (
            flow_here
          - balance_level
          );
        } else if ( // flow right but not left
           this.tiles[i.neighbor(DIR_RIGHT).idx()] <= TILE_WATER
        && this.water[i.neighbor(DIR_RIGHT).idx()] < flow_here
        && (
              this.tiles[i.neighbor(DIR_LEFT).idx()] > TILE_WATER
           || this.water[i.neighbor(DIR_LEFT).idx()] >= flow_here
           )
        ) {
          balance_level = (flow_here+this.water[i.neighbor(DIR_RIGHT).idx()])/2.0;
          this.flux[i.idx()] += FLOW_BALANCING_SPEED * (balance_level - flow_here);
          this.flux[i.neighbor(DIR_RIGHT).idx()] += FLOW_BALANCING_SPEED * (
            flow_here
          - balance_level
          );
        } else if ( // flow both left and right
           this.tiles[i.neighbor(DIR_RIGHT).idx()] <= TILE_WATER
        && this.water[i.neighbor(DIR_RIGHT).idx()] < flow_here
        && this.tiles[i.neighbor(DIR_LEFT).idx()] <= TILE_WATER
        && this.water[i.neighbor(DIR_LEFT).idx()] < flow_here
        ) {
          surplus = flow_here - (
            flow_here
          + this.water[i.neighbor(DIR_LEFT).idx()]
          + this.water[i.neighbor(DIR_RIGHT).idx()]
          ) / 3.0;
          surplus_left = flow_here - this.water[i.neighbor(DIR_LEFT).idx()];
          surplus_right = flow_here - this.water[i.neighbor(DIR_RIGHT).idx()];
          this.flux[i.idx()] -= surplus * FLOW_BALANCING_SPEED;
          this.flux[i.neighbor(DIR_LEFT).idx()] += (
            surplus
          * FLOW_BALANCING_SPEED
          * (surplus_left / (surplus_left + surplus_right))
          );
          this.flux[i.neighbor(DIR_RIGHT).idx()] += (
            surplus
          * FLOW_BALANCING_SPEED
          * (surplus_right / (surplus_left + surplus_right))
          );
        } // else trapped; no flux
      }
    }
    for (i.y = 0; i.y < this.height; ++i.y) {
      for (i.x = 0; i.x < this.width; ++i.x) {
        this.water[i.idx()] += this.flux[i.idx()];
        this.flux[i.idx()] = 0.0;
      }
    }
    */

    // Final pass: update color values:
    this.clone_to_next();
    for (i.x = 0; i.x < this.width; ++i.x) {
      for (i.y = 0; i.y < this.height; ++i.y) {
        if (this.water[i.idx()] > EVAPORATION_THRESHOLD) {
          if (this.water[i.idx()] > LIQUID_DISPLAY_THRESHOLD) {
            this.set_next(i, TILE_WATER);
          } else if (this.tiles[i.idx()] == TILE_WATER) {
            this.next_tiles[i.idx()] = TILE_EMPTY;
          }
        } else {
          this.water[i.idx()] = 0.0;
          if (this.tiles[i.idx()] == TILE_WATER) {
            this.next_tiles[i.idx()] = TILE_EMPTY;
          }
        }
      }
    }
    this.swap_from_next();
  }

  void grow_vines() {
    Index i = new Index(this, 0, 0);
    int len;
    this.clone_to_next();
    for (i.x = 0; i.x < this.width; ++i.x) {
      for (i.y = 0; i.y < this.height; ++i.y) {
        if (this.tiles[i.idx()] == TILE_VINES) {
          if (this.any_adjacent(i, TILE_DRY_DIRT)) {
            this.vine_lengths[i.idx()] = 1 + DRY_DIRT_PENALTY;
            len = 1 + DRY_DIRT_PENALTY;
          } else if (this.any_adjacent(i, TILE_WET_DIRT)) {
            this.vine_lengths[i.idx()] = 1;
            len = 1;
          } else {
            len = this.vine_lengths[i.idx()];
          }

          if (len > this.vine_lengths[i.idx()]) {
            this.next_tiles[i.idx()] = TILE_EMPTY;
          } else {
            check_grow_vines(i.neighbor(DIR_UP), len + 1);
            check_grow_vines(i.neighbor(DIR_RIGHT), len + 1);
            check_grow_vines(i.neighbor(DIR_DOWN), len + 1);
            check_grow_vines(i.neighbor(DIR_LEFT), len + 1);
          }
        }
      }
    }
    this.swap_from_next();
  }

  void check_grow_vines(Index i, int length) {
    if (length > this.vine_lengths[i.idx()]) {
      return;
    }
    if (this.tiles[i.idx()] == TILE_VINES) {
      if (length < this.vine_lengths[i.idx()]) {
        this.vine_lengths[i.idx()] = length;
      }
    } else if (this.tiles[i.idx()] == TILE_WATER) {
      return;
    }
    if (this.count_adjacent(i, TILE_VINES) > 1) {
      return;
    }
    if (this.next_tiles[i.idx()] < TILE_VINES) {
      this.next_tiles[i.idx()] = TILE_VINES;
      this.vine_lengths[i.idx()] = length;
    }
  }

  Index random_index() {
    return new Index(this, (int) random(this.width), (int) random(this.height));
  }

  Index random_visible_index() {
    int choice;
    int count = 0;
    int i;
    Index result = new Index(this, 0, 0);
    for (i = 0; i < this.width * this.height; ++i) {
      if (this.explored[i] > 0) {
        count += 1;
      }
    }
    if (count == 0) { return null; }
    choice = (int) random(count);
    for (result.x = 0; result.x < this.width; ++result.x) {
      for (result.y = 0; result.y < this.height; ++result.y) {
        if (this.explored[result.idx()] > 0) {
          choice -= 1;
          if (choice < 0) {
            return result;
          }
        }
      }
    }
    return null;
  }

  Index random_in_region(int r_x, int r_y) {
    Index result = new Index(this, 0, 0);
    result.x = REGION_WIDTH * r_x + (int) random(REGION_WIDTH);
    result.y = REGION_HEIGHT * r_y + (int) random(REGION_HEIGHT);
    return result;
  }

  void draw_tiles() {
    // So we do it the hard way:
    Index i = new Index(this, 0, 0);
    noStroke();
    for (i.x = 0; i.x < this.width; ++i.x) {
      for (i.y = 0; i.y < this.height; ++i.y) {
        fill(TILES[this.tiles[i.idx()]]);
        rect(i.x*TILE_SIZE, i.y*TILE_SIZE, TILE_SIZE, TILE_SIZE);
        // DEBUG:
        /*
        fill(0, 0, 1);
        text(
          String.format("%.3f", WATER_FLOW[i.idx()]),
          (i.x + 0.4)*TILE_SIZE,
          (i.y + 0.55)*TILE_SIZE
        );
        */
      }
    }
  }

  void draw_powerups(int frames) {
    int i;
    for (i = 0; i < this.powerups.size(); ++i) {
      this.powerups.get(i).draw(frames);
    }
  }

  void draw_shroud() {
    Index h = new Index(this, 0, 0);
    noStroke();
    for (h.x = 0; h.x < this.width; ++h.x) {
      for (h.y = 0; h.y < this.height; ++h.y) {
        fill(0, 0, 0, 1.0 - this.explored[h.idx()]);
        rect(h.x*TILE_SIZE, h.y*TILE_SIZE, TILE_SIZE, TILE_SIZE);
      }
    }
  }
}

int emote_for_powerup(int power) {
  if (power == POWER_ROPE) {
    return EMOTE_GET_ROPE;
  } else if (power == POWER_FINS) {
    return EMOTE_GET_FINS;
  } else if (power == POWER_BUCKET) {
    return EMOTE_GET_BUCKET;
  } else if (power == POWER_SATCHEL) {
    return EMOTE_GET_SATCHEL;
  } else if (power == POWER_SHOVEL) {
    return EMOTE_GET_SHOVEL;
  } else if (power == POWER_PICK) {
    return EMOTE_GET_PICK;
  } else if (power == POWER_TORCH) {
    return EMOTE_GET_TORCH;
  } else if (power == POWER_KEY) {
    return EMOTE_GET_KEY;
  } else if (power == POWER_ENTRANCE) {
    return EMOTE_SEEK_ENTRANCE;
  } else if (power == POWER_EXIT) {
    return EMOTE_SEEK_EXIT;
  } else {
    return EMOTE_CONFUSED;
  }
}

int prev_dir(int direction) {
  if (direction == DIR_UP) { return DIR_LEFT; }
  else if (direction == DIR_LEFT) { return DIR_DOWN; }
  else if (direction == DIR_DOWN) { return DIR_RIGHT; }
  else if (direction == DIR_RIGHT) { return DIR_UP; }
  println("Error: bad direction in prev_dir: ", direction);
  return DIR_UP;
}

int next_dir(int direction) {
  if (direction == DIR_UP) { return DIR_RIGHT; }
  else if (direction == DIR_RIGHT) { return DIR_DOWN; }
  else if (direction == DIR_DOWN) { return DIR_LEFT; }
  else if (direction == DIR_LEFT) { return DIR_UP; }
  println("Error: bad direction in next_dir: ", direction);
  return DIR_UP;
}

int opp_dir(int direction) {
  if (direction == DIR_UP) { return DIR_DOWN; }
  else if (direction == DIR_RIGHT) { return DIR_LEFT; }
  else if (direction == DIR_LEFT) { return DIR_RIGHT; }
  else if (direction == DIR_DOWN) { return DIR_UP; }
  println("Error: bad direction in opp_dir: ", direction);
  return DIR_UP;
}

void generate_level(Level l, Agent hero, boolean locked) {
  int i;
  Index h = new Index(l, 0, 0);
  for (h.x = 0; h.x < l.width; ++h.x) {
    for (h.y = 0; h.y < l.height; ++h.y) {
      l.vine_lengths[h.idx()] = MAX_VINE_LENGTH + 1;
      l.water[h.idx()] = 0;
      l.flux[h.idx()] = 0;
      l.explored[h.idx()] = 0.0;
      if (
         random(1) < 0.7 && (h.y % 6) == 0
      || random(1) < 0.4 && (h.y % 4) == 0
      ) {
        l.tiles[h.idx()] = TILE_STONE;
      } else if (
         random(1) < 0.3 && ((h.y + 1) % 6) == 0
      || random(1) < 0.15 && ((h.y + 1) % 5) == 0
      ) {
        l.tiles[h.idx()] = TILE_DRY_DIRT;
      } else if (
         random(1) < 0.3 && ((h.y + 1) % 7) == 0
      || random(1) < 0.15 && ((h.y + 1) % 5) == 0
      ) {
        l.tiles[h.idx()] = TILE_WALL;
      } else if (random(1) < 0.01) {
        l.tiles[h.idx()] = TILE_WATER;
        l.water[h.idx()] = 4.0;
      } else if (random(1) < 0.02) {
        l.tiles[h.idx()] = TILE_VINES;
      } else {
        l.tiles[h.idx()] = TILE_EMPTY;
      }
      //*
      if (
         h.x == 0
      || h.x == l.width - 1
      || h.y == 0
      || h.y == l.height - 1
      ) {
        if (random(1) < 0.4) {
          l.tiles[h.idx()] = TILE_WALL;
          l.water[h.idx()] = 0.0;
        } else if (random(1) < 0.2) {
          l.tiles[h.idx()] = TILE_STONE;
          l.water[h.idx()] = 0.0;
        } else if (random(1) < 0.1) {
          l.tiles[h.idx()] = TILE_DRY_DIRT;
          l.water[h.idx()] = 0.0;
        }
      }
      // */
    }
  }
  for (i = 0; i < INITIAL_SETTLE_TIME; ++i) {
    l.update_cells();
  }
  // Scatter powerups:
  l.powerups = new ArrayList<Powerup>();
  if (!hero.has_powerup(POWER_ROPE) && random(1) < 0.2) {
    l.place_powerup(POWER_ROPE);
  }
  if (!hero.has_powerup(POWER_FINS) && random(1) < 0.2) {
    l.place_powerup(POWER_FINS);
  }
  if (!hero.has_powerup(POWER_SHOVEL) && random(1) < 0.2) {
    l.place_powerup(POWER_SHOVEL);
  }
  if (!hero.has_powerup(POWER_SATCHEL) && random(1) < 0.2) {
    l.place_powerup(POWER_SATCHEL);
  }
  if (!hero.has_powerup(POWER_PICK) && random(1) < 0.2) {
    l.place_powerup_biased(POWER_PICK, DIR_DOWN);
  }
  if (!hero.has_powerup(POWER_BUCKET) && random(1) < 0.2) {
    l.place_powerup(POWER_BUCKET);
  }
  if (!hero.has_powerup(POWER_TORCH) && random(1) < 0.2) {
    l.place_powerup(POWER_TORCH);
  }
  if (locked) {
    l.place_powerup_biased(POWER_KEY, DIR_UP);
  }
  l.place_powerup_biased(POWER_ENTRANCE, DIR_UP);
  l.place_powerup_biased(POWER_EXIT, DIR_UP);
}

void setup() {
  size(800, 600, P2D);
  frameRate(FRAME_RATE);
  textSize(TEXT_SIZE);

  ellipseMode(RADIUS);

  WINDOW_WIDTH = 800;
  WINDOW_HEIGHT = 600;

  randomSeed(27);
  noiseSeed(17);

  colorMode(HSB, 1.0, 1.0, 1.0, 1.0);

  // Initialize tiles:
  TILES = new color[N_TILES];
  TILES[TILE_EMPTY] = color(0, 0, 0); // black
  TILES[TILE_STONE] = color(0, 0, 0.5); // grey
  TILES[TILE_WALL] = color(0, 0, 1); // white
  TILES[TILE_WATER] = color(0.55, 0.6, 0.9); // blue
  TILES[TILE_VINES] = color(0.4, 1.0, 0.7); // green
  TILES[TILE_DRY_DIRT] = color(0.12, 0.8, 0.55); // brown
  TILES[TILE_WET_DIRT] = color(0.12, 1.0, 0.45); // brown
  TILES[TILE_FIRE] = color(0.12, 1.0, 1.0); // orange
  TILES[TILE_MAGIC] = color(0.78, 0.8, 0.8); // purple

  POWERUP_SPRITES = new PImage[POWER_INVALID + 1];
  POWERUP_SPRITES[POWER_NONE] = loadImage("unknown.png");
  POWERUP_SPRITES[POWER_ENTRANCE] = loadImage("entrance.png");
  POWERUP_SPRITES[POWER_EXIT] = loadImage("exit-locked.png");
  POWERUP_SPRITES[POWER_FINS] = loadImage("fins.png");
  POWERUP_SPRITES[POWER_ROPE] = loadImage("rope.png");
  POWERUP_SPRITES[POWER_BUCKET] = loadImage("bucket.png");
  POWERUP_SPRITES[POWER_SHOVEL] = loadImage("shovel.png");
  POWERUP_SPRITES[POWER_PICK] = loadImage("pick.png");
  POWERUP_SPRITES[POWER_SATCHEL] = loadImage("satchel.png");
  POWERUP_SPRITES[POWER_TORCH] = loadImage("torch.png");
  POWERUP_SPRITES[POWER_KEY] = loadImage("key.png");
  POWERUP_SPRITES[POWER_INVALID] = loadImage("unknown.png");

  UNLOCKED_EXIT_SPRITE = loadImage("exit-open.png");

  ALL_LEVELS = new ArrayList<Level>();

  // The agent:
  LOST = new Agent(
    0, // x
    0, // y
    DEFAULT_MAX_SPEED, // max_speed
    DEFAULT_SIZE, // size
    DEFAULT_TORCH_RADIUS, // vision
    AI_COOPERATE // AI
    // AI_COLLECT_POWERUPS // AI
    // AI_EXPLORE_REGIONS // AI
    // AI_FOLLOW_CURSOR // AI
    // AI_PLAYER_CONTROLLED // AI
  );
  LOST.add_powerup(POWER_ENTRANCE);
  LOST.add_powerup(POWER_EXIT);

  load_next_level();
}

Index mouse_index() {
  float x, y;
  int board_px_width = TILE_SIZE * current_level().width;
  int board_px_height = TILE_SIZE * current_level().height;

  x = (mouseX - (width - board_px_width) / 2) / (float) board_px_width;
  y = (mouseY - (height - board_px_height) / 2) / (float) board_px_height;

  return new Index(
    current_level(),
    (int) (x * current_level().width),
    (int) (y * current_level().height)
  );
}

void draw_powerup_slot(Agent a, int type, int t) {
  if (a.has_powerup(type)) {
    draw_powerup(type, t);
  } else {
    noStroke();
    fill(0, 0, 0.5);
    rect(0, 0, TILE_SIZE, TILE_SIZE);

    fill(0, 0, 0.9);
    textSize(TILE_SIZE * 0.9);
    text("?", 0.3*TILE_SIZE, 0.85*TILE_SIZE);
    textSize(TEXT_SIZE);
  }
}

void draw_inv_square(boolean occupied, color c) {
  int ident = 6;
  stroke(0, 0, 0.7);
  if (occupied) {
    fill(c);
    rect(0, 0, 4*TILE_SIZE, 4*TILE_SIZE);
  } else {
    fill(0, 0, 0.4);
    rect(0, 0, 4*TILE_SIZE, 4*TILE_SIZE);
    fill(0, 0, 0.7);
    rect(ident, ident, 4*TILE_SIZE - 2*ident, 4*TILE_SIZE - 2*ident);
    rect(ident*2, 0, 4*TILE_SIZE - 4*ident, 4*TILE_SIZE);
    rect(0, ident*2, 4*TILE_SIZE, 4*TILE_SIZE - 4*ident);
  }
}

void draw_inventory(Agent a, int t) {
  noStroke();
  fill(0, 0, 1);
  textSize(1.5*TEXT_SIZE);
  text("INV", 14, 10);
  textSize(TEXT_SIZE);

  pushMatrix();

  translate(0, 36);

  pushMatrix();
  //translate(0, 0);
  draw_powerup_slot(a, POWER_FINS, t);
  translate(TILE_SIZE * 1.5, 0);
  draw_powerup_slot(a, POWER_ROPE, t);
  translate(TILE_SIZE * 1.5, 0);
  draw_powerup_slot(a, POWER_TORCH, t);
  translate(TILE_SIZE * 1.5, 0);
  draw_powerup_slot(a, POWER_KEY, t);
  popMatrix();

  translate(0, 4*TILE_SIZE);
  draw_powerup_slot(a, POWER_BUCKET, t);

  pushMatrix();
  translate(TILE_SIZE * 2, -1.5*TILE_SIZE);
  draw_inv_square(a.inv_water, TILES[TILE_WATER]);
  popMatrix();

  translate(0, 5*TILE_SIZE);
  draw_powerup_slot(a, POWER_SHOVEL, t);

  pushMatrix();
  translate(TILE_SIZE * 2, -1.5*TILE_SIZE);
  draw_inv_square(a.inv_dirt, TILES[TILE_DRY_DIRT]);
  popMatrix();

  translate(0, 5*TILE_SIZE);
  draw_powerup_slot(a, POWER_SATCHEL, t);

  pushMatrix();
  translate(TILE_SIZE * 2, -1.5*TILE_SIZE);
  draw_inv_square(a.inv_seeds, TILES[TILE_VINES]);
  popMatrix();

  popMatrix();
}

void draw_powers(Agent a, int t) {
  noStroke();
  fill(0, 0, 1);
  textSize(1.5*TEXT_SIZE);
  text("USE", 14, 10);
  textSize(TEXT_SIZE);

  pushMatrix();

  translate(30, 30);

  if (SELECTED_POWER == POWER_INVALID) {
    strokeWeight(2);
    stroke(0, 0, 1);
    fill(0, 0, 0);
    rect(-2, -2, TILE_SIZE+4, TILE_SIZE+4); 
    strokeWeight(1);
  }
  noStroke();
  fill(0, 0, 0.25);
  rect(0, 0, TILE_SIZE, TILE_SIZE);

  fill(0, 0, 1.0);
  textSize(TILE_SIZE * 0.9);
  text("!", 0.35*TILE_SIZE, 0.85*TILE_SIZE);
  textSize(TEXT_SIZE);
  translate(0, TILE_SIZE + 36);

  if (SELECTED_POWER == POWER_SATCHEL) {
    strokeWeight(2);
    stroke(0, 0, 1);
    fill(0, 0, 0);
    rect(-2, -2, TILE_SIZE+4, TILE_SIZE+4); 
    strokeWeight(1);
  }
  draw_powerup_slot(a, POWER_SATCHEL, t);
  translate(0, TILE_SIZE + 16);

  if (SELECTED_POWER == POWER_BUCKET) {
    strokeWeight(2);
    stroke(0, 0, 1);
    fill(0, 0, 0);
    rect(-2, -2, TILE_SIZE+4, TILE_SIZE+4); 
    strokeWeight(1);
  }
  draw_powerup_slot(a, POWER_BUCKET, t);
  translate(0, TILE_SIZE + 16);

  if (SELECTED_POWER == POWER_SHOVEL) {
    strokeWeight(2);
    stroke(0, 0, 1);
    fill(0, 0, 0);
    rect(-2, -2, TILE_SIZE+4, TILE_SIZE+4); 
    strokeWeight(1);
  }
  draw_powerup_slot(a, POWER_SHOVEL, t);
  translate(0, TILE_SIZE + 16);

  if (SELECTED_POWER == POWER_PICK) {
    strokeWeight(2);
    stroke(0, 0, 1);
    fill(0, 0, 0);
    rect(-2, -2, TILE_SIZE+4, TILE_SIZE+4); 
    strokeWeight(1);
  }
  draw_powerup_slot(a, POWER_PICK, t);
  translate(0, TILE_SIZE + 16);

  popMatrix();
}

void draw_ai_mode(Agent a) {
  noStroke();
  fill(0, 0, 1);
  textSize(1.5*TEXT_SIZE);
  if (a.AI == AI_NONE) {
    text("AI::NONE", 0, 0);
  } else if (a.AI == AI_FOLLOW_CURSOR) {
    text("AI::FOLLOW_CURSOR", 0, 0);
  } else if (a.AI == AI_EXPLORE_TILES) {
    text("AI::EXPLORE_TILE_TYPES", 0, 0);
  } else if (a.AI == AI_EXPLORE_REGIONS) {
    text("AI::EXPLORE_REGIONS", 0, 0);
  } else if (a.AI == AI_COLLECT_POWERUPS) {
    text("AI::COLLECT_POWERUPS", 0, 0);
  } else if (a.AI == AI_COOPERATE) {
    text("AI::COOPERATE", 0, 0);
  } else if (a.AI == AI_PLAYER_CONTROLLED) {
    text("AI::DIRECT_CONTROL", 0, 0);
  }
  textSize(TEXT_SIZE);
}

void draw_help() {
  noStroke();
  fill(0, 0, 1);
  textSize(1.5*TEXT_SIZE);
  text("CONTROLS", 0, 0);
  textSize(TEXT_SIZE);
  text("a -- select item", 0, 30);
  text("z -- use item", 0, 60);

  text("q -- quit", 0, 120);
  text("p -- pause", 0, 150);
  text("r -- reset the level", 0, 180);
  text("TAB -- switch AI mode", 0, 210);

  if (LOST.AI == AI_PLAYER_CONTROLLED) {
    text("SPACE -- jump", 0, 270);
    text("UP, DOWN, LEFT, RIGHT -- move", 0, 300);
    text("e -- enter doorway", 0, 330);
  } else if (LOST.AI == AI_FOLLOW_CURSOR) {
    text("<mouse> -- set destination", 0, 270);
  }

  text("note: see README.txt for more info", 0, 400);
}

void draw_agent(Agent a, int t) {
  float ft = (t % BUBBLE_LOOP_LENGTH) / (float) BUBBLE_LOOP_LENGTH;
  float s = a.size * TILE_SIZE;
  // TODO: Something fancier!
  pushMatrix();
  translate(a.x * TILE_SIZE, a.y * TILE_SIZE);
  stroke(0, 0, 0);
  if (a.supported(DIR_DOWN)) {
    fill(0, 0, 1);
  } else {
    fill(0, 0, 0.9);
  }
  ellipse(0, 0, s, s);

  // thought bubble:
  noStroke();
  fill(0, 0, 1);
  translate(0, -1.5 * s);
  if (a.vx < 0) {
    translate(0.5 * s, 0);
  } else if (a.vx > 0) {
    translate(-0.5 * s, 0);
  }
  ellipse(
    0,
    0,
    0.25 * s,
    0.25 * s
  );
  if (a.vx < 0) {
    translate(0.3 * s, 0);
  } else if (a.vx > 0) {
    translate(-0.3 * s, 0);
  }
  translate(0, -3 * s);
  ellipse(
    0.5 * s + 0.15 * s * cos(ft*2*PI),
    1.2 * s + 0.2 * s * sin(ft*2*PI),
    2.0 * s,
    1.5 * s
  );
  ellipse(
    -1.3 * s + 0.3 * s * sin(ft*2*PI),
     0.6 * s + 0.2 * s * cos(ft*2*PI),
    2.0 * s,
    1.5 * s
  );
  ellipse(
    1.2 * s + 0.2 * s * sin(ft*2*PI),
    0.4 * s + 0.15 * s * cos(ft*2*PI),
    2.0 * s,
    1.5 * s
  );
  ellipse(
     0.6 * s + 0.15 * s * cos(-ft*2*PI),
    -0.6 * s + 0.25 * s * sin(ft*2*PI),
    2.0 * s,
    1.5 * s
  );
  ellipse(
    -1.0 * s + 0.3 * s * sin(ft*2*PI),
    -0.5 * s + 0.2 * s * cos(-ft*2*PI),
    2.0 * s,
    1.5 * s
  );
  ellipse(
    -0.8 * s + 0.3 * s * sin(-ft*2*PI),
    -0.8 * s + 0.2 * s * cos(-ft*2*PI),
    2.0 * s,
    1.5 * s
  );
  // draw our emote:
  translate(-1.0*s, -1.0*s);
  scale(0.7, 0.7);
  if (a.current_emote == EMOTE_CONFUSED) {
    stroke(0, 0, 0.3);
    fill(0, 0, 0.3);
    text("?", 0.5 * s, 2.6 * s);
  } else if (a.current_emote == EMOTE_CELEBRATE) {
    pushMatrix();
    translate(-1.5*s + -0.1*s*cos(2*ft*2*PI), 3.0*s - 0.1*s*cos(2*ft*2*PI));
    scale(1.0 + 0.05 * cos(2*ft*2*PI));
    strokeWeight(2);
    stroke(0, 0, 0.4);
    fill(0, 0, 0);
    text("\\o/", 0, 0);
    strokeWeight(1);
    popMatrix();
  } else if (a.current_emote == EMOTE_EXPLORE) {
    pushMatrix();
    translate(-1.5*s + -0.1*s*cos(2*ft*2*PI), 3.0*s);
    scale(0.9);
    strokeWeight(2);
    stroke(0, 0, 0.4);
    fill(0, 0, 0);
    text("O_O", 0, 0);
    strokeWeight(1);
    popMatrix();
  } else if (a.current_emote == EMOTE_WANDER) {
    pushMatrix();
    translate(-1.5*s + -0.1*s*cos(2*ft*2*PI), 3.0*s);
    scale(0.9);
    strokeWeight(2);
    stroke(0, 0, 0.4);
    fill(0, 0, 0);
    text("@_@", 0, 0);
    strokeWeight(1);
    popMatrix();
  } else if (a.current_emote == EMOTE_FOLLOW) {
    pushMatrix();
    translate(-1.5*s + -0.1*s*cos(2*ft*2*PI), 3.0*s);
    scale(0.9);
    strokeWeight(2);
    stroke(0, 0, 0.4);
    fill(0, 0, 0);
    text("***", 0, 0);
    strokeWeight(1);
    popMatrix();
  } else if (a.current_emote == EMOTE_CONTROLLED) {
    pushMatrix();
    translate(-1.5*s + -0.1*s*cos(2*ft*2*PI), 3.0*s);
    scale(0.9);
    strokeWeight(2);
    stroke(0, 0, 0.4);
    fill(0, 0, 0);
    text("<->", 0, 0);
    strokeWeight(1);
    popMatrix();
  } else if (a.current_emote == EMOTE_GET_FINS) {
    draw_powerup(POWER_FINS, t);
  } else if (a.current_emote == EMOTE_GET_ROPE) {
    draw_powerup(POWER_ROPE, t);
  } else if (a.current_emote == EMOTE_GET_BUCKET) {
    draw_powerup(POWER_BUCKET, t);
  } else if (a.current_emote == EMOTE_GET_SATCHEL) {
    draw_powerup(POWER_SATCHEL, t);
  } else if (a.current_emote == EMOTE_GET_SHOVEL) {
    draw_powerup(POWER_SHOVEL, t);
  } else if (a.current_emote == EMOTE_GET_PICK) {
    draw_powerup(POWER_PICK, t);
  } else if (a.current_emote == EMOTE_GET_TORCH) {
    draw_powerup(POWER_TORCH, t);
  } else if (a.current_emote == EMOTE_GET_KEY) {
    draw_powerup(POWER_KEY, t);
  } else if (a.current_emote == EMOTE_SEEK_ENTRANCE) {
    draw_powerup(POWER_ENTRANCE, t);
  } else if (a.current_emote == EMOTE_SEEK_EXIT) {
    draw_powerup(POWER_EXIT, t);
  } else if (a.current_emote == EMOTE_TILE_WATER) {
    noStroke();
    fill(TILES[TILE_WATER]);
    rect(-0.5*s, -0.2*s, s*3.8, s*3.8);
  } else if (a.current_emote == EMOTE_TILE_DIRT) {
    noStroke();
    fill(TILES[TILE_DRY_DIRT]);
    rect(-0.5*s, -0.2*s, s*3.8, s*3.8);
  } else if (a.current_emote == EMOTE_TILE_VINE) {
    noStroke();
    fill(TILES[TILE_VINES]);
    rect(-0.5*s, -0.2*s, s*3.8, s*3.8);
  } else if (a.current_emote == EMOTE_TILE_STONE) {
    noStroke();
    fill(TILES[TILE_STONE]);
    rect(-0.5*s, -0.2*s, s*3.8, s*3.8);
  } else if (a.current_emote == EMOTE_TILE_WALL) {
    noStroke();
    fill(TILES[TILE_WALL]);
    rect(-0.5*s, -0.2*s, s*3.8, s*3.8);
  }
  popMatrix();
}

void draw_path(ArrayList<PathIndex> path) {
  int i;
  PathIndex pi;

  if (path == null) {
    // TODO: Draw an X or something here?
    println("No path to target...");
    return;
  }

  for (i = 0; i < path.size(); ++i) {
    pi = path.get(i);
    noFill();
    stroke(0, 0, 1);
    rect(pi.x * TILE_SIZE, pi.y*TILE_SIZE, TILE_SIZE, TILE_SIZE);
  }
}

void debug_vines() {
  fill(0, 0, 1);
  text(
    String.format(
      "vines: %d",
      current_level().vine_lengths[mouse_index().idx()]
    ),
    20,
    20
  );
}

void debug_water() {
  fill(0, 0, 1);
  text(
    String.format("flow: %.12f", current_level().water[mouse_index().idx()]),
    20,
    20
  );
}

void debug_framerate() {
  fill(0, 0, 1);
  text(
    String.format("framerate: %.2f", REAL_FRAMERATE),
    width - 160,
    20
  );
}

void debug_input() {
  fill(0, 0, 1);
  text(
    String.format("INPUT: %x", PLAYER_STEERING),
    20,
    60
  );
}

void debug_lost() {
  noStroke();
  fill(0, 0, 1);
  text(
    String.format("heading: %.3f", LOST.heading),
    20,
    100
  );
  text(
    String.format("speed: %.3f", LOST.speed),
    20,
    120
  );
  stroke(0, 0, 1);
  noFill();
  line(
    50,
    50,
    50 + 50*(LOST.speed / LOST.max_speed) * cos(LOST.heading),
    50 + 50*(LOST.speed / LOST.max_speed) * sin(LOST.heading)
  );
}


void draw() {
  ArrayList<PathIndex> path;
  PathIndex p;
  // Reset:
  background(0.6, 0.8, 0.25);
  stroke(0.0, 0.0, 1.0);
  noFill();

  // Count frames:
  if (TIME_ELAPSED > 0.5) {
    REAL_FRAMERATE = FRAME_COUNT / (float) (TIME_ELAPSED / 1000.0);
    TIME_ELAPSED = 0;
    FRAME_COUNT = 0;
  } else {
    FRAME_COUNT += 1;
    TIME_ELAPSED += millis() - LAST_TIME;
  }
  LAST_TIME = millis();


  // Draw:
  int board_px_width = TILE_SIZE * current_level().width;
  int board_px_height = TILE_SIZE * current_level().height;

  pushMatrix();
  translate((width - board_px_width) / 2, (height - board_px_height) / 2);
  current_level().draw_tiles();
  current_level().draw_powerups(frameCount);
  current_level().draw_shroud();
  draw_agent(LOST, frameCount);

  pushMatrix();
  translate(-10*TILE_SIZE, 90);
  draw_powers(LOST, frameCount);
  translate(0, 300);
  draw_inventory(LOST, frameCount);
  popMatrix();

  pushMatrix();
  translate((current_level().width + 3) * TILE_SIZE, 90);
  draw_ai_mode(LOST);
  translate(0, 150);
  draw_help();
  popMatrix();


  if (LOST.AI == AI_FOLLOW_CURSOR) {
    path = LOST.current_path;
    p = null;
    if (path != null && path.size() > 0) {
      p = path.get(path.size() - 1);
    }
    if (p != null) {
      strokeWeight(2);
      stroke(0, 0, 1, 0.5);
      noFill();
      rect(p.x * TILE_SIZE, p.y * TILE_SIZE, TILE_SIZE, TILE_SIZE);
      strokeWeight(1);
    }
  }
  /*
  // DEBUG DRAW PATH:
  path = LOST.current_path;
  if (path != null) {
    draw_path(path);
  } else {
    stroke(0, 1, 1);
    noFill();
    line(
      (float) (LOST.x - 0.5) * TILE_SIZE, (float) (LOST.y - 0.5) * TILE_SIZE,
      (float) (LOST.x + 0.5) * TILE_SIZE, (float) (LOST.y + 0.5) * TILE_SIZE
    );
    line(
      (float) (LOST.x - 0.5) * TILE_SIZE, (float) (LOST.y + 0.5) * TILE_SIZE,
      (float) (LOST.x + 0.5) * TILE_SIZE, (float) (LOST.y - 0.5) * TILE_SIZE
    );
  }
  // */
  popMatrix();


  /*
  debug_water();
  //debug_vines();
  debug_framerate();
  debug_input();
  debug_lost();
  */

  // Update:
  if (!PAUSED) {
    if (frameCount % UPDATE_RATE == 0) {
      current_level().update_cells();
    }
    LOST.update(1.0 / (float) FRAME_RATE);
  }

  // Climbing up/down levels:
  if (DO_CLIMB_UP) {
    DO_CLIMB_UP = false;
    load_previous_level();
  }
  if (DO_CLIMB_DOWN) {
    DO_CLIMB_DOWN = false;
    load_next_level();
  }
}

Level current_level() {
  if (CURRENT_LEVEL >= 0 && CURRENT_LEVEL < ALL_LEVELS.size()) {
    return ALL_LEVELS.get(CURRENT_LEVEL);
  } else {
    return null;
  }
}

/*
void save_current_level() {
  Level l;
  while (CURRENT_LEVEL <= ALL_LEVELS.size()) {
    l = new Level(BOARD_WIDTH, BOARD_HEIGHT);
    ALL_LEVELS.add(l);
  }
  ALL_LEVELS.get(CURRENT_LEVEL).save();
}
*/

void load_previous_level() {
  Level l;
  CURRENT_LEVEL -= 1;
  while (CURRENT_LEVEL < 0) {
    CURRENT_LEVEL += 1;
    l = new Level(BOARD_WIDTH, BOARD_HEIGHT);
    generate_level(l, LOST, false);
    ALL_LEVELS.add(0, l);
  }

  // reset player state:
  LOST.set_current_task(TASK_DECIDE_NEXT_TASK, 0);
  LOST.add_powerup(POWER_KEY);
  SELECTED_POWER = POWER_INVALID;
  current_level().place_agent_at_exit(LOST);
}

void load_next_level() {
  Level l;
  CURRENT_LEVEL += 1;
  while (CURRENT_LEVEL >= ALL_LEVELS.size()) {
    l = new Level(BOARD_WIDTH, BOARD_HEIGHT);
    generate_level(l, LOST, true);
    ALL_LEVELS.add(l);
  }

  // reset player state:
  LOST.set_current_task(TASK_DECIDE_NEXT_TASK, 0);
  LOST.remove_powerup(POWER_KEY);
  SELECTED_POWER = POWER_INVALID;
  current_level().place_agent_at_entrance(LOST);
}

void reset_game() {
  LOST.set_current_task(TASK_DECIDE_NEXT_TASK, 0);
  LOST.remove_powerup(POWER_KEY);
  SELECTED_POWER = POWER_INVALID;
  LOST.clear_powerups();
  LOST.clear_inventory();
  ALL_LEVELS = new ArrayList<Level>();
  CURRENT_LEVEL = -1;
  load_next_level();
}

void select_next_power() {
  SELECTED_POWER += 1;
  if (SELECTED_POWER > POWER_INVALID) {
    SELECTED_POWER = POWER_NONE;
  }
  while (!LOST.can_use(SELECTED_POWER) && SELECTED_POWER < POWER_INVALID) {
    SELECTED_POWER += 1;
  }
}

void keyPressed() {
  if (key == 'q') {
    exit();
  } else if (key == 'r') {
    reset_game();
  } else if (key == 'p') {
    PAUSED = !PAUSED;
  } else if (key == '\t') {
    if (LOST.AI == AI_PLAYER_CONTROLLED) {
      LOST.AI = AI_FOLLOW_CURSOR;
    } else if (LOST.AI == AI_FOLLOW_CURSOR) {
      LOST.AI = AI_COOPERATE;
    } else if (LOST.AI == AI_COOPERATE) {
      LOST.AI = AI_PLAYER_CONTROLLED;
    }
  } else if (key == '\\') {
    LOST.AI -= 1;
    if (LOST.AI < 0) {
      LOST.AI = AI_PLAYER_CONTROLLED;
    }
  } else if (key == 'a') {
    // key 1: select power to use:
    select_next_power();
  } else if (key == 'z') {
    // key 2: use selected power:
    PLAYER_USE_POWER = true;
  } else if (key == 'e') {
    LOST.climb_up();
    LOST.climb_down();
  } else if (key == ' ') {
    PLAYER_DO_JUMP = true;
  } else if (key == CODED) {
    if (keyCode == UP) {
      PLAYER_STEERING |= DIR_UP;
    } else if (keyCode == RIGHT) {
      PLAYER_STEERING |= DIR_RIGHT;
    } else if (keyCode == DOWN) {
      PLAYER_STEERING |= DIR_DOWN;
    } else if (keyCode == LEFT) {
      PLAYER_STEERING |= DIR_LEFT;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      PLAYER_STEERING &= ~DIR_UP;
    } else if (keyCode == RIGHT) {
      PLAYER_STEERING &= ~DIR_RIGHT;
    } else if (keyCode == DOWN) {
      PLAYER_STEERING &= ~DIR_DOWN;
    } else if (keyCode == LEFT) {
      PLAYER_STEERING &= ~DIR_LEFT;
    }
  }
}
