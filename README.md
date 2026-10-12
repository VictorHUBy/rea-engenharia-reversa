# rea-engenharia-reversa

[![Engenharia reversa com IA](guia/assets/banner.jpg)](https://inematds.github.io/rea-engenharia-reversa/guia/)

**🇧🇷 Português · [🇺🇸 English](README.en.md) · [🇪🇸 Español](README.es.md)**

Guia em português sobre o **REA (Reverse Engineer Anything)**, a ferramenta aberta que dá ao seu agente de IA (Claude Code, Codex, Cursor, Gemini…) as ferramentas de engenharia reversa. Reúne os links, explica a tecnologia em linguagem simples, traz uma avaliação honesta de para quem isso é útil e um teste feito aqui. Os repositórios citados são de terceiros: este repo só organiza e explica.

## 🎬 Vídeo

- **[Lê o app, não o servidor](https://inematds.github.io/rea-engenharia-reversa/videos/#servidor)**: por que o REA lê o app do banco e não mexe na conta, o que vaza e a regra (1min36) · [reel](https://www.youtube.com/shorts/Wz1XZyEyFI8)
- **[REA por dentro (técnico)](https://inematds.github.io/rea-engenharia-reversa/videos/#tecnico)**: por que funciona, arquitetura, evidência, o teste antes e depois na 6.4.0 e os limites.
- **[REA na prática](https://inematds.github.io/rea-engenharia-reversa/videos/#na-pratica)**: clone um app em 4 passos (2 min) · [reel](https://www.youtube.com/shorts/B9D1phZJXWM)
- **[REA, a IA que faz engenharia reversa](https://inematds.github.io/rea-engenharia-reversa/videos/#completo)** (6 min, capítulos e legendas)
- No YouTube: [dá pra clonar o app que você usa](https://www.youtube.com/watch?v=dwxV0xXdElk) · [recria quase qualquer app?](https://www.youtube.com/watch?v=QQFhiUch0kk) · reels [1](https://www.youtube.com/shorts/eTgtEf5bnvU) [2](https://www.youtube.com/shorts/Hlmma9RB-UM) [3](https://www.youtube.com/shorts/HwbWFVrWC4w) [4](https://www.youtube.com/shorts/QWLSY0LfUAY)

## 📖 Guia de uso

Guia completo (landing + passo a passo): **https://inematds.github.io/rea-engenharia-reversa/guia/**

## O que é

Engenharia reversa é descobrir como um programa funciona olhando só o executável, sem o código-fonte. O REA (Reverse Engineer Anything) é uma ferramenta aberta que liga o seu agente de IA a descompiladores como o Ghidra, da NSA, e devolve as conclusões com a prova e os limites de cada uma. Serve para desenvolvedores, gente de segurança e quem estuda software. Para usar, você precisa de Node.js e de um agente de IA no terminal.

## Em 4 frases

- **Engenharia reversa** é entender como um programa funciona olhando só o executável, sem o código-fonte.
- O **Ghidra** (da NSA, grátis), o **Hopper** e o **IDA Pro** sempre fizeram isso, mas exigiam dias ou semanas de especialista.
- O **REA** é um servidor **MCP**: uma ponte entre o seu agente e esses programas. O agente pede "abre esse binário", "quem chama essa função?", e recebe pseudocódigo, assembly e ligações, **com evidência, limites e o que ficou sem resposta**.
- Tudo roda **na sua máquina**; o programa analisado não é enviado.

## Links

| Projeto | O que é | Licença |
|---|---|---|
| [morluto/rea](https://github.com/morluto/rea) | O REA: MCP + CLI de engenharia reversa para agentes (TypeScript, ~144 mil estrelas, versão 6.4.0 em 12/10/2026) | MIT |
| [rea.tools](https://rea.tools/) | Site oficial: guias ilustrados e casos reais | — |
| [NationalSecurityAgency/ghidra](https://github.com/NationalSecurityAgency/ghidra) | Ghidra, o descompilador gratuito da NSA (Java, ~82 mil estrelas, 12.1.4) | Apache-2.0 |
| [N0zoM1z0/dx-ball](https://github.com/N0zoM1z0/dx-ball) | Reconstrução do jogo DX-Ball 1.07 em C/C++ com REA + Ghidra, testada byte a byte | MIT |
| [N0zoM1z0/th04](https://github.com/N0zoM1z0/th04) | Reconstrução do Touhou 4 (PC-98, DOS 16 bits) | MIT |
| [storytold/photocraft](https://github.com/storytold/photocraft) | PhotoCraft: Photoshop refeito do zero em Rust, *clean room* (não usa o REA) | MIT / Apache-2.0 |
| [storytold/filmcraft](https://github.com/storytold/filmcraft) · [lightcraft](https://github.com/storytold/lightcraft) · [artcraft](https://github.com/storytold/artcraft) | Premiere, Lightroom e a suíte ArtCraft, mesmo método | Apache-2.0 |
| [SRE-Bench (Columbia)](https://daplab.cs.columbia.edu/projects/sre-bench/) | Benchmark de agentes em engenharia reversa de binários protegidos | — |

## Os casos que mostram o que dá pra fazer

- **Cofre fechado:** um app compilado sem nomes de função (242+ funções `FUN_…`). O agente achou a função certa em poucas chamadas, recuperou as 3 regras do código de desbloqueio e escreveu um gerador de códigos. O cofre abriu.
- **DX-Ball (anos 90):** 528 funções candidatas, 283 já reescritas, **140 idênticas byte a byte** ao original (22.674 bytes). O cálculo do som esquerda/direita passou em 3.205 testes contra o x86 original. Ciclo: rastrear no Ghidra → escrever em C → compilar com o Visual C++ 4 → comparar.
- **Fone de ouvido:** um usuário criou, em ~30 min de idas e vindas, um app próprio de um botão para ligar a redução de vento, no lugar do app oficial.
- **Notion:** o agente seguiu o "copiar e colar" do app até o processo principal do Electron e o formato da área de transferência.
- **PhotoCraft:** outro caminho, sem olhar o binário: documentação pública + testes contra o Photoshop. Ainda em alfa, com recursos faltando.

## Como começar

```bash
# precisa de Node.js 22.19+, 24.11+ ou 26+
npx rea-agents setup          # mostra o plano, faz backup da config e pergunta antes
rea doctor --client claude_code --json   # confere só o que a sua tarefa precisa
```

O teste mais barato, sem Ghidra nem MCP, é a análise estática de um app Electron:

```bash
npx -y rea-agents@latest analyze-javascript-application /caminho/absoluto/do/app.asar --json
```

Para binários nativos (Mac, Windows, Linux) é preciso um descompilador instalado: Ghidra (grátis), Hopper ou IDA.

**Quer fazer a sua própria versão de um app?** Veja o roteiro [Como reconstruir um app com o REA](pratica/RECONSTRUIR.md): escolher o alvo (o que é local vem, o que é nuvem não), montar o ambiente, entender antes de construir, iterar nos detalhes e ir além do original.

## Vale a pena? Avaliação

**Útil de verdade para:**

- **Desenvolvedores** que querem entender como um app muito bom resolve busca, sincronização ou área de transferência, e fazer a própria versão.
- **Segurança e privacidade:** auditar os apps instalados na sua máquina e ver o que eles mandam pra fora.
- **Recuperar lógica** de um programa seu cujo código se perdeu.
- **Estudo, CTF e preservação** de software antigo (jogos, sistemas legados).
- **Quem constrói ferramentas para LLM:** o formato de resposta do REA (evidência · mapa · limites · desconhecidos) é um bom modelo para qualquer agente.

**Não é para:**

- Leigos sem terminal: exige Node, linha de comando e paciência com versões que mudam todo dia (5.0 → 6.3 em três dias).
- Copiar o produto de um concorrente: é arriscado juridicamente e perde o ponto. Entenda a ideia e faça melhor.
- Programas muito protegidos (VMProtect, ofuscação pesada) ou cuja lógica roda no servidor: aí o REA ajuda pouco. O resultado também depende muito do modelo de IA usado.

### Reteste na 6.4.0 (12/10/2026)

O mesmo app Electron que travou na 6.3.0 terminou em **94,5 s** na 6.4.0, com pico de 1,26 GB: 202 arquivos JS lidos, 0 falhas, 13.500 achados. O arquivo que travava guardou os fatos estáticos e o resto virou limitação declarada. Rodamos isolado (HOME de teste, teto de memória e de tempo) com `--max-heap-mb 1024 --analysis-timeout-ms 60000`. Detalhes e o comando no [guia](https://inematds.github.io/rea-engenharia-reversa/guia/#teste64).

### Teste feito aqui (10/10/2026)

Rodamos o REA 6.3.0 (`analyze-javascript-application`, sem Ghidra e sem MCP) num servidor Linux ARM. **Funcionou** num app Node nosso (97 arquivos, 3,5 MB): em 20 s e 1,3 GB de RAM devolveu um grafo com 2.109 nós e 3.104 ligações, 2.508 achados e 5 limitações declaradas, sem executar o app. **Travou** em dois alvos que tinham um único arquivo JS gigante (o bundle de um app Electron instalado e o `typescript/_tsc.js`, de 6 MB): ficou a 100% de CPU por mais de 20 min no mesmo arquivo, ignorou o SIGTERM e só parou com `kill -9`. Conclusão: funciona bem em projetos de tamanho normal; em apps grandes, rode com teto de tempo (`timeout -s KILL`) e sem `node_modules`. O JSON completo é enorme (241 MB aqui): no dia a dia, deixe o agente consultar pelo MCP em vez de ler o arquivo inteiro.

## Cuidados

1. **Lei e licença:** muitas licenças proíbem engenharia reversa; quebrar proteção contra cópia é outro problema. Terreno seguro: programas seus, código aberto, desafios de segurança e o que você tem autorização para testar.
2. **Não é sandbox:** se o REA executar o alvo, ele roda com as suas permissões. Um binário estranho pode esconder instruções para enganar o agente. Use máquina isolada e mantenha as aprovações do agente ligadas.
3. **Muda todo dia:** atualize (`rea update` ou `npx rea-agents@latest setup`) antes de abrir um problema.

---

Mais conteúdo aberto e gratuito em **[inema.club](https://inema.club)**.
