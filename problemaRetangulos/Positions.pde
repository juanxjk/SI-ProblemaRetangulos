class Positions {
  Rect[] person_rects;
  Rect fitnessRect;

  Positions() {
    this.person_rects = new Rect[n_rectangles];
    for (int i = 0; i < n_rectangles; i++) {
      this.person_rects[i] = copyNewRect(rects[i]);
    }
    this.randomizeAll_noSobreposition();
    this.fitness();
  } 
  Rect copyNewRect(Rect r) {
    Rect newRect = new Rect(r.x_min, r.y_min, r.x_max, r.y_max);
    return newRect;
  }

  void copy(Positions p) {
    for (int i = 0; i < n_rectangles; i++) {
      this.person_rects[i] = copyNewRect(p.person_rects[i]);
    }
  }

  void mutate1() {
    // this.person_rects[(int)random(0, 1)] = ;
    // select(a)
    if(mutation_rate >= random(0,1)){
      int a = (int) random(0, person_rects.length);
      do{
        person_rects[a].randomize();
      }while(this.isThereSobreposition());
    }
  }

  float fitness() {
    this.fitnessRect = new Rect(this.menorX(), this.menorY(), 
      this.maiorX(), this.maiorY());
    return -this.fitnessRect.area();
  }

  void cross(Positions x, Positions y) {
    //TODO
    if(x.fitness() > y.fitness()){
      copy(x);
    } else {
      copy(y);
    }
  }

  void removeAnySobreposition() {
    while (isThereSobreposition()) {
      int a = (int) random(0, this.person_rects.length);
      this.person_rects[a].randomize();
    }
  }

  void removeSobreposition() {
    int a = (int) random(0, this.person_rects.length);
    while (isThereSobreposition()) {   
      this.person_rects[a].randomize();
    }
  }

  boolean isThereSobreposition() {
    for (int i = 0; i<this.person_rects.length; i++) {
      for (int j = 0; j<this.person_rects.length; j++) {
        if (i==j) continue;
        if (this.person_rects[i].isSobreposition(this.person_rects[j])) return true;
      }
    }
    return false;
  }
  void randomizeAll() {
    //int a = (int) random(0, this.person_rects.length);
    for (int i = 0; i < this.person_rects.length; i++) {
      this.person_rects[i].randomize();
    }
  }
  void randomizeAll_noSobreposition() {
    //int a = (int) random(0, this.person_rects.length);
    do {
      this.randomizeAll();
    } while (isThereSobreposition());
  }

  float menorX() {
    float menor = this.person_rects[0].x_min;
    for (int i = 1; i<this.person_rects.length; i++) {
      if (this.person_rects[i].x_min < menor) menor = this.person_rects[i].x_min;
    }
    return menor;
  }

  float menorY() {
    float menor = this.person_rects[0].y_min;
    for (int i = 1; i<this.person_rects.length; i++) {
      if (this.person_rects[i].y_min < menor) menor = this.person_rects[i].y_min;
    }
    return menor;
  }

  float maiorX() {
    float maior = this.person_rects[0].x_max;
    for (int i = 1; i<this.person_rects.length; i++) {
      if (this.person_rects[i].x_max > maior) maior = this.person_rects[i].x_max;
    }
    return maior;
  }

  float maiorY() {
    float maior = this.person_rects[0].y_max;
    for (int i = 1; i<this.person_rects.length; i++) {
      if (this.person_rects[i].y_max > maior) maior = this.person_rects[i].y_max;
    }
    return maior;
  }
}