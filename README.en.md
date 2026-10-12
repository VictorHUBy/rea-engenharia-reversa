# rea-engenharia-reversa

[![Reverse engineering with AI](guia/assets/banner-en.jpg)](https://inematds.github.io/rea-engenharia-reversa/guia/en/)

**[🇧🇷 Português](README.md) · 🇺🇸 English · [🇪🇸 Español](README.es.md)**

A guide in English about **REA (Reverse Engineer Anything)**, the open tool that gives your AI agent (Claude Code, Codex, Cursor, Gemini…) reverse engineering tools. It gathers the links, explains the technology in plain language, offers an honest assessment of who this is useful for, and includes a test run here. The repositories cited belong to third parties: this repo only organizes and explains.

## 🎬 Video

- **[Inside REA (technical)](https://inematds.github.io/rea-engenharia-reversa/videos/#tecnico)**: why it works, architecture, evidence, the before/after test on 6.4.0 and the limits.
- **[REA in practice](https://inematds.github.io/rea-engenharia-reversa/videos/#na-pratica)**: clone an app in 4 steps (2 min) · [reel](https://www.youtube.com/shorts/B9D1phZJXWM)
- **[REA, the AI that does reverse engineering](https://inematds.github.io/rea-engenharia-reversa/videos/#completo)** (6 min, chapters and subtitles)
- On YouTube: [clone the app you use](https://www.youtube.com/watch?v=dwxV0xXdElk) · [rebuilds almost any app?](https://www.youtube.com/watch?v=QQFhiUch0kk) · reels [1](https://www.youtube.com/shorts/eTgtEf5bnvU) [2](https://www.youtube.com/shorts/Hlmma9RB-UM) [3](https://www.youtube.com/shorts/HwbWFVrWC4w) [4](https://www.youtube.com/shorts/QWLSY0LfUAY)

All videos are in Portuguese.

## 📖 User guide

Full guide (landing page + step by step): **https://inematds.github.io/rea-engenharia-reversa/guia/en/**

## What it is

Reverse engineering is figuring out how a program works by looking only at the executable, without the source code. REA (Reverse Engineer Anything) is an open tool that connects your AI agent to decompilers such as Ghidra, from the NSA, and returns its conclusions with the evidence and the limits of each one. It is for developers, security people and anyone who studies software. To use it, you need Node.js and an AI agent in the terminal.

## In 4 sentences

- **Reverse engineering** is understanding how a program works by looking only at the executable, without the source code.
- **Ghidra** (from the NSA, free), **Hopper** and **IDA Pro** have always done this, but they demanded days or weeks of an expert's time.
- **REA** is an **MCP** server: a bridge between your agent and those programs. The agent asks "open this binary", "who calls this function?", and receives pseudocode, assembly and links, **with evidence, limits and what was left unanswered**.
- Everything runs **on your machine**; the analyzed program is not uploaded.

## Links

| Project | What it is | License |
|---|---|---|
| [morluto/rea](https://github.com/morluto/rea) | REA: reverse engineering MCP + CLI for agents (TypeScript, ~144k stars, version 6.4.0 on Oct 12, 2026) | MIT |
| [rea.tools](https://rea.tools/) | Official site: illustrated guides and real cases | — |
| [NationalSecurityAgency/ghidra](https://github.com/NationalSecurityAgency/ghidra) | Ghidra, the NSA's free decompiler (Java, ~82k stars, 12.1.4) | Apache-2.0 |
| [N0zoM1z0/dx-ball](https://github.com/N0zoM1z0/dx-ball) | Reconstruction of the game DX-Ball 1.07 in C/C++ with REA + Ghidra, tested byte by byte | MIT |
| [N0zoM1z0/th04](https://github.com/N0zoM1z0/th04) | Reconstruction of Touhou 4 (PC-98, 16-bit DOS) | MIT |
| [storytold/photocraft](https://github.com/storytold/photocraft) | PhotoCraft: Photoshop rebuilt from scratch in Rust, *clean room* (does not use REA) | MIT / Apache-2.0 |
| [storytold/filmcraft](https://github.com/storytold/filmcraft) · [lightcraft](https://github.com/storytold/lightcraft) · [artcraft](https://github.com/storytold/artcraft) | Premiere, Lightroom and the ArtCraft suite, same method | Apache-2.0 |
| [SRE-Bench (Columbia)](https://daplab.cs.columbia.edu/projects/sre-bench/) | Benchmark of agents on reverse engineering of protected binaries | — |

## Cases that show what is possible

- **Locked vault:** an app compiled without function names (242+ `FUN_…` functions). The agent found the right function in a few calls, recovered the 3 rules of the unlock code and wrote a code generator. The vault opened.
- **DX-Ball (1990s):** 528 candidate functions, 283 already rewritten, **140 byte-for-byte identical** to the original (22,674 bytes). The left/right sound calculation passed 3,205 tests against the original x86. Cycle: trace in Ghidra → write in C → compile with Visual C++ 4 → compare.
- **Headphones:** a user built, in ~30 min of back and forth, their own one-button app to turn on wind reduction, in place of the official app.
- **Notion:** the agent followed the app's "copy and paste" down to the main Electron process and the clipboard format.
- **PhotoCraft:** another path, without looking at the binary: public documentation + tests against Photoshop. Still in alpha, with missing features.

## Getting started

```bash
# requires Node.js 22.19+, 24.11+ or 26+
npx rea-agents setup          # shows the plan, backs up the config and asks before proceeding
rea doctor --client claude_code --json   # checks only what your task needs
```

The cheapest test, with no Ghidra or MCP, is the static analysis of an Electron app:

```bash
npx -y rea-agents@latest analyze-javascript-application /absolute/path/to/app.asar --json
```

For native binaries (Mac, Windows, Linux) you need an installed decompiler: Ghidra (free), Hopper or IDA.

## Is it worth it? Assessment

**Truly useful for:**

- **Developers** who want to understand how a very good app handles search, sync or the clipboard, and build their own version.
- **Security and privacy:** auditing the apps installed on your machine and seeing what they send out.
- **Recovering logic** from a program of your own whose code was lost.
- **Study, CTF and preservation** of old software (games, legacy systems).
- **People building tools for LLMs:** REA's response format (evidence · map · limits · unknowns) is a good model for any agent.

**Not for:**

- Non-technical people without a terminal: it requires Node, the command line and patience with versions that change every day (5.0 → 6.3 in three days).
- Copying a competitor's product: it is legally risky and misses the point. Understand the idea and do it better.
- Heavily protected programs (VMProtect, heavy obfuscation) or ones whose logic runs on the server: REA helps little there. The result also depends a lot on the AI model used.

### Retest on 6.4.0 (Oct 12, 2026)

The same Electron app that hung on 6.3.0 finished in **94.5 s** on 6.4.0, peaking at 1.26 GB: 202 JS files read, 0 failures, 13,500 findings. The file that used to hang kept its static facts and the rest became a declared limitation. We ran it isolated (test HOME, memory and time limits) with `--max-heap-mb 1024 --analysis-timeout-ms 60000`. Details and the command in the [guide](https://inematds.github.io/rea-engenharia-reversa/guia/en/#teste64).

### Test run here (10/10/2026)

We ran REA 6.3.0 (`analyze-javascript-application`, without Ghidra and without MCP) on a Linux ARM server. It **worked** on a Node app of ours (97 files, 3.5 MB): in 20 s and 1.3 GB of RAM it returned a graph with 2,109 nodes and 3,104 links, 2,508 findings and 5 declared limitations, without running the app. It **hung** on two targets that had a single giant JS file (the bundle of an installed Electron app and `typescript/_tsc.js`, 6 MB): it stayed at 100% CPU for more than 20 min on the same file, ignored SIGTERM and only stopped with `kill -9`. Conclusion: it works well on normal-sized projects; on large apps, run it with a time limit (`timeout -s KILL`) and without `node_modules`. The full JSON is huge (241 MB here): day to day, let the agent query through MCP instead of reading the whole file.

## Cautions

1. **Law and license:** many licenses forbid reverse engineering; breaking copy protection is a separate problem. Safe ground: your own programs, open source, security challenges and whatever you are authorized to test.
2. **It is not a sandbox:** if REA runs the target, it runs with your permissions. A strange binary can hide instructions to trick the agent. Use an isolated machine and keep the agent's approvals turned on.
3. **It changes every day:** update (`rea update` or `npx rea-agents@latest setup`) before opening an issue.

---

More open and free content at **[inema.club](https://inema.club)**.
