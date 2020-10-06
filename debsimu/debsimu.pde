
float  disp_width = 100000;
float  disp_height = 100000;
float  disp_thick = 100000;

float  sattellite_size = 100;
float sattelitte_speed = 7700;
float sattellite_vec_x = sattelitte_speed;
float sattellite_vec_y = 0;

long debris_num_all = 100000000L;
float debalt_ratio_100k = 135.0 / 9063;  //per 100km
long debris_num_surface = (long)(debris_num_all * debalt_ratio_100k * disp_thick/100000);
long debris_num_disparea = (long)(debris_num_surface * disp_width * disp_height / 510065600000000L);
float debris_speed = 7700;

float  fps = 30;
int    frame;

//プレゼン用表示切替機能
int    mode = 0;      //view mnagement
int    sea_mode = 0;
int    fish_mode = 0;
int    simu_mode = 0;
int    ground_mode = 0;
int    deb_mode = 0;
int    speedup = 1;

//画像
PImage img_fish;
PImage img_ground;
PImage img_uki;

//デブリ情報
class Debris {
  float pos_x;
  float pos_y;
  int  count;
  float angle;
  float vec_x;
  float vec_y;
  float size;
}
ArrayList<Debris>  disp_debris = new ArrayList<Debris>();

void settings() {
  size((int)disp_width/100, (int)disp_height/100);
}
void setup() {
  frameRate(fps);
  mode = 0;
  frame = 0;

  surface.setTitle("Space debris simulator");

  //画像ロード
  img_fish = loadImage("fish.png");
  img_ground = loadImage("ground.jpg");
  img_uki = loadImage("uki2.png");
}


//プレゼン用にマウス操作で表示切替
void mousePressed() {
  mode++;
  if (mode>10)mode=0;

  int simu_tbl[]={
    0, 0, 1, 0, 1, 1, 1, 1, 1, 1,1
  };
  int ground_tbl[]={
    0, 1, 1, 0, 0, 0, 0, 0, 0, 0,0
  };
  int deb_tbl[]={
    0, 0, 0, 0, 1, 1, 1, 1, 1, 1,1
  };
  int sea_tbl[]={
    0, 0, 0, 0, 0, 0, 0, 0, 1, 1,0
  };
  int fish_tbl[]={
    0, 0, 0, 0, 0, 0, 0, 0, 0, 1,0
  };
  int speed_tbl[]={
    1, 1, 1, 1, 1, 5, 20, 1, 1, 1,1
  };

if(mode==10)debris_num_disparea*=10;
if(mode==0)debris_num_disparea/=10;

  simu_mode = simu_tbl[mode];
  ground_mode = ground_tbl[mode];
  deb_mode = deb_tbl[mode];
  sea_mode = sea_tbl[mode];
  fish_mode = fish_tbl[mode];
  speedup = speed_tbl[mode];
}

void draw() {
  // 背景色
  if (sea_mode==0) {
    background(0, 0, 60);
  } else {
    background(50, 50, 255);
  }

  // 地上の画像（重い）
  if (ground_mode==1) {
    int dx = (int)(sattelitte_speed*frame/fps/disp_width*1000);    //250px = 100km
    dx %= 4000;
    image(img_ground, -4000+dx, 0, 1250*4, 250*4);
  }

  // 衛星(ISS)
  if(fish_mode==0){
    stroke(255, 0, 0);
    //  ellipse(disp_width/100/2,disp_height/100/2,sattellite_size/100,sattellite_size/100);
    ellipse(disp_width/100/2, disp_height/100/2, 4, 4);
  } else {
    image(img_uki,disp_width/100/2-15, disp_height/100/2-50, 30,60);
  }

  if(mode==0){
    stroke(255, 255, 255);
    strokeWeight(2);
    line(disp_width/100/2 + 10, disp_height/100/2+10, disp_width/100/2 + 40, disp_height/100/2+20);
    textSize(30);
    text("ISS", disp_width/100/2 + 50, disp_height/100/2 + 50);
  }
  if(speedup!=1){
    textSize(30);
    text("X"+speedup, 900, 950);
  }

  if (simu_mode==0) {
    return;    // not start
  }

  for (int speedup_count=0; speedup_count<speedup; speedup_count++) {
    frame++;

    // デブリ補充
    if (deb_mode==1) {
      while (disp_debris.size()<debris_num_disparea) {
        Debris  debri = new Debris();
        debri.pos_x = random(-disp_width/2, disp_width/2);
        debri.pos_y = random(-disp_width/2, disp_width/2);
        debri.count = 0;
        debri.angle = random(-PI, PI);
        debri.vec_x = cos(debri.angle)*debris_speed;
        debri.vec_y = sin(debri.angle)*debris_speed;
 
        // デブリサイズ決定(大きさの分布を元に産出)
        long  no = (long)random(0,(float)debris_num_all);        
        if(no<5000){
          debri.size = pow(10,(1-1.0*no/5000));
        } else
        if(no<20000){
          debri.size = pow(10,(0-1.0*(no-5000)/(20000-5000)));
        } else
        if(no<750000){
          debri.size = pow(10,(-1-1.0*(no-20000)/(750000-20000)));
        } else {
          debri.size = pow(10,(-2-1.0*(no-750000)/(150000000-750000)));
        }

        disp_debris.add(debri);
      }
    } else {
      disp_debris.clear();
    }  

    // デブリ移動
    for (Debris debris : disp_debris) {
      debris.pos_x += debris.vec_x / fps;
      debris.pos_y += debris.vec_y / fps;
      if (fish_mode!=1) {
        debris.pos_x += sattellite_vec_x / fps;
        debris.pos_y += sattellite_vec_y / fps;
      }
    }

    // デブリ当たり判定

    //   （一旦コード削除）

    // デブリ描画
    for (Debris debris : disp_debris) {
      if (fish_mode==0) {
        stroke(255, 255, 255);
        ellipse((debris.pos_x+disp_width/2)/100, (debris.pos_y+disp_height/2)/100, 2, 2);
      } else {
        pushMatrix();
        translate((debris.pos_x+disp_width/2)/100, (debris.pos_y+disp_height/2)/100);
        rotate(debris.angle+PI);
        image(img_fish, 0, 0, 45, 28);
        popMatrix();
      }
    }

    //check debris
    for (Debris debris : disp_debris) {
      debris.count++;
    }
    for (int i=0; i<disp_debris.size(); i++) {
      Debris debris = disp_debris.get(i);
      if (debris.pos_x<-disp_width/2 || debris.pos_y<-disp_height/2 ||
        debris.pos_x>disp_width/2 || debris.pos_y>disp_height/2 || 
        debris.count>600) {
        disp_debris.remove(debris);
        i=0;
        continue;
      }
    }
  }
}
