# rea-engenharia-reversa

[![Ingeniería inversa con IA](guia/assets/banner-es.jpg)](https://inematds.github.io/rea-engenharia-reversa/guia/es/)

**[🇧🇷 Português](README.md) · [🇺🇸 English](README.en.md) · 🇪🇸 Español**

Guía en español sobre **REA (Reverse Engineer Anything)**, la herramienta abierta que le da a tu agente de IA (Claude Code, Codex, Cursor, Gemini…) las herramientas de ingeniería inversa. Reúne los enlaces, explica la tecnología en lenguaje simple, trae una evaluación honesta de para quién es útil y una prueba hecha aquí. Los repositorios citados son de terceros: este repo solo organiza y explica.

## 🎬 Video

- **[REA por dentro (técnico)](https://inematds.github.io/rea-engenharia-reversa/videos/#tecnico)**: por qué funciona, arquitectura, evidencia, la prueba antes y después en 6.4.0 y los límites.
- **[REA en la práctica](https://inematds.github.io/rea-engenharia-reversa/videos/#na-pratica)**: clona una app en 4 pasos (2 min) · [reel](https://www.youtube.com/shorts/B9D1phZJXWM)
- **[REA, la IA que hace ingeniería inversa](https://inematds.github.io/rea-engenharia-reversa/videos/#completo)** (6 min, capítulos y subtítulos)
- En YouTube: [clona la app que usas](https://www.youtube.com/watch?v=dwxV0xXdElk) · [¿recrea casi cualquier app?](https://www.youtube.com/watch?v=QQFhiUch0kk) · reels [1](https://www.youtube.com/shorts/eTgtEf5bnvU) [2](https://www.youtube.com/shorts/Hlmma9RB-UM) [3](https://www.youtube.com/shorts/HwbWFVrWC4w) [4](https://www.youtube.com/shorts/QWLSY0LfUAY)

Todos los videos están en portugués.

## 📖 Guía de uso

Guía completa (landing + paso a paso): **https://inematds.github.io/rea-engenharia-reversa/guia/es/**

## Qué es

La ingeniería inversa consiste en descubrir cómo funciona un programa mirando solo el ejecutable, sin el código fuente. REA (Reverse Engineer Anything) es una herramienta abierta que conecta a tu agente de IA con descompiladores como Ghidra, de la NSA, y devuelve las conclusiones con la prueba y los límites de cada una. Sirve para desarrolladores, gente de seguridad y quienes estudian software. Para usarla, necesitas Node.js y un agente de IA en la terminal.

## En 4 frases

- La **ingeniería inversa** es entender cómo funciona un programa mirando solo el ejecutable, sin el código fuente.
- **Ghidra** (de la NSA, gratis), **Hopper** e **IDA Pro** siempre hicieron eso, pero exigían días o semanas de un especialista.
- **REA** es un servidor **MCP**: un puente entre tu agente y esos programas. El agente pide "abre este binario", "¿quién llama a esta función?", y recibe pseudocódigo, ensamblador y vínculos, **con evidencia, límites y lo que quedó sin respuesta**.
- Todo corre **en tu máquina**; el programa analizado no se envía.

## Enlaces

| Proyecto | Qué es | Licencia |
|---|---|---|
| [morluto/rea](https://github.com/morluto/rea) | REA: MCP + CLI de ingeniería inversa para agentes (TypeScript, ~144 mil estrellas, versión 6.4.0 el 09/10/2026) | MIT |
| [rea.tools](https://rea.tools/) | Sitio oficial: guías ilustradas y casos reales | — |
| [NationalSecurityAgency/ghidra](https://github.com/NationalSecurityAgency/ghidra) | Ghidra, el descompilador gratuito de la NSA (Java, ~82 mil estrellas, 12.1.4) | Apache-2.0 |
| [N0zoM1z0/dx-ball](https://github.com/N0zoM1z0/dx-ball) | Reconstrucción del juego DX-Ball 1.07 en C/C++ con REA + Ghidra, probada byte a byte | MIT |
| [N0zoM1z0/th04](https://github.com/N0zoM1z0/th04) | Reconstrucción de Touhou 4 (PC-98, DOS de 16 bits) | MIT |
| [storytold/photocraft](https://github.com/storytold/photocraft) | PhotoCraft: Photoshop rehecho desde cero en Rust, *clean room* (no usa REA) | MIT / Apache-2.0 |
| [storytold/filmcraft](https://github.com/storytold/filmcraft) · [lightcraft](https://github.com/storytold/lightcraft) · [artcraft](https://github.com/storytold/artcraft) | Premiere, Lightroom y la suite ArtCraft, mismo método | Apache-2.0 |
| [SRE-Bench (Columbia)](https://daplab.cs.columbia.edu/projects/sre-bench/) | Benchmark de agentes en ingeniería inversa de binarios protegidos | — |

## Los casos que muestran lo que se puede hacer

- **Caja fuerte cerrada:** una app compilada sin nombres de función (242+ funciones `FUN_…`). El agente encontró la función correcta en pocas llamadas, recuperó las 3 reglas del código de desbloqueo y escribió un generador de códigos. La caja fuerte se abrió.
- **DX-Ball (años 90):** 528 funciones candidatas, 283 ya reescritas, **140 idénticas byte a byte** al original (22.674 bytes). El cálculo del sonido izquierda/derecha pasó 3.205 pruebas contra el x86 original. Ciclo: rastrear en Ghidra → escribir en C → compilar con Visual C++ 4 → comparar.
- **Auriculares:** un usuario creó, en ~30 min de idas y vueltas, una app propia de un botón para activar la reducción de viento, en lugar de la app oficial.
- **Notion:** el agente siguió el "copiar y pegar" de la app hasta el proceso principal de Electron y el formato del portapapeles.
- **PhotoCraft:** otro camino, sin mirar el binario: documentación pública + pruebas contra Photoshop. Todavía en alfa, con funciones faltantes.

## Cómo empezar

```bash
# requiere Node.js 22.19+, 24.11+ o 26+
npx rea-agents setup          # muestra el plan, hace copia de seguridad de la config y pregunta antes
rea doctor --client claude_code --json   # verifica solo lo que tu tarea necesita
```

La prueba más barata, sin Ghidra ni MCP, es el análisis estático de una app Electron:

```bash
npx -y rea-agents@latest analyze-javascript-application /ruta/absoluta/de/app.asar --json
```

Para binarios nativos (Mac, Windows, Linux) hace falta un descompilador instalado: Ghidra (gratis), Hopper o IDA.

**¿Quieres hacer tu propia versión de una app?** Mira el paso a paso [Cómo reconstruir una app con REA](pratica/RECONSTRUIR.md) (en portugués): elegir el objetivo (lo local viene, lo de la nube no), preparar el agente, entender antes de construir, iterar en los detalles e ir más allá del original.

## ¿Vale la pena? Evaluación

**Realmente útil para:**

- **Desarrolladores** que quieren entender cómo una app muy buena resuelve búsqueda, sincronización o portapapeles, y hacer su propia versión.
- **Seguridad y privacidad:** auditar las apps instaladas en tu máquina y ver qué envían hacia afuera.
- **Recuperar la lógica** de un programa tuyo cuyo código se perdió.
- **Estudio, CTF y preservación** de software antiguo (juegos, sistemas heredados).
- **Quienes construyen herramientas para LLM:** el formato de respuesta de REA (evidencia · mapa · límites · desconocidos) es un buen modelo para cualquier agente.

**No es para:**

- Personas sin conocimientos técnicos ni terminal: exige Node, línea de comandos y paciencia con versiones que cambian todos los días (5.0 → 6.3 en tres días).
- Copiar el producto de un competidor: es riesgoso jurídicamente y pierde el punto. Entiende la idea y hazlo mejor.
- Programas muy protegidos (VMProtect, ofuscación pesada) o cuya lógica corre en el servidor: ahí REA ayuda poco. El resultado también depende mucho del modelo de IA usado.

### Nueva prueba en 6.4.0 (12/10/2026)

La misma app Electron que se trabó en 6.3.0 terminó en **94,5 s** en 6.4.0, con un pico de 1,26 GB: 202 archivos JS leídos, 0 fallas, 13.500 hallazgos. El archivo que se trababa conservó sus hechos estáticos y el resto quedó como limitación declarada. Lo corrimos aislado (HOME de prueba, límite de memoria y de tiempo) con `--max-heap-mb 1024 --analysis-timeout-ms 60000`. Detalles y el comando en la [guía](https://inematds.github.io/rea-engenharia-reversa/guia/es/#teste64).

### Prueba hecha aquí (10/10/2026)

Corrimos REA 6.3.0 (`analyze-javascript-application`, sin Ghidra y sin MCP) en un servidor Linux ARM. **Funcionó** en una app Node nuestra (97 archivos, 3,5 MB): en 20 s y 1,3 GB de RAM devolvió un grafo con 2.109 nodos y 3.104 vínculos, 2.508 hallazgos y 5 limitaciones declaradas, sin ejecutar la app. **Se trabó** en dos objetivos que tenían un único archivo JS gigante (el bundle de una app Electron instalada y el `typescript/_tsc.js`, de 6 MB): quedó al 100% de CPU por más de 20 min en el mismo archivo, ignoró el SIGTERM y solo se detuvo con `kill -9`. Conclusión: funciona bien en proyectos de tamaño normal; en apps grandes, córrelo con un tope de tiempo (`timeout -s KILL`) y sin `node_modules`. El JSON completo es enorme (241 MB aquí): en el día a día, deja que el agente consulte por MCP en lugar de leer el archivo entero.

## Cuidados

1. **Ley y licencia:** muchas licencias prohíben la ingeniería inversa; romper la protección contra copia es otro problema. Terreno seguro: programas tuyos, código abierto, desafíos de seguridad y lo que tienes autorización para probar.
2. **No es un sandbox:** si REA ejecuta el objetivo, corre con tus permisos. Un binario extraño puede esconder instrucciones para engañar al agente. Usa una máquina aislada y mantén activadas las aprobaciones del agente.
3. **Cambia todos los días:** actualiza (`rea update` o `npx rea-agents@latest setup`) antes de abrir un problema.

---

Más contenido abierto y gratuito en **[inema.club](https://inema.club)**.
