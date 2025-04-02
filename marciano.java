import java.util.*;

public class Main {
    public static void main(String[] args) {
        Random s = new Random();
        Scanner ler = new Scanner(System.in);
        Map<Integer, List<String>> recordes = new HashMap<>();
        recordes.put(0, new ArrayList<>());
        recordes.put(1, new ArrayList<>());
        recordes.put(2, new ArrayList<>());

        int estadoJogo = 1;
        int dificuldadeJogo = 1;
        int maxTentativas;

        System.out.println("Um marciano chegou na terra e ficou preso em uma árvore, ache ele antes que fuja!");
        
        System.out.println("Escolha uma dificuldade!");
        System.out.println("Digite 0 para FÁCIL | Digite 1 para NORMAL | Digite 2 para DIFÍCIL");
        dificuldadeJogo = ler.nextInt();
        while ((dificuldadeJogo != 0) && (dificuldadeJogo != 1) && (dificuldadeJogo != 2)) {
            System.out.println("Dificuldade inválida! Escolha novamente.");
            dificuldadeJogo = ler.nextInt();
        }
        
        maxTentativas = (dificuldadeJogo == 0) ? 9 : (dificuldadeJogo == 1) ? 7 : 5;

        while (estadoJogo != 0) {
            int arvore = s.nextInt(100) + 1;
            System.out.println(arvore);
            int nTentativas = 1;
            int tentativa;

            System.out.println("Tente advinhar em qual árvore está o marciano");
            System.out.println("Você tem " + maxTentativas + " tentativas!");
            tentativa = ler.nextInt();

            while ((tentativa != arvore) && (maxTentativas != nTentativas)) {
                System.out.println(nTentativas + "ª Tentativa: " + tentativa);
                nTentativas++;
                System.out.println(tentativa > arvore ? "Árvore é menor, tente mais baixo!" : "Árvore é maior, tente mais alto");
                tentativa = ler.nextInt();
            }
            
            if (tentativa == arvore) {
                System.out.println("Parabéns, você acertou na " + nTentativas + "ª tentativa!");
                System.out.println("Você gostaria de registrar seu recorde? (1-SIM | 0-NÃO)");
                int escolhaRegistro = ler.nextInt();
                
                if (escolhaRegistro == 1) {
                    System.out.println("Digite seu nome:");
                    String nome = ler.next();
                    List<String> ranking = recordes.get(dificuldadeJogo);
                    
                    ranking.add(nome + " - " + nTentativas + " tentativas");
                    ranking.sort(Comparator.comparingInt(a -> Integer.parseInt(a.split(" - ")[1].split(" ")[0])));
                    
                    if (ranking.size() > 5) {
                        ranking.remove(5); // Mantém apenas os 5 melhores
                    }
                }
            } else {
                System.out.println("O marciano fugiu! Ele estava na árvore " + arvore + "!");
            }
            
            boolean algumRecorde = recordes.values().stream().anyMatch(list -> !list.isEmpty());
            if (algumRecorde) {
                System.out.println("\nQuadro de recordes:");
                for (Map.Entry<Integer, List<String>> entry : recordes.entrySet()) {
                    String dificuldade = entry.getKey() == 0 ? "FÁCIL" : entry.getKey() == 1 ? "NORMAL" : "DIFÍCIL";
                    System.out.println(dificuldade + ":");
                    List<String> ranking = entry.getValue();
                    if (ranking.isEmpty()) {
                        System.out.println("Sem recordes\n");
                    } else {
                        ranking.forEach(System.out::println);
                        System.out.println();
                    }
                }
            }
            
            System.out.println("Deseja jogar novamente? (0-SAIR | 1-JOGAR NOVAMENTE | 2-MUDAR DIFICULDADE)");
            estadoJogo = ler.nextInt();
            
            if (estadoJogo == 2) {
                System.out.println("Escolha uma nova dificuldade (0-FÁCIL | 1-NORMAL | 2-DIFÍCIL)");
                dificuldadeJogo = ler.nextInt();
                while ((dificuldadeJogo != 0) && (dificuldadeJogo != 1) && (dificuldadeJogo != 2)) {
                    System.out.println("Dificuldade inválida! Escolha novamente.");
                    dificuldadeJogo = ler.nextInt();
                }
                maxTentativas = (dificuldadeJogo == 0) ? 9 : (dificuldadeJogo == 1) ? 7 : 5;
            }
        }
    }
}
