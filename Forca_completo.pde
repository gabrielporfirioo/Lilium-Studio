// Arrays com as palavras dos temas (50 itens em cada)
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

// Variáveis do jogo
String palavraEscolhida;
String palavraOculta;
int tentativas = 6;
char[] letrasErradas = new char[6];
boolean jogoAtivo = false;
String categoriaEscolhida = "";
String mensagem = "";
boolean telaSelecaoTema = true;

// Setup inicial
void setup() {
  size(800, 400);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(255);
  
  if (telaSelecaoTema) {
    // Tela de seleção de tema
    textSize(30);
    text("Jogo da Forca", width / 2, 40);
    textSize(24);
    text("Escolha o tema:", width / 2, 100);
    
    // Botões de seleção
    fill(200);
    rect(width/2 - 150, 150, 300, 50);
    rect(width/2 - 150, 220, 300, 50);
    
    fill(0);
    text("Futebol", width/2, 175);
    text("Filmes", width/2, 245);
  } else {
    // Tela do jogo
    textSize(30);
    fill(0);
    text("Jogo da Forca", width / 2, 40);
    
    // Mostrar dica da categoria
    textSize(18);
    text("Dica: Esta palavra é um " + (categoriaEscolhida.equals("Futebol") ? "time de futebol" : "filme"), width / 2, 70);
    
    // Exibir palavra oculta com letras menores
    desenharPalavraComEspacos();
    
    // Exibir letras erradas
    textSize(20);
    text("Letras erradas: " + String.valueOf(letrasErradas), width / 2, 170);
    
    // Exibir tentativas restantes
    text("Tentativas restantes: " + tentativas, width / 2, 220);
    
    // Exibir mensagem de vitória ou derrota
    fill(jogoAtivo ? 0 : (tentativas == 0 ? color(255, 0, 0) : color(0, 128, 0)));
    text(mensagem, width / 2, height - 50);
    
    // Desenhar a forca com base nas tentativas restantes
    desenharForca();
    
    // Botão para reiniciar se o jogo terminou
    if (!jogoAtivo) {
      fill(200);
      rect(width/2 - 100, height - 100, 200, 40);
      fill(0);
      textSize(18);
      text("Jogar Novamente", width/2, height - 80);
    }
  }
}

// Função para desenhar a palavra com espaços preservados e letras menores
void desenharPalavraComEspacos() {
  float espacamento = 18; // Espaçamento entre as letras
  float startX = width / 2 - (palavraEscolhida.length() * espacamento) / 2;
  float y = 120;
  
  for (int i = 0; i < palavraEscolhida.length(); i++) {
    float x = startX + i * espacamento;
    
    if (palavraEscolhida.charAt(i) == ' ') {
      // É um espaço, não desenha nada
      continue;
    } else {
      // Desenha o underscore
      fill(0);
      textSize(28);
      text("_", x, y);
      
      // Se a letra foi descoberta, desenha-a em cima do underscore
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

// Função para desenhar a forca
void desenharForca() {
  stroke(0);
  strokeWeight(3);
  
  // Base da forca
  line(50, 300, 150, 300);
  
  // Poste vertical
  line(100, 300, 100, 100);
  
  // Parte superior
  line(100, 100, 200, 100);
  
  // Corda
  line(200, 100, 200, 130);
  
  // Desenhar partes do corpo com base nas tentativas restantes
  if (tentativas < 6) { // Cabeça
    noFill();
    ellipse(200, 150, 40, 40);
  }
  
  if (tentativas < 5) { // Tronco
    line(200, 170, 200, 230);
  }
  
  if (tentativas < 4) { // Braço esquerdo
    line(200, 180, 170, 200);
  }
  
  if (tentativas < 3) { // Braço direito
    line(200, 180, 230, 200);
  }
  
  if (tentativas < 2) { // Perna esquerda
    line(200, 230, 180, 270);
  }
  
  if (tentativas < 1) { // Perna direita
    line(200, 230, 220, 270);
  }
  
  // Resetar o stroke
  strokeWeight(1);
}

// Função que verifica cliques do mouse
void mousePressed() {
  if (telaSelecaoTema) {
    // Verificar clique nos botões de tema
    if (mouseX > width/2 - 150 && mouseX < width/2 + 150) {
      if (mouseY > 150 && mouseY < 200) {
        // Clicou em Futebol
        categoriaEscolhida = "Futebol";
        telaSelecaoTema = false;
        iniciarJogo();
      } else if (mouseY > 220 && mouseY < 270) {
        // Clicou em Filmes
        categoriaEscolhida = "Filmes";
        telaSelecaoTema = false;
        iniciarJogo();
      }
    }
  } else if (!jogoAtivo) {
    // Verificar clique no botão de reiniciar
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100 && 
        mouseY > height - 100 && mouseY < height - 60) {
      telaSelecaoTema = true;
    }
  }
}

// Função que escolhe aleatoriamente uma palavra e inicia o jogo
void iniciarJogo() {
  if (categoriaEscolhida.equals("Futebol")) {
    palavraEscolhida = futebol[int(random(futebol.length))];
  } else {
    palavraEscolhida = filmes[int(random(filmes.length))];
  }
  
  // Cria a palavra oculta inicial (todos os caracteres são underscores)
  palavraOculta = "";
  for (int i = 0; i < palavraEscolhida.length(); i++) {
    if (palavraEscolhida.charAt(i) == ' ') {
      palavraOculta += " "; // Preserva os espaços
    } else {
      palavraOculta += "_";
    }
  }
  
  letrasErradas = new char[6];
  tentativas = 6;
  jogoAtivo = true;
  mensagem = "";  // Reseta a mensagem
}

// Função que verifica a letra escolhida
void keyPressed() {
  if (jogoAtivo && (key >= 'a' && key <= 'z' || key >= 'A' && key <= 'Z')) {
    char letra = Character.toLowerCase(key);  // Converte a letra para minúscula
    
    // Verificar se a letra já foi acertada
    boolean letraJaAcertada = false;
    for (int i = 0; i < palavraOculta.length(); i++) {
      if (palavraOculta.charAt(i) == letra) {
        letraJaAcertada = true;
        break;
      }
    }
    
    // Verificar se a letra já foi errada
    boolean letraJaErrada = verificaLetraErrada(letra);
    
    // Se a letra não foi tentada ainda
    if (!letraJaAcertada && !letraJaErrada) {
      boolean acertou = false;
      
      // Verifica se a letra existe na palavra
      for (int i = 0; i < palavraEscolhida.length(); i++) {
        if (palavraEscolhida.charAt(i) == letra) {
          // Substituir o underscore pela letra
          palavraOculta = palavraOculta.substring(0, i) + letra + palavraOculta.substring(i + 1);
          acertou = true;
        }
      }
      
      // Se não acertou, adiciona às letras erradas
      if (!acertou) {
        letrasErradas[6 - tentativas] = letra;
        tentativas--;
      }
      
      // Verifica se o jogo terminou
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

// Função que verifica se a letra já foi tentada
boolean verificaLetraErrada(char letra) {
  for (int i = 0; i < letrasErradas.length; i++) {
    if (letrasErradas[i] == letra) {
      return true;
    }
  }
  return false;
}
