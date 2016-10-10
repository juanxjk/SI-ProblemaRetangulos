final int n_rectangles = 10; //<>//
final int population_size = 100;
final float mutation_rate = 0.5; 
//CLASS DEFINITIONS-------------------------------------------------------------



//RECTANGLES FUNCTIONS----------------------------------------------------------
boolean isThereSobreposition() {
  for (int i = 0; i<rects.length; i++) {
    for (int j = 0; j<rects.length; j++) {
      if (i==j) continue;
      if (rects[i].isSobreposition(rects[j])) return true;
    }
  }
  return false;
}
void removeAnySobreposition() {
  while (isThereSobreposition()) {
    int a = (int) random(0, rects.length);
    rects[a].randomize();
  }
}

Positions select() {
  int a = (int) random(0, current_population.length);
  int b = (int) random(0, current_population.length);
  Positions a1 = current_population[a];
  Positions a2 = current_population[b];
  if (a1.fitness() > a2.fitness()) {
    return a1;
  } else {
    return a2;
  }
}

Positions selectBestFitness() {
  Positions maior = current_population[0];
  for (int i = 1; i < population_size; i++) {
    if (current_population[i].fitness()>maior.fitness()) {
      maior = current_population[i];
    }
  }
  return maior;
}

//PROCESSING PROCESS------------------------------------------------------------

Rect[] rects;
Positions[] current_population;
Positions[] next_population;

void setup() {
  size(800, 480);

  rects = new Rect[n_rectangles];

  for (int i = 0; i<n_rectangles; i++) { //Criar todos os retangulos
    float xL_max = random(50, 150);
    float yL_max = random(50, 150);
    float x_min = random(0, width - xL_max);
    float y_min = random(0, height - yL_max);
    float x_max = random(x_min, x_min + xL_max);
    float y_max = random(y_min, y_min + yL_max);
    rects[i] = new Rect(x_min, y_min, x_max, y_max);
  }

  removeAnySobreposition();

  current_population = new Positions[population_size];
  next_population = new Positions[population_size];

  for (int i = 0; i < population_size; i++) {
    current_population[i] = new Positions();
    next_population[i] = new Positions();
  }
}

void draw() {
  background(0); //<>//
  drawFitnessRect();
  drawRetangles();

  GeneticAlgorithm();
  showMenu(showMenu_option);
}
void GeneticAlgorithm(){
  if(startGenetico_option){
    for (int j = 0; j < 100; j++) {
      for (int i = 0; i < population_size; i++) {
        Positions x = select();
        Positions y = select();
        next_population[i].cross(x, y);
        if (random(0, 1.0) <= mutation_rate)
          next_population[i].mutate1();
      }

      for (int i = 0; i < population_size; i++) {
        current_population[i].copy(next_population[i]);
      }
    }
  }
}
//------------------------------------------------------------------------------
void showMenu(boolean showMenu_option) {
  if (showMenu_option) {
    stroke(255, 0, 0);
    fill(255, 255, 0);
    textSize(12);
    text("- - - MENU - - -\n"+
      "Pressione: \n"+
      "1. Iniciar Alg. Genético.\n"+
      "2. Pausar Alg. Genético.\n"+
      "3. Randomizar todos os retângulos.\n"
      , 10, 10);
  }
}

boolean showMenu_option = false;
boolean startGenetico_option = false;

void keyPressed() {
  if (key == 'h' || key=='m') {
    showMenu_option = !showMenu_option;
  }
  if (key == '1') startGenetico_option = true;
  if (key == '2') startGenetico_option = false;
  if (key == '3') setup();
  if (key == '4')
  //if (key == '5') randomizeAll_noSobreposition();
  if (key == '6');
  if (key == '7');
  if (key == '8');
  if (key == '9');
  
  if (key == ' '){
    selectBestFitness().randomizeAll_noSobreposition();
  }
}
//------------------------------------------------------------------------------
Rect rectM;
void drawFitnessRect() {
  strokeWeight(1);
  stroke(255, 255, 0);
  Rect rectM = selectBestFitness().fitnessRect;
  rectM.draw();
  fill(255);
  strokeWeight(5);
  stroke(255, 255, 0);
  //textMode();
  textSize(18);
  text("Area: " + rectM.area(), 20, height-25);
}

void drawRetangles() {
  strokeWeight(1);
  stroke(255);
  Positions p = selectBestFitness();
  for (int i = 0; i < p.person_rects.length; i++) {
    p.person_rects[i].draw();
  }
}
//------------------------------------------------------------------------------