// vim: syn=java

import perlin.*;

Perlin pnl = new Perlin(this);

int WINDOW_WIDTH, WINDOW_HEIGHT;

int N_TILES = 8;
int TILE_SIZE = 6;

color TILES[];

int BOARD_WIDTH = 128;
int BOARD_HEIGHT = 128;

int BOARD[];
int NEXT[];
float BLUE_FLOW[];
float ORANGE_FLOW[];
float FLUX[];

float MAX_COMPRESSED_FLOW = 1.2;
float FLOW_BALANCING_SPEED = 0.9;

int BLACK = 0;
int BLUE = 1;
int GREEN = 2;
int BROWN = 3;
int GRAY = 4;
int ORANGE = 5;
int PURPLE = 6;
int WHITE = 7;

int UP = 1;
int RIGHT = 2;
int DOWN = 4;
int LEFT = 8;

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
    if (direction == UP) {
      return new Index(this.x, this.y - 1);
    } else if (direction == RIGHT) {
      return new Index(this.x + 1, this.y);
    } else if (direction == DOWN) {
      return new Index(this.x, this.y + 1);
    } else if (direction == LEFT) {
      return new Index(this.x - 1, this.y);
    }
    println("Error: bad direction in Index.neighbor: ", direction);
    return new Index(0, 0);
  }

  int idx() {
    return this.x + BOARD_WIDTH * this.y;
  }
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

int prev_dir(int direction) {
  if (direction == UP) { return LEFT; }
  else if (direction == LEFT) { return DOWN; }
  else if (direction == DOWN) { return RIGHT; }
  else if (direction == RIGHT) { return UP; }
  println("Error: bad direction in prev_dir: ", direction);
  return UP;
}

int next_dir(int direction) {
  if (direction == UP) { return RIGHT; }
  else if (direction == RIGHT) { return DOWN; }
  else if (direction == DOWN) { return LEFT; }
  else if (direction == LEFT) { return UP; }
  println("Error: bad direction in next_dir: ", direction);
  return UP;
}

int opp_dir(int direction) {
  if (direction == UP) { return DOWN; }
  else if (direction == RIGHT) { return LEFT; }
  else if (direction == LEFT) { return RIGHT; }
  else if (direction == DOWN) { return UP; }
  println("Error: bad direction in opp_dir: ", direction);
  return UP;
}

boolean any_touching(Index i, int tile) {
  if (BOARD[i.neighbor(UP).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(RIGHT).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(DOWN).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(LEFT).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(UP).neighbor(RIGHT).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(RIGHT).neighbor(DOWN).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(DOWN).neighbor(LEFT).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(LEFT).neighbor(UP).idx()] == tile) { return true; }
  return false;
}

boolean any_adjacent(Index i, int tile) {
  if (BOARD[i.neighbor(UP).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(RIGHT).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(DOWN).idx()] == tile) { return true; }
  if (BOARD[i.neighbor(LEFT).idx()] == tile) { return true; }
  return false;
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

void update_blue() {
  Index i = new Index(0, 0);
  float flow_here, neighbor_flow, neighbor_flux, overflow, balance_level;
  float space_above, surplus;
  for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
    for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
      if (BOARD[i.idx()] != BLUE) {
        BLUE_FLOW[i.idx()] = 0.0;
      }
      FLUX[i.idx()] = 0.0;
    }
  }
  // First pass: flow down and side-to-side:
  for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
    for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
      flow_here = BLUE_FLOW[i.idx()];
      if (flow_here > 0) {
        neighbor_flow = BLUE_FLOW[i.neighbor(DOWN).idx()];
        neighbor_flux = FLUX[i.neighbor(DOWN).idx()];
        if (BOARD[i.neighbor(DOWN).idx()] <= BLUE) { // can flow down
          if (flow_here + neighbor_flow + neighbor_flux < MAX_COMPRESSED_FLOW) {
            FLUX[i.idx()] -= flow_here;
            FLUX[i.neighbor(DOWN).idx()] += flow_here;
            overflow = 0.0;
          } else {
            overflow = (
              flow_here
            + neighbor_flow
            + neighbor_flux
            - MAX_COMPRESSED_FLOW
            );
            FLUX[i.idx()] -= flow_here - overflow;
            FLUX[i.neighbor(DOWN).idx()] += flow_here - overflow;
          }
        } else {
          overflow = flow_here;
        }
        if ( // can flow left but not right
           BOARD[i.neighbor(LEFT).idx()] <= BLUE
        && BOARD[i.neighbor(RIGHT).idx()] > BLUE
        ) {
          balance_level = (overflow + BLUE_FLOW[i.neighbor(LEFT).idx()]) / 2.0;
          FLUX[i.idx()] += FLOW_BALANCING_SPEED * (balance_level - overflow);
          FLUX[i.neighbor(LEFT).idx()] += FLOW_BALANCING_SPEED * (
            balance_level
          - BLUE_FLOW[i.neighbor(LEFT).idx()]
          );
        } else if ( // can flow right but not left
           BOARD[i.neighbor(LEFT).idx()] > BLUE
        && BOARD[i.neighbor(RIGHT).idx()] <= BLUE
        ) {
          balance_level = (overflow + BLUE_FLOW[i.neighbor(RIGHT).idx()]) / 2.0;
          FLUX[i.idx()] += FLOW_BALANCING_SPEED * (balance_level - overflow);
          FLUX[i.neighbor(RIGHT).idx()] += FLOW_BALANCING_SPEED * (
            balance_level
          - BLUE_FLOW[i.neighbor(RIGHT).idx()]
          );
        } else if ( // can flow both left and right
           BOARD[i.neighbor(RIGHT).idx()] <= BLUE
        && BOARD[i.neighbor(LEFT).idx()] <= BLUE
        ) {
          balance_level = (
            overflow
          + BLUE_FLOW[i.neighbor(RIGHT).idx()]
          + BLUE_FLOW[i.neighbor(LEFT).idx()]
          ) / 3.0;
          FLUX[i.idx()] += FLOW_BALANCING_SPEED * (balance_level - overflow);
          FLUX[i.neighbor(RIGHT).idx()] += FLOW_BALANCING_SPEED * (
            balance_level
          - BLUE_FLOW[i.neighbor(RIGHT).idx()]
          );
          FLUX[i.neighbor(LEFT).idx()] += FLOW_BALANCING_SPEED * (
            balance_level
          - BLUE_FLOW[i.neighbor(LEFT).idx()]
          );
        // else trapped; no flux
        }
      }
    }
  }
  // Second pass: spring back up where compressed:
  for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
    for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
      flow_here = BLUE_FLOW[i.idx()];
      surplus = flow_here - 1.0;
      if (surplus > 0) {
        space_above = (
          1.0
        + ((flow_here - 1.0) * 0.5)
        - BLUE_FLOW[i.neighbor(UP).idx()]
        - FLUX[i.neighbor(UP).idx()]
        );
        if (space_above > 0) {
          if (space_above < surplus) {
            FLUX[i.idx()] -= space_above;
            FLUX[i.neighbor(UP).idx()] += space_above;
          } else {
            FLUX[i.idx()] -= surplus;
            FLUX[i.neighbor(UP).idx()] += surplus;
          }
        }
      }
    }
  }
  // Third pass: update values from fluxes:
  for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
    for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
      BLUE_FLOW[i.idx()] += FLUX[i.idx()];
      FLUX[i.idx()] = 0;
    }
  }

  // Final pass: update color values:
  clone_to_next();
  for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
    for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
      if (BLUE_FLOW[i.idx()] > 0) {
        set_next(i, BLUE);
      } else if (BOARD[i.idx()] == BLUE) {
        NEXT[i.idx()] = BLACK;
      }
    }
  }
  swap_from_next();
}

void grow_green() {
  Index i = new Index(0, 0);
  clone_to_next();
  for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
    for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
      if (BOARD[i.idx()] == GREEN && any_touching(i, BLUE)) {
        set_next(i.neighbor(UP), GREEN);
        set_next(i.neighbor(RIGHT), GREEN);
        set_next(i.neighbor(DOWN), GREEN);
        set_next(i.neighbor(LEFT), GREEN);
      }
    }
  }
  swap_from_next();
}

void setup() {
  size(800, 600, P3D);
  frameRate(8);

  WINDOW_WIDTH = 800;
  WINDOW_HEIGHT = 600;

  Index i = new Index(0, 0);

  randomSeed(17);
  noiseSeed(17);
  // TODO: some way of seeding the Perlin library?

  colorMode(HSB, 1.0, 1.0, 1.0);

  // Initialize tiles:
  TILES = new color[N_TILES];
  TILES[BLACK] = color(0, 0, 0); // black
  TILES[GRAY] = color(0, 0, 0.5); // grey
  TILES[WHITE] = color(0, 0, 1); // white
  TILES[BLUE] = color(0.55, 0.6, 0.9); // blue
  TILES[GREEN] = color(0.4, 1.0, 0.7); // green
  TILES[BROWN] = color(0.12, 1.0, 0.45); // brown
  TILES[ORANGE] = color(0.12, 1.0, 1.0); // orange
  TILES[PURPLE] = color(0.78, 0.8, 0.8); // purple

  // Initialize stuff to 0:
  BOARD = new int[BOARD_WIDTH * BOARD_HEIGHT];
  NEXT = new int[BOARD_WIDTH * BOARD_HEIGHT];
  BLUE_FLOW = new float[BOARD_WIDTH * BOARD_HEIGHT];
  ORANGE_FLOW = new float[BOARD_WIDTH * BOARD_HEIGHT];
  FLUX = new float[BOARD_WIDTH * BOARD_HEIGHT];
  for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
    for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
      BLUE_FLOW[i.idx()] = 0;
      ORANGE_FLOW[i.idx()] = 0;
      if (
         random(1) < 0.5 && (i.y % 6) == 0
      || random(1) < 0.3 && (i.y % 4) == 0
      ) {
        BOARD[i.idx()] = GRAY;
      } else if (
         random(1) < 0.3 && ((i.y + 1) % 7) == 0
      || random(1) < 0.15 && ((i.y + 1) % 5) == 0
      ) {
        BOARD[i.idx()] = WHITE;
      } else if (random(1) < 0.05) {
        BOARD[i.idx()] = BLUE;
        BLUE_FLOW[i.idx()] = 0.9;
      } else {
        BOARD[i.idx()] = BLACK;
      }
    }
  }
}

void draw_board() {
  // Smoothed and I can't seem to fix this...
  // image(BOARD, 0, 0, BOARD_WIDTH * TILE_SIZE, BOARD_HEIGHT * TILE_SIZE);
  // So we do it the hard way:
  Index i = new Index(0, 0);
  noStroke();
  for (i.x = 0; i.x < BOARD_WIDTH; ++i.x) {
    for (i.y = 0; i.y < BOARD_HEIGHT; ++i.y) {
      fill(TILES[BOARD[i.idx()]]);
      rect(i.x*TILE_SIZE, i.y*TILE_SIZE, TILE_SIZE, TILE_SIZE);
    }
  }
}


void draw() {
  // Reset:
  background(0.6, 0.8, 0.25);
  stroke(0.0, 0.0, 1.0);
  noFill();

  // Draw:
  int board_px_width = TILE_SIZE * BOARD_WIDTH;
  int board_px_height = TILE_SIZE * BOARD_HEIGHT;
  pushMatrix();
  translate((width - board_px_width) / 2, (height - board_px_height) / 2);
  draw_board();
  popMatrix();

  // Update:
  if (frameCount % 4 == 0) {
    update_blue();
    grow_green();
  }
}

void keyPressed() {
  if (key == 'q') {
    exit();
  } else if (key == 'e') {
    update_blue();
    grow_green();
  // TODO: other keys...
  }
}
