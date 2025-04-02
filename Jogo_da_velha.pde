int[][] board = new int[3][3]; // 0 = vazio, 1 = X, 2 = O
boolean playerTurn = true;
boolean gameOver = false;
boolean vsCPU = true;
int scoreX = 0;
int scoreO = 0;
boolean choosingMode = true;
boolean showingEndScreen = false;
String gameResult = "";

void setup() {
  size(480, 480); 
  background(0);
  drawMenu();
}

void draw() {
  if (choosingMode) {
    drawMenu();
  } else if (showingEndScreen) {
    drawEndScreen();
  } else if (!gameOver && !playerTurn && vsCPU) {
    delay(500); // Pequeno delay para simular a jogada da CPU
    cpuMove();
    playerTurn = true;
  }
}

void mousePressed() {
  if (choosingMode) {
    if (mouseY > 200 && mouseY < 250) {
      vsCPU = true;
      choosingMode = false;
      resetGame();
    } else if (mouseY > 270 && mouseY < 320) {
      vsCPU = false;
      choosingMode = false;
      resetGame();
    }
    return;
  }
  
  if (showingEndScreen) {
    if (mouseY > 250 && mouseY < 300) {
      resetGame();
      showingEndScreen = false;
    } else if (mouseY > 320 && mouseY < 370) {
      choosingMode = true;
      showingEndScreen = false;
      scoreX = 0;
      scoreO = 0;
    }
    return;
  }
  
  if (gameOver) return;

  int col = (mouseX - 40) / 133;
  int row = (mouseY - 100) / 100;
  
  if (row >= 0 && row < 3 && col >= 0 && col < 3 && board[row][col] == 0) {
    board[row][col] = playerTurn ? 1 : 2;
    playerTurn = !playerTurn;
    checkWinner();
    drawBoard();
  }
}

void cpuMove() {
  int[] bestMove = findBestMove();
  if (bestMove != null) {
    board[bestMove[0]][bestMove[1]] = 2;
    checkWinner();
    drawBoard();
  }
}

int[] findBestMove() {
  for (int r = 0; r < 3; r++) {
    for (int c = 0; c < 3; c++) {
      if (board[r][c] == 0) {
        board[r][c] = 2;
        if (checkWin(2)) {
          return new int[]{r, c};
        }
        board[r][c] = 0;
      }
    }
  }
  
  for (int r = 0; r < 3; r++) {
    for (int c = 0; c < 3; c++) {
      if (board[r][c] == 0) {
        board[r][c] = 1;
        if (checkWin(1)) {
          board[r][c] = 2;
          return new int[]{r, c};
        }
        board[r][c] = 0;
      }
    }
  }
  
  for (int r = 0; r < 3; r++) {
    for (int c = 0; c < 3; c++) {
      if (board[r][c] == 0) {
        return new int[]{r, c};
      }
    }
  }
  return null;
}

boolean checkWin(int player) {
  for (int i = 0; i < 3; i++) {
    if (board[i][0] == player && board[i][1] == player && board[i][2] == player) return true;
    if (board[0][i] == player && board[1][i] == player && board[2][i] == player) return true;
  }
  if (board[0][0] == player && board[1][1] == player && board[2][2] == player) return true;
  if (board[0][2] == player && board[1][1] == player && board[2][0] == player) return true;
  return false;
}

void checkWinner() {
  if (checkWin(1)) {
    win(1);
    gameResult = "Vitória do Jogador 1";
  }
  if (checkWin(2)) {
    win(2);
    gameResult = vsCPU ? "Vitória da CPU" : "Vitória do Jogador 2";
  }
  
  boolean tie = true;
  for (int[] row : board) {
    for (int cell : row) {
      if (cell == 0) tie = false;
    }
  }
  if (tie) {
    gameOver = true;
    showingEndScreen = true;
    gameResult = "Empate";
  }
}

void win(int player) {
  gameOver = true;
  showingEndScreen = true;
  if (player == 1) scoreX++;
  else if (player == 2) scoreO++;
}

void resetGame() {
  board = new int[3][3];
  gameOver = false;
  playerTurn = true;
  drawBoard();
}

void drawBoard() {
  background(0);
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Jogo da Velha", width / 2, 20);
  text(scoreX + " Placar " + scoreO, width / 2, 48);
  
  stroke(255);
  for (int i = 1; i < 3; i++) {
    line(i * 133 + 40, 100, i * 133 + 40, 400);
    line(40, i * 100 + 100, 440, i * 100 + 100);
  }
  textSize(40);
  for (int r = 0; r < 3; r++) {
    for (int c = 0; c < 3; c++) {
      // Agora os "X" e "O" são centralizados dentro de cada célula
      if (board[r][c] == 1) text("X", c * 133 + 100, r * 100 + 150);
      if (board[r][c] == 2) text("O", c * 133 + 100, r * 100 + 150);
    }
  }
}

void drawMenu() {
  background(0);
  fill(255);
  textSize(30);
  textAlign(CENTER, CENTER);
  text("Escolha o modo de jogo", width / 2, 150);
  text("Contra CPU", width / 2, 225);
  text("Player vs Player", width / 2, 295);
}

void drawEndScreen() {
  background(0);
  fill(255);
  textSize(30);
  textAlign(CENTER, CENTER);
  text("Fim de Jogo!", width / 2, 120);
  text(gameResult, width / 2, 170);
  text("Placar: " + scoreX + " - " + scoreO, width / 2, 220);
  text("Jogar Novamente", width / 2, 275);
  text("Voltar ao Menu", width / 2, 345);
}
