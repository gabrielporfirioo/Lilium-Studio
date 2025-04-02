// Arrays com as palavras dos temas (50 itens em cada)
String[] filmes = {
  "um sonho de liberdade", "o poderoso chefao", "o cavaleiro das trevas", "a lista de schindler", 
  "pulp fiction tempo de violencia", "o senhor dos anéis o retorno do rei", "clube da luta", "a origem", 
  "forrest gump o contador de historias", "star wars o imperio contra-ataca", "os bons companheiros", 
  "o senhor dos aneis a sociedade do anel", "cidade de deus", "o senhor dos aneis as duas torres", 
  "star wars a nova esperanza", "o iluminado", "a vida é bela", "matrix", "vingadores ultimato", 
  "se7en os sete crimes capitais", "o pianista", "a bela e a fera", "o rei leao", "cidadao kane", 
  "taxi driver", "a sociedade dos poetas mortos", "o silencio dos inocentes", "the green mile", 
  "a caça", "gladiador", "os infiltrados", "memento", "batman o cavaleiro das trevas ressurge", 
  "whiplash", "o grande lebowski", "vingadores guerra infinita", "o labirinto do fauno", 
  "os sete samurais", "o exorcista", "12 homens e uma sentença", "o grande hotel budapeste", 
  "vingadores a guerra civil", "pantera negra", "a forma da agua", "o profissional", 
  "o exterminador do futuro 2", "o lobo de wall street", "o homem que copiava", "trainspotting", "a rede social"
};

String[] futebol = {
  "Sport","flamengo", "palmeiras", "sao paulo", "corinthians", "gremio", "internacional", "fluminense", 
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
  size(600, 400);
  textSize(30);
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
    
    // Exibir palavra oculta
    textSize(30);
    fill(0);
    text(palavraOculta, width / 2, 120);
    
    // Exibir letras erradas
    textSize(20);
    text("Letras erradas: " + String.valueOf(letrasErradas), width / 2, 170);
    
    // Exibir tentativas restantes
    text("Tentativas restantes: " + tentativas, width / 2, 220);
    
    // Exibir mensagem de vitória ou derrota
    fill(jogoAtivo ? 0 : (tentativas == 0 ? color(255, 0, 0) : color(0, 128, 0)));
    text(mensagem, width / 2, height - 50);
    
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
  
  // Cria a palavra oculta com espaços preservados
  palavraOculta = "";
  for (int i = 0; i < palavraEscolhida.length(); i++) {
    if (palavraEscolhida.charAt(i) == ' ') {
      palavraOculta += "  "; // Adiciona dois espaços para separar as palavras visualmente
    } else {
      palavraOculta += "_ ";
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
    for (int i = 0; i < palavraEscolhida.length(); i++) {
      if (palavraEscolhida.charAt(i) == letra) {
        if (palavraOculta.charAt(i*2) == letra) {
          letraJaAcertada = true;
          break;
        }
      }
    }
    
    // Verifica se a letra já foi tentada antes
    if (!letraJaAcertada && !verificaLetraErrada(letra)) {
      if (palavraEscolhida.indexOf(letra) != -1) {
        // Letra correta
        for (int i = 0; i < palavraEscolhida.length(); i++) {
          if (palavraEscolhida.charAt(i) == letra) {
            palavraOculta = palavraOculta.substring(0, i*2) + letra + palavraOculta.substring(i*2 + 1);
          }
        }
      } else {
        // Letra errada
        letrasErradas[6 - tentativas] = letra;
        tentativas--;
      }
      
      // Verifica se o jogo terminou
      boolean ganhou = true;
      for (int i = 0; i < palavraEscolhida.length(); i++) {
        if (palavraEscolhida.charAt(i) != ' ' && palavraOculta.charAt(i*2) == '_') {
          ganhou = false;
          break;
        }
      }
      
      if (ganhou) {
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
