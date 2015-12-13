// vim: syn=java

import java.util.Collections;

import perlin.*;

Perlin pnl = new Perlin(this);

int INITIAL_SETTLE_TIME = 1000;

//double EVAPORATION_THRESHOLD = 0.001;
double EVAPORATION_THRESHOLD = 0.00001;
double LIQUID_DISPLAY_THRESHOLD = 0.015;

float AI_CLOCK_MAX = 3600.0;
float AI_SLOW_UPDATE_DURATION = 0.3;
float AI_PAUSE_FREQUENCY = 0.01;
float AI_PAUSE_DURATION = 0.3;

float VEL_DRIFT_THRESHOLD = 0.05;

float SUPPORT_FUDGE_FACTOR = 0.005;
float COLLISION_OFFSET = 0.0001;

float JUMP_IMPULSE = 26.0;
float JUMP_COOLDOWN = 0.2;

float DEFAULT_MAX_SPEED = 15.0;

float WADE_ACCEL = 0.4;
float SWIM_ACCEL = 0.4;
float CLIMB_ACCEL = 0.8;
float WALK_ACCEL = 0.6;
float JUMP_ACCEL = 0.2;

float WADE_SPEED = 0.7;
float SWIM_SPEED = 0.8;
float CLIMB_SPEED = 0.7;

float GRAVITY = 180.0;
float SWIM_GRAVITY = 50.0;


float DEFAULT_SIZE = 0.3;

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

int N_TILES = 8;
//int TILE_SIZE = 6;
int TILE_SIZE = 16;
//int TILE_SIZE = 128;

color TILES[];

//int BOARD_WIDTH = 128;
//int BOARD_HEIGHT = 128;
int BOARD_WIDTH = 54;
int BOARD_HEIGHT = 54;
//int BOARD_WIDTH = 8;
//int BOARD_HEIGHT = 8;

int BOARD[];
int NEXT[];
double WATER_FLOW[];
double ORANGE_FLOW[];
double FLUX[];
int VINE_LENGTH[];

Agent LOST;

float JUMP_PATH_PENALTY = 0.1;
float FALL_PATH_PENALTY = 0.2;

float PATH_MEDIATION = 0.0;

double MAX_COMPRESSED_FLOW = 1.1;
double FLOW_BALANCING_SPEED = 0.99;

int MAX_VINE_LENGTH = 6;

int TILE_EMPTY = 0;
int TILE_WATER = 1;
int TILE_VINES = 2;
int TILE_DIRT = 3;
int TILE_STONE = 4;
int TILE_FIRE = 5;
int TILE_MAGIC = 6;
int TILE_WALL = 7;

int MOV_BLOCKED = 0;
int MOV_NORMAL = 1;
int MOV_WADE = 2;
int MOV_SWIM = 3;
int MOV_CLIMB = 4;

int AI_NONE = 0;
int AI_FOLLOW_CURSOR = 1;
int AI_PLAYER_CONTROLLED = 2;

int TASK_NONE = 0;
int TASK_DECIDE_NEXT_TASK = 1;
int TASK_GET_WATER = 2;
int TASK_GET_SEED = 3;
int TASK_DIG_DIRT = 4;
int TASK_DIG_STONE = 5;

int POWER_NONE = 0;
int POWER_CLIMB = 1;
int POWER_SHOVEL = 2;
int POWER_PICK = 3;
int POWER_BUCKET = 4;
int POWER_SATCHEL = 5;

int DIR_UP = 1;
int DIR_RIGHT = 2;
int DIR_DOWN = 4;
int DIR_LEFT = 8;

int PLAYER_STEERING = 0;
boolean PLAYER_DO_JUMP = false;

float pnoise(float x, float y) {
  float[] xy = new float[2];
  xy[0] = x;
  xy[1] = y;
  return pnl.noise2(xy);
}

float pnoise(float x, float y, float z) {
  float[] xyz = new float[3];
  xyz[0] = x;
  xyz[1] = y;
  xyz[2] = z;
  float result = pnl.noise3(xyz);
  if (result < -1.0 || result > 1.0) { println("Bad result: ", result); }
  return result;
}

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
  Index(int x, int y) {
    while (x < 0) { x += BOARD_WIDTH; }
    while (x >= BOARD_WIDTH) { x -= BOARD_WIDTH; }
    while (y < 0) { y += BOARD_HEIGHT; }
    while (y >= BOARD_HEIGHT) { y -= BOARD_HEIGHT; }
    this.x = x;
    this.y = y;
  }

  Index(float x, float y) {
    while (x < 0) { x += BOARD_WIDTH; }
    while (x >= BOARD_WIDTH) { x -= BOARD_WIDTH; }
    while (y < 0) { y += BOARD_HEIGHT; }
    while (y >= BOARD_HEIGHT) { y -= BOARD_HEIGHT; }
    this.x = (int) x;
    this.y = (int) y;
  }

  Index(Index o) {
    this.x = o.x;
    this.y = o.y;
  }

  Index clone() {
    return new Index(this.x, this.y);
  }

  @Override
  public boolean equals(Object o) {
    return (
       o != null
    && o instanceof Index
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
      return new Index(this.x, this.y - 1);
    } else if (direction == DIR_RIGHT) {
      return new Index(this.x + 1, this.y);
    } else if (direction == DIR_DOWN) {
      return new Index(this.x, this.y + 1);
    } else if (direction == DIR_LEFT) {
      return new Index(this.x - 1, this.y);
    }
    println("Error: bad direction in Index.neighbor: ", direction);
    return new Index(0, 0);
  }

  Index nearest_holo(Index o) {
    float best = this.dist_to(o);
    Index candidate = this;
    Index holo_up = this.clone();
    Index holo_right = this.clone();
    Index holo_down = this.clone();
    Index holo_left = this.clone();
    holo_up.y -= BOARD_HEIGHT;
    holo_right.x += BOARD_WIDTH;
    holo_down.y += BOARD_HEIGHT;
    holo_left.x -= BOARD_WIDTH;
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
    return this.x + BOARD_WIDTH * this.y;
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
}

class PathIndex extends Index implements Comparable<PathIndex> {
  float pathCost;
  float heurCost;
  PathIndex from;
  PathIndex(int x, int y, float pathCost, float heurCost, PathIndex from) {
    super(x, y);
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

  boolean same_place(Index o) {
    return this.x == o.x && this.y == o.y;
  }

  int path_match_in(ArrayList<PathIndex> list) {
    int i;
    for (i = 0; i < list.size(); ++i) {
      if (this.same_place(list.get(i))) {
        return i;
      }
    }
    return -1;
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

class Agent {
  public float x, y;
  public float vx, vy;
  public float speed, heading;
  public float max_speed;
  public float size;
  public int AI;
  public float clock;
  public float last_jump;
  public float pause_cooldown;
  public ArrayList<PathIndex> current_path;
  public int path_index;
  public PathIndex jump_target;
  public int current_task;
  public ArrayList<Integer> powerups;
  Agent(float x, float y, float max_speed, float size, int AI) {
    if (x < 0) { x = 0; }
    if (x > BOARD_WIDTH) { x = BOARD_WIDTH; }
    if (y < 0) { y = 0; }
    if (y > BOARD_HEIGHT) { y = BOARD_HEIGHT; }
    this.x = x;
    this.y = y;
    this.vx = 0;
    this.vy = 0;
    this.speed = 0;
    this.heading = 0;
    this.max_speed = max_speed;
    this.size = size;
    this.AI = AI;
    this.clock = 0;
    this.last_jump = -1;
    this.pause_cooldown = 0;
    this.current_path = null;
    this.path_index = 0;
    this.jump_target = null;
    this.current_task = TASK_NONE;
    this.powerups = new ArrayList<Integer>();
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
    this.AI = o.AI;
    this.clock = o.clock;
    this.last_jump = o.last_jump;
    this.pause_cooldown = o.pause_cooldown;
    for (i = 0; i < o.current_path.size(); ++i) {
      this.current_path.add(o.current_path.get(i));
    }
    this.path_index = o.path_index;
    this.jump_target = o.jump_target;
    this.current_task = o.current_task;
    for (i = 0; i < o.powerups.size(); ++i) {
      this.powerups.add(o.powerups.get(i));
    }
  }

  Agent clone() {
    return new Agent(this);
  }

  Index center() {
    return new Index((int) this.x, (int) this.y);
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
  }

  float dist_to_center(Index i) {
    return sqrt(
      pow((float) (i.x + 0.5 - this.x), 2.0)
    + pow((float) (i.y + 0.5 - this.y), 2.0)
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
      return MOV_SWIM;
    } else if (tile == TILE_VINES) {
      return MOV_CLIMB;
    } else if (
       tile == TILE_DIRT
    || tile == TILE_STONE
    || tile == TILE_WALL
    ) {
      return MOV_BLOCKED;
    }
    println("ERROR: Invalid tile in Agent.movement_on\n");
    return MOV_BLOCKED;
  }

  int movement_mode(int direction) {
    Index c = this.center();
    if (this.dist_from_edge(direction) <= this.size) {
      return this.movement_on(BOARD[c.neighbor(direction).idx()]);
    } else {
      return this.movement_on(BOARD[c.idx()]);
    }
  }

  boolean supported(int direction) {
    Index c = this.center();
    int mov;
    boolean result = false;
    if (this.dist_from_edge(direction) <= this.size + SUPPORT_FUDGE_FACTOR) {
      mov = this.movement_on(BOARD[c.neighbor(direction).idx()]);
      if (
         mov == MOV_BLOCKED
      || mov == MOV_CLIMB
      ) {
        result = true;
      }
    }
    mov = this.movement_on(BOARD[c.idx()]);
    if (
       mov == MOV_SWIM
    || mov == MOV_CLIMB
    ) {
      result = true;
    }
    return result;
  }

  Index find_nearby(int tile) {
    ArrayList<Index> open = new ArrayList<Index>();
    ArrayList<Index> closed = new ArrayList<Index>();
    open.add(this.center().clone());
    Index here, consider;
    while (open.size() > 0) {
      here = open.remove(0);
      if (BOARD[here.idx()] == tile) {
        // we found one!
        return here;
      }
      // If we can go through a space, add is neighbors:
      if (this.movement_on(BOARD[here.idx()]) != MOV_BLOCKED) {
        consider = here.neighbor(DIR_UP);
        if (consider.match_in(open) != -1 || consider.match_in(closed) != -1) {
          open.add(consider);
        }
        consider = here.neighbor(DIR_RIGHT);
        if (consider.match_in(open) != -1 || consider.match_in(closed) != -1) {
          open.add(consider);
        }
        consider = here.neighbor(DIR_DOWN);
        if (consider.match_in(open) != -1 || consider.match_in(closed) != -1) {
          open.add(consider);
        }
        consider = here.neighbor(DIR_LEFT);
        if (consider.match_in(open) != -1 || consider.match_in(closed) != -1) {
          open.add(consider);
        }
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
    int mov = this.movement_on(BOARD[here.idx()]);
    int mov_alt;
    Index cndt;
    PathIndex nbr;
    ArrayList<PathIndex> neighbors = new ArrayList<PathIndex>();
    if (mov == MOV_BLOCKED) {
      return;
    } else if (
       mov == MOV_SWIM
    || mov == MOV_CLIMB
    ) {
      add_candidate(neighbors, here.neighbor(DIR_UP), dest, here, 1);
      add_candidate(neighbors, here.neighbor(DIR_DOWN), dest, here, 1);
      add_candidate(neighbors, here.neighbor(DIR_LEFT), dest, here, 1);
      add_candidate(neighbors, here.neighbor(DIR_RIGHT), dest, here, 1);
      // Jumping upwards:
      mov = this.movement_on(BOARD[here.neighbor(DIR_UP).idx()]);
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
          BOARD[here.neighbor(DIR_UP).neighbor(DIR_UP).idx()]
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
      mov = this.movement_on(BOARD[here.neighbor(DIR_DOWN).idx()]);
      if (
         mov == MOV_BLOCKED
      || mov == MOV_CLIMB
      ) { // supported: we can jump from here
        // (restricted) Jumping possibilities:
        add_candidate(neighbors, here.neighbor(DIR_UP), dest, here, 1);
        mov = this.movement_on(BOARD[here.neighbor(DIR_UP).idx()]);
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
            BOARD[here.neighbor(DIR_UP).neighbor(DIR_UP).idx()]
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
              BOARD[here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_RIGHT)
                .idx()]
            );
            mov_alt = this.movement_on(
              BOARD[here.neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()]
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
              BOARD[here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_LEFT)
                .idx()]
            );
            mov_alt = this.movement_on(
              BOARD[here.neighbor(DIR_UP).neighbor(DIR_LEFT).idx()]
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
            BOARD[here.neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()]
          );
          mov_alt = this.movement_on(
            BOARD[
              here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()
            ]
          );
          if (mov == MOV_NORMAL && mov_alt == MOV_NORMAL) {
            mov = this.movement_on(
              BOARD[here.neighbor(DIR_UP).neighbor(DIR_RIGHT)
                .neighbor(DIR_RIGHT).idx()]
            );
            if (mov == MOV_NORMAL) {
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
            BOARD[here.neighbor(DIR_UP).neighbor(DIR_LEFT).idx()]
          );
          mov_alt = this.movement_on(
            BOARD[
              here.neighbor(DIR_UP).neighbor(DIR_UP).neighbor(DIR_LEFT).idx()
            ]
          );
          if (mov == MOV_NORMAL && mov_alt == MOV_NORMAL) {
            mov = this.movement_on(
              BOARD[here.neighbor(DIR_UP).neighbor(DIR_LEFT).neighbor(DIR_LEFT)
                .idx()]
            );
            if (mov == MOV_NORMAL) {
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
        add_candidate(neighbors, here.neighbor(DIR_DOWN), dest, here, 1);
      }
    }

    // Add all detected neighbors to our open list:
    for (i = 0; i < neighbors.size(); ++i) {
      nbr = neighbors.get(i);
      match = nbr.path_match_in(closed);
      if (match != -1) {
        if (nbr.cost() < closed.get(match).cost()) {
          closed.get(match).pathCost = nbr.pathCost; // use the better path
          closed.get(match).heurCost = nbr.heurCost;
          closed.get(match).from = nbr.from;
        } else {
          continue; // skip this one
        }
      }
      match = nbr.path_match_in(open);
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

  // Sets our heading and speed to follow our current path.
  float follow_path() {
    int tile, tile_next;
    PathIndex next;
    Index holo;
    float do_jump = 0.0;
    // Follow our current path or jump target:
    tile = BOARD[this.center().idx()];
    tile_next = BOARD[this.center().neighbor(DIR_DOWN).idx()];
    if (this.current_path == null || this.current_path.size() <= 1) {
      // stop if we have no path or have arrived:
      this.speed = 0;
    } else if (
       this.jump_target != null
    && this.movement_on(tile) == MOV_NORMAL
    && this.movement_on(tile_next) == MOV_NORMAL
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
      && this.movement_on(tile_next) == MOV_NORMAL
      ) {
        // we're airborne: no need to accelerate downwards...
        this.steer_towards_horiz(holo.x + 0.5);
      } else { // just go towards the center of the next cell:
        this.steer_towards(holo.x + 0.5, holo.y + 0.5);
      }
      tile = BOARD[this.center().idx()];
      tile_next = BOARD[next.idx()];
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
         && this.movement_on(BOARD[next.idx()]) == MOV_NORMAL
         && (
               this.movement_on(tile) == MOV_SWIM
            || this.movement_on(tile) == MOV_CLIMB
            )
         )
      ) {
        // this is a jump...
        this.jump_target = next.clone();
        if (
           abs(this.x - (this.center().x + 0.5)) < 0.1
        && this.supported(DIR_DOWN)
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
            do_jump = 0.75;
          } else {
            do_jump = 1.0;
          }
        } else {
          this.steer_towards(this.center().x + 0.5, this.center().y + 0.8);
        }
      } else {
        // we're not jumping atm:
        this.jump_target = null;
      }
    }
    return do_jump;
  }

  void mediate_path_following(float dt) {
    float nx, ny;
    float ns, nh;
    float slowdown;
    PathIndex next;
    if (this.current_path == null || this.current_path.size() <= 1) {
      // no mediation necessary
      return;
    }
    next = this.current_path.get(1);
    nx = this.x - this.speed * dt * cos(this.heading);
    ny = this.y - this.speed * dt * sin(this.heading);
    nh = atan2(
      -(next.nearest_holo(this.center()).y + 0.5 - this.y),
      -(next.nearest_holo(this.center()).x + 0.5 - this.x)
    );
    slowdown = 0.2 + 0.8 * (1 + cos(angle_between(this.heading, nh))) / 2.0;
    this.heading = (
      this.heading
    + PATH_MEDIATION * angle_between(this.heading, nh)
    );
    this.speed *= slowdown;
  }

  void update(float dt) {
    float d_vx, d_vy;
    float new_x, new_y;
    float new_left, new_top, new_right, new_bot;
    Index here;
    int dir;
    boolean can_jump = false;
    float do_jump = 0.0;
    boolean due_slow_update = false;

    this.clock += dt;
    if (this.clock > AI_CLOCK_MAX) {
      this.clock -= AI_CLOCK_MAX;
    }

    if (
       floor(this.clock / AI_SLOW_UPDATE_DURATION)
    != floor((this.clock - dt) / AI_SLOW_UPDATE_DURATION)
    ) {
      due_slow_update = true;
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

    // steer:
    if (this.AI == AI_NONE) {
      this.speed = 0;
      // heading is unchanged
    } else if (this.AI == AI_FOLLOW_CURSOR) {
      // if we're at the goal destroy our current path:
      if (this.center().equals(mouse_index())) {
        this.current_path = null;
      }

      if (
         ( // every AI_SLOW_UPDATE_DURATION seconds or if we're off-path:
            due_slow_update
         || this.current_path == null
         || !this.current_path.get(this.path_index).same_place(this.center())
         )
      && this.supported(DIR_DOWN) // but only if we're supported
      ) {
        // update our path...
        this.current_path = this.path_to(mouse_index());
        this.path_index = 0;
      }

      if (random(1.0) < AI_PAUSE_FREQUENCY) {
        this.pause_cooldown = AI_PAUSE_DURATION;
      }

      if (this.pause_cooldown == 0) {
        do_jump = this.follow_path();
      } else {
        this.recenter();
        do_jump = 0.0;
      }
      this.mediate_path_following(dt);
    } else if (this.AI == AI_PLAYER_CONTROLLED) {
      d_vx = 0;
      d_vy = 0;
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
    if (this.movement_mode(dir) == MOV_BLOCKED) {
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
      if (this.vy > 0) {
        this.vy = (1 - WADE_ACCEL) * this.vy + WADE_ACCEL * d_vy * WADE_SPEED;
      }
      this.vy += SWIM_GRAVITY * dt;
    } else if (this.movement_mode(dir) == MOV_SWIM) {
      this.vx = (1 - SWIM_ACCEL) * this.vx + SWIM_ACCEL * d_vx * SWIM_SPEED;
      this.vy = (1 - SWIM_ACCEL) * this.vy + SWIM_ACCEL * d_vy * SWIM_SPEED;
      this.vy += SWIM_GRAVITY * dt;
    } else if (this.movement_mode(dir) == MOV_CLIMB) {
      this.vx = (1 - CLIMB_ACCEL) * this.vx + CLIMB_ACCEL * d_vx * CLIMB_SPEED;
      this.vy = (1 - CLIMB_ACCEL) * this.vy + CLIMB_ACCEL * d_vy * CLIMB_SPEED;
      // no gravity
    } else if (this.movement_mode(dir) == MOV_NORMAL) {
      if (this.supported(DIR_DOWN)) {
        this.vx = (1 - WALK_ACCEL) * this.vx + WALK_ACCEL * d_vx;
        if (d_vy > 0) {
          this.vy = (1 - WALK_ACCEL) * this.vy + WALK_ACCEL * d_vy;
        } // only downwards vy is applied in MOV_NORMAL mode...
      } else {
        this.vx = (1 - JUMP_ACCEL) * this.vx + JUMP_ACCEL * d_vx;
        // no vy is applied while not supported
        this.vy += GRAVITY * dt;
      }
    }
    if (this.supported(DIR_DOWN) && can_jump && do_jump > 0) {
      this.vy -= JUMP_IMPULSE * do_jump;
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
    && this.movement_on(BOARD[here.neighbor(DIR_UP).idx()]) == MOV_BLOCKED
    ) {
      new_y = here.y + this.size + COLLISION_OFFSET;
      if (this.vy < 0) { this.vy = 0; }
    }
    if (
       new_bot > here.y + 1
    && this.movement_on(BOARD[here.neighbor(DIR_DOWN).idx()]) == MOV_BLOCKED
    ) {
      new_y = here.y + 1 - this.size - COLLISION_OFFSET;
      if (this.vy > 0) { this.vy = 0; }
    }
    if (
       new_left < here.x
    && this.movement_on(BOARD[here.neighbor(DIR_LEFT).idx()]) == MOV_BLOCKED
    ) {
      new_x = here.x + this.size + COLLISION_OFFSET;
      if (this.vx < 0) { this.vx = 0; }
    }
    if (
       new_right > here.x + 1
    && this.movement_on(BOARD[here.neighbor(DIR_RIGHT).idx()]) == MOV_BLOCKED
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
    && this.movement_on(
         BOARD[here.neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()]
       ) == MOV_BLOCKED
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
    && this.movement_on(
         BOARD[here.neighbor(DIR_UP).neighbor(DIR_LEFT).idx()]
       ) == MOV_BLOCKED
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
    && this.movement_on(
         BOARD[here.neighbor(DIR_DOWN).neighbor(DIR_RIGHT).idx()]
       ) == MOV_BLOCKED
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
    && this.movement_on(
         BOARD[here.neighbor(DIR_DOWN).neighbor(DIR_LEFT).idx()]
       ) == MOV_BLOCKED
    ) {
      if (here.x - new_left > new_bot - here.y + 1) {
        new_y = here.y + 1 - this.size;
        if (this.vy > 0) { this.vy = 0; }
      } else {
        new_x = here.x + this.size;
        if (this.vx < 0) { this.vx = 0; }
      }
    }

    this.x = new_x;
    this.y = new_y;

    // re-wrap coordinates:
    while (this.x < 0) { this.x += BOARD_WIDTH; }
    while (this.x > BOARD_WIDTH) { this.x -= BOARD_WIDTH; }
    while (this.y < 0) { this.y += BOARD_HEIGHT; }
    while (this.y > BOARD_HEIGHT) { this.y -= BOARD_HEIGHT; }
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

boolean any_touching(Index i, int tile) {
  if (BOARD[i.neighbor(DIR_UP).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(DIR_RIGHT).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(DIR_DOWN).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(DIR_LEFT).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()] == tile) {
    return true;
  }
  if (BOARD[i.neighbor(DIR_RIGHT).neighbor(DIR_DOWN).idx()] == tile) {
    return true;
  }
  if (BOARD[i.neighbor(DIR_DOWN).neighbor(DIR_LEFT).idx()] == tile) {
    return true;
  }
  if (BOARD[i.neighbor(DIR_LEFT).neighbor(DIR_UP).idx()] == tile) {
    return true;
  }
  return false;
}

int count_touching(Index i, int tile) {
  int result = 0;
  if (BOARD[i.neighbor(DIR_UP).idx()] == tile) { result += 1; }
  if (BOARD[i.neighbor(DIR_RIGHT).idx()] == tile) { result += 1; }
  if (BOARD[i.neighbor(DIR_DOWN).idx()] == tile) { result += 1; }
  if (BOARD[i.neighbor(DIR_LEFT).idx()] == tile) { result += 1; }
  if (BOARD[i.neighbor(DIR_UP).neighbor(DIR_RIGHT).idx()] == tile) {
    result += 1;
  }
  if (BOARD[i.neighbor(DIR_RIGHT).neighbor(DIR_DOWN).idx()] == tile) {
    result += 1;
  }
  if (BOARD[i.neighbor(DIR_DOWN).neighbor(DIR_LEFT).idx()] == tile) {
    result += 1;
  }
  if (BOARD[i.neighbor(DIR_LEFT).neighbor(DIR_UP).idx()] == tile) {
    result += 1;
  }
  return result;
}

boolean any_adjacent(Index i, int tile) {
  if (BOARD[i.neighbor(DIR_UP).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(DIR_RIGHT).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(DIR_DOWN).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(DIR_LEFT).idx()] == tile) { return true; }
  return false;
}

int count_adjacent(Index i, int tile) {
  int result = 0;
  if (BOARD[i.neighbor(DIR_UP).idx()] == tile) { result += 1; }
  if (BOARD[i.neighbor(DIR_RIGHT).idx()] == tile) { result += 1; }
  if (BOARD[i.neighbor(DIR_DOWN).idx()] == tile) { result += 1; }
  if (BOARD[i.neighbor(DIR_LEFT).idx()] == tile) { result += 1; }
  return result;
}

void set_next(Index i, int tile) {
  if (NEXT[i.idx()] < tile) {
    NEXT[i.idx()] = tile;
  }
}

void clone_to_next() {
  int i;
  for (i = 0; i < BOARD_WIDTH * BOARD_HEIGHT; ++i) {
    NEXT[i] = BOARD[i];
  }
}

void swap_from_next() {
  int i;
  for (i = 0; i < BOARD_WIDTH * BOARD_HEIGHT; ++i) {
    BOARD[i] = NEXT[i];
  }
}

void update_cells() {
  update_water();
  grow_vines();
}

void update_water() {
  Index i = new Index(0, 0);
  double flow_here, balance_level, space_above;
  double surplus, surplus_left, surplus_right;
  for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
    for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
      if (BOARD[i.idx()] > TILE_WATER && WATER_FLOW[i.idx()] > 0) {
        /*
        println(
          "WARNING: lost", String.format("%.12f", WATER_FLOW[i.idx()]),
          "flow in block:", BOARD[i.idx()],
          "at", i.x, ",", i.y
        );
        */
        WATER_FLOW[i.idx()] = 0.0;
      }
      FLUX[i.idx()] = 0.0;
    }
  }
  // First pass: flow downwards
  for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
    for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
      flow_here = WATER_FLOW[i.idx()];
      if (
         flow_here > 0
      && BOARD[i.neighbor(DIR_DOWN).idx()] <= TILE_WATER
      ) { // can flow down
        if (
          flow_here + WATER_FLOW[i.neighbor(DIR_DOWN).idx()]
        < MAX_COMPRESSED_FLOW
        ) {
          FLUX[i.idx()] -= flow_here;
          FLUX[i.neighbor(DIR_DOWN).idx()] += flow_here;
        } else {
          balance_level = (
            flow_here
          + WATER_FLOW[i.neighbor(DIR_DOWN).idx()]
          - MAX_COMPRESSED_FLOW
          );
          FLUX[i.idx()] -= flow_here - balance_level;
          FLUX[i.neighbor(DIR_DOWN).idx()] += flow_here - balance_level;
        }
      }
    }
  }
  for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
    for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
      WATER_FLOW[i.idx()] += FLUX[i.idx()];
      FLUX[i.idx()] = 0.0;
    }
  }
  // Second pass: flow side-to-side
  for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
    for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
      flow_here = WATER_FLOW[i.idx()];
      if (
         BOARD[i.neighbor(DIR_DOWN).idx()] <= TILE_WATER
      && WATER_FLOW[i.neighbor(DIR_DOWN).idx()] < 1.0
      ) {
        // liquid can continue to flow downwards next step: no need to spread
        continue;
      }
      if ( // flow left but not right
         BOARD[i.neighbor(DIR_LEFT).idx()] <= TILE_WATER
      && WATER_FLOW[i.neighbor(DIR_LEFT).idx()] < flow_here
      && (
            BOARD[i.neighbor(DIR_RIGHT).idx()] > TILE_WATER
         || WATER_FLOW[i.neighbor(DIR_RIGHT).idx()] >= flow_here
         )
      ) {
        balance_level = (flow_here+WATER_FLOW[i.neighbor(DIR_LEFT).idx()]) /2.0;
        FLUX[i.idx()] += FLOW_BALANCING_SPEED * (balance_level - flow_here);
        FLUX[i.neighbor(DIR_LEFT).idx()] += FLOW_BALANCING_SPEED * (
          flow_here
        - balance_level
        );
      } else if ( // flow right but not left
         BOARD[i.neighbor(DIR_RIGHT).idx()] <= TILE_WATER
      && WATER_FLOW[i.neighbor(DIR_RIGHT).idx()] < flow_here
      && (
            BOARD[i.neighbor(DIR_LEFT).idx()] > TILE_WATER
         || WATER_FLOW[i.neighbor(DIR_LEFT).idx()] >= flow_here
         )
      ) {
        balance_level = (flow_here+WATER_FLOW[i.neighbor(DIR_RIGHT).idx()])/2.0;
        FLUX[i.idx()] += FLOW_BALANCING_SPEED * (balance_level - flow_here);
        FLUX[i.neighbor(DIR_RIGHT).idx()] += FLOW_BALANCING_SPEED * (
          flow_here
        - balance_level
        );
      } else if ( // flow both left and right
         BOARD[i.neighbor(DIR_RIGHT).idx()] <= TILE_WATER
      && WATER_FLOW[i.neighbor(DIR_RIGHT).idx()] < flow_here
      && BOARD[i.neighbor(DIR_LEFT).idx()] <= TILE_WATER
      && WATER_FLOW[i.neighbor(DIR_LEFT).idx()] < flow_here
      ) {
        surplus = flow_here - (
          flow_here
        + WATER_FLOW[i.neighbor(DIR_LEFT).idx()]
        + WATER_FLOW[i.neighbor(DIR_RIGHT).idx()]
        ) / 3.0;
        surplus_left = flow_here - WATER_FLOW[i.neighbor(DIR_LEFT).idx()];
        surplus_right = flow_here - WATER_FLOW[i.neighbor(DIR_RIGHT).idx()];
        FLUX[i.idx()] -= surplus * FLOW_BALANCING_SPEED;
        FLUX[i.neighbor(DIR_LEFT).idx()] += (
          surplus
        * FLOW_BALANCING_SPEED
        * (surplus_left / (surplus_left + surplus_right))
        );
        FLUX[i.neighbor(DIR_RIGHT).idx()] += (
          surplus
        * FLOW_BALANCING_SPEED
        * (surplus_right / (surplus_left + surplus_right))
        );
      } // else trapped; no flux
    }
  }
  for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
    for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
      WATER_FLOW[i.idx()] += FLUX[i.idx()];
      FLUX[i.idx()] = 0.0;
    }
  }
  // Third pass: spring back up where compressed:
  for (i.y = BOARD_HEIGHT - 1; i.y > -1; --i.y) {
    for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
      flow_here = WATER_FLOW[i.idx()];
      surplus = flow_here - 1.0;
      if (BOARD[i.neighbor(DIR_UP).idx()] <= TILE_WATER && surplus > 0) {
        space_above = (
          1.0
        + ((flow_here - 1.0) * 0.5)
        - WATER_FLOW[i.neighbor(DIR_UP).idx()]
        );
        if (space_above > 0) {
          if (space_above < surplus) {
            FLUX[i.idx()] -= space_above;
            FLUX[i.neighbor(DIR_UP).idx()] += space_above;
          } else {
            FLUX[i.idx()] -= surplus;
            FLUX[i.neighbor(DIR_UP).idx()] += surplus;
          }
        }
      }
    }
  }
  for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
    for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
      WATER_FLOW[i.idx()] += FLUX[i.idx()];
      FLUX[i.idx()] = 0.0;
    }
  }
  /*
  // Fourth pass: flow side-to-side *again*
  for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
    for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
      flow_here = WATER_FLOW[i.idx()];
      if (
         BOARD[i.neighbor(DIR_DOWN).idx()] <= TILE_WATER
      && WATER_FLOW[i.neighbor(DIR_DOWN).idx()] < 1.0
      ) {
        // liquid can continue to flow downwards next step: no need to spread
        continue;
      }
      if ( // flow left but not right
         BOARD[i.neighbor(DIR_LEFT).idx()] <= TILE_WATER
      && WATER_FLOW[i.neighbor(DIR_LEFT).idx()] < flow_here
      && (
            BOARD[i.neighbor(DIR_RIGHT).idx()] > TILE_WATER
         || WATER_FLOW[i.neighbor(DIR_RIGHT).idx()] >= flow_here
         )
      ) {
        balance_level = (flow_here+WATER_FLOW[i.neighbor(DIR_LEFT).idx()]) /2.0;
        FLUX[i.idx()] += FLOW_BALANCING_SPEED * (balance_level - flow_here);
        FLUX[i.neighbor(DIR_LEFT).idx()] += FLOW_BALANCING_SPEED * (
          flow_here
        - balance_level
        );
      } else if ( // flow right but not left
         BOARD[i.neighbor(DIR_RIGHT).idx()] <= TILE_WATER
      && WATER_FLOW[i.neighbor(DIR_RIGHT).idx()] < flow_here
      && (
            BOARD[i.neighbor(DIR_LEFT).idx()] > TILE_WATER
         || WATER_FLOW[i.neighbor(DIR_LEFT).idx()] >= flow_here
         )
      ) {
        balance_level = (flow_here+WATER_FLOW[i.neighbor(DIR_RIGHT).idx()])/2.0;
        FLUX[i.idx()] += FLOW_BALANCING_SPEED * (balance_level - flow_here);
        FLUX[i.neighbor(DIR_RIGHT).idx()] += FLOW_BALANCING_SPEED * (
          flow_here
        - balance_level
        );
      } else if ( // flow both left and right
         BOARD[i.neighbor(DIR_RIGHT).idx()] <= TILE_WATER
      && WATER_FLOW[i.neighbor(DIR_RIGHT).idx()] < flow_here
      && BOARD[i.neighbor(DIR_LEFT).idx()] <= TILE_WATER
      && WATER_FLOW[i.neighbor(DIR_LEFT).idx()] < flow_here
      ) {
        surplus = flow_here - (
          flow_here
        + WATER_FLOW[i.neighbor(DIR_LEFT).idx()]
        + WATER_FLOW[i.neighbor(DIR_RIGHT).idx()]
        ) / 3.0;
        surplus_left = flow_here - WATER_FLOW[i.neighbor(DIR_LEFT).idx()];
        surplus_right = flow_here - WATER_FLOW[i.neighbor(DIR_RIGHT).idx()];
        FLUX[i.idx()] -= surplus * FLOW_BALANCING_SPEED;
        FLUX[i.neighbor(DIR_LEFT).idx()] += (
          surplus
        * FLOW_BALANCING_SPEED
        * (surplus_left / (surplus_left + surplus_right))
        );
        FLUX[i.neighbor(DIR_RIGHT).idx()] += (
          surplus
        * FLOW_BALANCING_SPEED
        * (surplus_right / (surplus_left + surplus_right))
        );
      } // else trapped; no flux
    }
  }
  for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
    for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
      WATER_FLOW[i.idx()] += FLUX[i.idx()];
      FLUX[i.idx()] = 0.0;
    }
  }
  */

  // Final pass: update color values:
  clone_to_next();
  for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
    for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
      if (WATER_FLOW[i.idx()] > EVAPORATION_THRESHOLD) {
        if (WATER_FLOW[i.idx()] > LIQUID_DISPLAY_THRESHOLD) {
          set_next(i, TILE_WATER);
        } else if (BOARD[i.idx()] == TILE_WATER) {
          NEXT[i.idx()] = TILE_EMPTY;
        }
      } else {
        WATER_FLOW[i.idx()] = 0.0;
        if (BOARD[i.idx()] == TILE_WATER) {
          NEXT[i.idx()] = TILE_EMPTY;
        }
      }
    }
  }
  swap_from_next();
}

void grow_vines() {
  Index i = new Index(0, 0);
  int len;
  clone_to_next();
  for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
    for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
      if (BOARD[i.idx()] == TILE_VINES) {
        if (any_adjacent(i, TILE_DIRT)) {
          VINE_LENGTH[i.idx()] = 1;
          len = 1;
        } else {
          len = VINE_LENGTH[i.idx()];
        }
        if (len > MAX_VINE_LENGTH) {
          NEXT[i.idx()] = TILE_EMPTY;
        } else {
          check_grow_vines(i.neighbor(DIR_UP), len + 1);
          check_grow_vines(i.neighbor(DIR_RIGHT), len + 1);
          check_grow_vines(i.neighbor(DIR_DOWN), len + 1);
          check_grow_vines(i.neighbor(DIR_LEFT), len + 1);
        }
      }
    }
  }
  swap_from_next();
}

void check_grow_vines(Index i, int length) {
  if (length > MAX_VINE_LENGTH) {
    return;
  }
  if (BOARD[i.idx()] == TILE_VINES) {
    if (length < VINE_LENGTH[i.idx()]) {
      VINE_LENGTH[i.idx()] = length;
    }
  } else if (BOARD[i.idx()] == TILE_WATER) {
    return;
  }
  if (count_adjacent(i, TILE_VINES) > 1) {
    return;
  }
  if (NEXT[i.idx()] < TILE_VINES) {
    NEXT[i.idx()] = TILE_VINES;
    VINE_LENGTH[i.idx()] = length;
  }
}

void generate_level() {
  int i;
  Index h = new Index(0, 0);
  for (h.x = 0; h.x < BOARD_WIDTH; ++h.x) {
    for (h.y = 0; h.y < BOARD_HEIGHT; ++h.y) {
      VINE_LENGTH[h.idx()] = MAX_VINE_LENGTH + 1;
      WATER_FLOW[h.idx()] = 0;
      ORANGE_FLOW[h.idx()] = 0;
      if (
         random(1) < 0.5 && (h.y % 6) == 0
      || random(1) < 0.3 && (h.y % 4) == 0
      ) {
        BOARD[h.idx()] = TILE_STONE;
      } else if (
         random(1) < 0.2 && ((h.y + 1) % 6) == 0
      || random(1) < 0.1 && ((h.y + 1) % 5) == 0
      ) {
        BOARD[h.idx()] = TILE_DIRT;
      } else if (
         random(1) < 0.3 && ((h.y + 1) % 7) == 0
      || random(1) < 0.15 && ((h.y + 1) % 5) == 0
      ) {
        BOARD[h.idx()] = TILE_WALL;
      } else if (random(1) < 0.01) {
        BOARD[h.idx()] = TILE_WATER;
        WATER_FLOW[h.idx()] = 4.0;
      } else if (random(1) < 0.02) {
        BOARD[h.idx()] = TILE_VINES;
        //VINE_LENGTH[h.idx()] = 1;
      } else {
        BOARD[h.idx()] = TILE_EMPTY;
      }
      /*
      if (
         h.x == 0
      || h.x == BOARD_WIDTH - 1
      || h.y == 0
      || h.y == BOARD_HEIGHT - 1
      ) {
        BOARD[h.idx()] = TILE_WALL;
        WATER_FLOW[h.idx()] = 0.0;
      }
      */
    }
  }
  for (i = 0; i < INITIAL_SETTLE_TIME; ++i) {
    update_cells();
  }
}

void place_agent_in_level(Agent a) {
  // TODO: Something more sophisticated!
  a.x = random(BOARD_WIDTH);
  a.y = random(BOARD_HEIGHT);
  while (a.movement_on(BOARD[a.center().idx()]) == MOV_BLOCKED) {
    a.x = random(BOARD_WIDTH);
    a.y = random(BOARD_HEIGHT);
  }
}

void setup() {
  size(800, 600, P3D);
  frameRate(FRAME_RATE);
  textSize(TEXT_SIZE);

  ellipseMode(RADIUS);

  WINDOW_WIDTH = 800;
  WINDOW_HEIGHT = 600;

  randomSeed(17);
  noiseSeed(17);
  // TODO: some way of seeding the Perlin library?

  colorMode(HSB, 1.0, 1.0, 1.0);

  // Initialize tiles:
  TILES = new color[N_TILES];
  TILES[TILE_EMPTY] = color(0, 0, 0); // black
  TILES[TILE_STONE] = color(0, 0, 0.5); // grey
  TILES[TILE_WALL] = color(0, 0, 1); // white
  TILES[TILE_WATER] = color(0.55, 0.6, 0.9); // blue
  TILES[TILE_VINES] = color(0.4, 1.0, 0.7); // green
  TILES[TILE_DIRT] = color(0.12, 1.0, 0.45); // brown
  TILES[TILE_FIRE] = color(0.12, 1.0, 1.0); // orange
  TILES[TILE_MAGIC] = color(0.78, 0.8, 0.8); // purple

  // Initialize stuff to 0:
  BOARD = new int[BOARD_WIDTH * BOARD_HEIGHT];
  NEXT = new int[BOARD_WIDTH * BOARD_HEIGHT];
  WATER_FLOW = new double[BOARD_WIDTH * BOARD_HEIGHT];
  ORANGE_FLOW = new double[BOARD_WIDTH * BOARD_HEIGHT];
  FLUX = new double[BOARD_WIDTH * BOARD_HEIGHT];
  VINE_LENGTH = new int[BOARD_WIDTH * BOARD_HEIGHT];
  generate_level();

  // The agent:
  LOST = new Agent(
    BOARD_WIDTH / 2.0, // x
    BOARD_HEIGHT / 2.0, // y
    DEFAULT_MAX_SPEED, // max_speed
    DEFAULT_SIZE, // size
    AI_FOLLOW_CURSOR // AI
    // AI_PLAYER_CONTROLLED // AI
  );
  place_agent_in_level(LOST);
}

Index mouse_index() {
  float x, y;
  int board_px_width = TILE_SIZE * BOARD_WIDTH;
  int board_px_height = TILE_SIZE * BOARD_HEIGHT;

  x = (mouseX - (width - board_px_width) / 2) / (float) board_px_width;
  y = (mouseY - (height - board_px_height) / 2) / (float) board_px_height;

  return new Index((int) (x * BOARD_WIDTH), (int) (y * BOARD_HEIGHT));
}

void draw_board() {
  // So we do it the hard way:
  Index i = new Index(0, 0);
  noStroke();
  for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
    for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
      fill(TILES[BOARD[i.idx()]]);
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

void draw_agent(Agent a) {
  // TODO: Something fancier!
  stroke(0, 0, 0);
  if (a.supported(DIR_DOWN)) {
    fill(0, 0, 1);
  } else {
    fill(0, 0, 0.9);
  }
  ellipse(
    (float) (a.x * TILE_SIZE),
    (float) (a.y * TILE_SIZE),
    (float) (a.size * TILE_SIZE),
    (float) (a.size * TILE_SIZE)
  );
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
    String.format("vines: %d", VINE_LENGTH[mouse_index().idx()]),
    20,
    20
  );
}

void debug_water() {
  fill(0, 0, 1);
  text(
    String.format("flow: %.12f", WATER_FLOW[mouse_index().idx()]),
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
}


void draw() {
  ArrayList<PathIndex> path;
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
  int board_px_width = TILE_SIZE * BOARD_WIDTH;
  int board_px_height = TILE_SIZE * BOARD_HEIGHT;
  pushMatrix();
  translate((width - board_px_width) / 2, (height - board_px_height) / 2);
  draw_board();
  draw_agent(LOST);
  //*
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
  /* */
  popMatrix();

  debug_water();
  //debug_vines();
  debug_framerate();
  debug_input();
  debug_lost();

  // Update:
  if (!PAUSED) {
    if (frameCount % UPDATE_RATE == 0) {
      update_cells();
    }
    LOST.update(1.0 / (float) FRAME_RATE);
  }
}

void keyPressed() {
  if (key == 'q') {
    exit();
  } else if (key == 'r') {
    generate_level();
    place_agent_in_level(LOST);
  } else if (key == 'p') {
    PAUSED = !PAUSED;
  } else if (key == 'c') {
    if (LOST.AI == AI_FOLLOW_CURSOR) {
      LOST.AI = AI_PLAYER_CONTROLLED;
    } else {
      LOST.AI = AI_FOLLOW_CURSOR;
    }
  } else if (key == 's') {
    update_cells();
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
