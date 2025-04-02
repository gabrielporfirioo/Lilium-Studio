String[] filmes = {
  "um sonho de liberdade", "o poderoso chefao", "o cavaleiro das trevas", "a lista de schindler", 
  "pulp fiction tempo de violencia", "o senhor dos anéis o retorno do rei", "clube da luta", "a origem", 
  "forrest gump o contador de historias", "os bons companheiros", 
  "o senhor dos aneis a sociedade do anel", "cidade de deus", "o senhor dos aneis as duas torres", 
  "star wars a nova esperanza", "o iluminado", "a vida é bela", "matrix", "vingadores ultimato", 
   "o pianista", "a bela e a fera", "o rei leao", "cidadao kane", 
  "taxi driver", "a sociedade dos poetas mortos", "o silencio dos inocentes", "the green mile", 
  "a caça", "gladiador", "os infiltrados", "memento", "batman o cavaleiro das trevas ressurge", 
  "whiplash", "o grande lebowski", "vingadores guerra infinita", "o labirinto do fauno", 
  "os sete samurais", "o exorcista",  "o grande hotel budapeste", 
  "vingadores a guerra civil", "pantera negra", "a forma da agua", "o profissional", 
  "o exterminador do futuro 2", "o lobo de wall street", "o homem que copiava", "trainspotting", "a rede social"
};

String[] futebol = {
  "flamengo", "palmeiras", "sao paulo", "corinthians", "gremio", "internacional", "fluminense", 
  "botafogo", "cruzeiro", "atletico mineiro", "vasco", "bahia", "fortaleza", "goias", "america mineiro", 
  "curitiba", "atletico pr", "bragantino", "santos", "ceara", "juventude", "figueirense", "operario", 
  "nacional", "remo", "botafogo sp", "atocha", "nova iguacu", "palmeiras sp", "cuiaba", "chapecoense", 
  "ponte preta", "guarani", "crb", "sampaio correa", "csa", "vitoria", "londrina", "vila nova", 
  "brasil de pelotas", "nautico", "santa cruz", "parana clube", "criciuma", "avai", "america rn", 
  "internacional sp", "joinville", "sao caetano", "mogi mirim"
};

String palavraEscolhida;
String palavraOculta;
int tentativas = 6;
char[] letrasErradas = new char[6];
boolean jogoAtivo = false;
String categoriaEscolhida = "";
String mensagem = "";
boolean telaSelecaoTema = true;

void setup() {
  size(800, 400);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(255);
  
  if (telaSelecaoTema) {
    textSize(30);
    text("Jogo da Forca", width / 2, 40);
    textSize(24);
    text("Escolha o tema:", width / 2, 100);
    
    fill(200);
    rect(width/2 - 150, 150, 300, 50);
    rect(width/2 - 150, 220, 300, 50);
    
    fill(0);
    text("Futebol", width/2, 175);
    text("Filmes", width/2, 245);
  } else {
    textSize(30);
    fill(0);
    text("Jogo da Forca", width / 2, 40);
    
    textSize(18);
    text("Dica: Esta palavra é um " + (categoriaEscolhida.equals("Futebol") ? "time de futebol" : "filme"), width / 2, 70);
    
    desenharPalavraComEspacos();
    
    textSize(20);
    text("Letras erradas: " + String.valueOf(letrasErradas), width / 2, 170);
    
    text("Tentativas restantes: " + tentativas, width / 2, 220);
    
    fill(jogoAtivo ? 0 : (tentativas == 0 ? color(255, 0, 0) : color(0, 128, 0)));
    text(mensagem, width / 2, height - 50);
    
    desenharForca();
    
    if (!jogoAtivo) {
      fill(200);
      rect(width/2 - 100, height - 100, 200, 40);
      fill(0);
      textSize(18);
      text("Jogar Novamente", width/2, height - 80);
    }
  }
}

void desenharPalavraComEspacos() {
  float espacamento = 18;
  float startX = width / 2 - (palavraEscolhida.length() * espacamento) / 2;
  float y = 120;
  
  for (int i = 0; i < palavraEscolhida.length(); i++) {
    float x = startX + i * espacamento;
    
    if (palavraEscolhida.charAt(i) == ' ') {
      continue;
    } else {
      fill(0);
      textSize(28);
      text("_", x, y);
      
      boolean letraDescoberta = false;
      for (int j = 0; j < palavraOculta.length(); j++) {
        if (j == i && palavraOculta.charAt(j) != '_') {
          fill(0, 0, 255); // Cor azul para as letras descobertas
          textSize(18);
          text(palavraOculta.charAt(j), x, y - 10);
          letraDescoberta = true;
          break;
        }
      }
    }
  }
}

void desenharForca() {
  stroke(0);
  strokeWeight(3);
  
  line(50, 300, 150, 300);
  
  line(100, 300, 100, 100);
  
  line(100, 100, 200, 100);
  
  line(200, 100, 200, 130);
  
  if (tentativas < 6) { 
    noFill();
    ellipse(200, 150, 40, 40);
  }
  
  if (tentativas < 5) { 
    line(200, 170, 200, 230);
  }
  
  if (tentativas < 4) { 
    line(200, 180, 170, 200);
  }
  
  if (tentativas < 3) { 
    line(200, 180, 230, 200);
  }
  
  if (tentativas < 2) { 
    line(200, 230, 180, 270);
  }
  
  if (tentativas < 1) { 
    line(200, 230, 220, 270);
  }
  
  strokeWeight(1);
}

void mousePressed() {
  if (telaSelecaoTema) {
    if (mouseX > width/2 - 150 && mouseX < width/2 + 150) {
      if (mouseY > 150 && mouseY < 200) {
        categoriaEscolhida = "Futebol";
        telaSelecaoTema = false;
        iniciarJogo();
      } else if (mouseY > 220 && mouseY < 270) {
        categoriaEscolhida = "Filmes";
        telaSelecaoTema = false;
        iniciarJogo();
      }
    }
  } else if (!jogoAtivo) {
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100 && 
        mouseY > height - 100 && mouseY < height - 60) {
      telaSelecaoTema = true;
    }
  }
}

void iniciarJogo() {
  if (categoriaEscolhida.equals("Futebol")) {
    palavraEscolhida = futebol[int(random(futebol.length))];
  } else {
    palavraEscolhida = filmes[int(random(filmes.length))];
  }
  
  palavraOculta = "";
  for (int i = 0; i < palavraEscolhida.length(); i++) {
    if (palavraEscolhida.charAt(i) == ' ') {
      palavraOculta += " ";
    } else {
      palavraOculta += "_";
    }
  }
  
  letrasErradas = new char[6];
  tentativas = 6;
  jogoAtivo = true;
  mensagem = ""; 
}

void keyPressed() {
  if (jogoAtivo && (key >= 'a' && key <= 'z' || key >= 'A' && key <= 'Z')) {
    char letra = Character.toLowerCase(key); 
    
    boolean letraJaAcertada = false;
    for (int i = 0; i < palavraOculta.length(); i++) {
      if (palavraOculta.charAt(i) == letra) {
        letraJaAcertada = true;
        break;
      }
    }
    
    boolean letraJaErrada = verificaLetraErrada(letra);
    
    if (!letraJaAcertada && !letraJaErrada) {
      boolean acertou = false;
      
      for (int i = 0; i < palavraEscolhida.length(); i++) {
        if (palavraEscolhida.charAt(i) == letra) {
          palavraOculta = palavraOculta.substring(0, i) + letra + palavraOculta.substring(i + 1);
          acertou = true;
        }
      }
      
      if (!acertou) {
        letrasErradas[6 - tentativas] = letra;
        tentativas--;
      }
      
      if (palavraOculta.equals(palavraEscolhida)) {
        jogoAtivo = false;
        mensagem = "Parabéns! Você ganhou!";
      } else if (tentativas == 0) {
        jogoAtivo = false;
        mensagem = "Você não conseguiu. A palavra era: " + palavraEscolhida;
      }
    }
  }
}

boolean verificaLetraErrada(char letra) {
  for (int i = 0; i < letrasErradas.length; i++) {
    if (letrasErradas[i] == letra) {
      return true;
    }
  }
  return false;
}
