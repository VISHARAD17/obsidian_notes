# AI Review Guide

A guide for an AI to use when reviewing, explaining, or expanding these notes.

---

## Vault Structure

```
obsidian_notes/
├── DSA/
│   ├── Dynamic Programming.md
│   ├── Graph.md
│   ├── BFS.md
│   └── DFS.md
├── leetcode-dsa-AI/
│   ├── Arrays.md
│   ├── String.md
│   ├── Binary Search.md
│   ├── Hashing.md
│   ├── Stacks.md
│   ├── Queues.md
│   ├── Questions.md
│   ├── Graph/
│   │   ├── BFS.md
│   │   ├── DFS.md
│   │   ├── Topological Sort.md
│   │   ├── Union Find.md
│   │   └── Shortest Path and MST.md
│   └── Dynamic Programming/
│       ├── 1D DP.md
│       ├── 2D DP Problems.md
│       ├── DP Knapsack.md
│       ├── DP intervals.md
│       └── DP trees and Multi Agent.md
├── System Design/
│   ├── Instagram.md
│   ├── Topics/
│   │   └── Kafka.md
│   └── HLD drawings/ (Excalidraw diagrams)
├── Everything Java.md
├── Currently studying.md
└── Switch.md
```

---

## Writing Style

These notes follow the **Hello Interview observer voice** — the subject is always the concept or the problem, never the reader.

**Use:**
- "The idea here is..."
- "Notice that..."
- "The key insight is..."
- "What's happening is..."
- "The trick is to recognize..."
- "The signal to reach for X is..."
- "This is where Y comes in..."

**Never use:**
- "you should", "you can", "you need to"
- "we do", "we use", "let's"
- Second-person address of any kind

Narrate through the problem. The reader is never addressed.

---

## How to Review a Note

When asked to review or explain a note:

1. **Read the note as-is** — understand what's there and what's missing.
2. **Identify gaps** — missing edge cases, missing time/space complexity, missing patterns, missing examples.
3. **Explain in the observer voice** — walk through the concept as if thinking out loud, not instructing.
4. **Ask before rewriting** — if the note is sparse, propose what to add before making changes.

---

## How to Expand a Note

When asked to expand or improve a note:

- Keep the existing content, add to it.
- Add a **Pattern** section if missing — what signal tells you to use this algorithm.
- Add **Time & Space complexity**.
- Add a **concrete example** with a small input traced step by step.
- Add **edge cases** worth remembering.
- Code examples should be in **Java** (the primary language used here) unless the file already has C++.

---

## Tone and Format

- Plain prose for explanations, not bullet-heavy walls.
- Code blocks for all code.
- Bold for key terms on first use.
- No headers like "Introduction" or "Conclusion".
- Keep it dense — this is a reference, not a tutorial.

---

## Context

The owner is preparing for software engineering interviews, covering:
- DSA (primary focus: graphs, DP, arrays, strings, binary search)
- System Design (HLD: Instagram, YouTube, Uber, WhatsApp, Spotify)
- Java

The notes in `leetcode-dsa-AI/` are more detailed and structured. The notes in `DSA/` are hand-written and sparser — those are the ones most likely to need expansion.
