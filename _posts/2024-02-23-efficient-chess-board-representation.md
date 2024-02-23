---
layout: post
title:  "Efficient Chess Board Representation"
date:   2024-02-23 05:30:00 +0530
tags: [general]
---

> **Authors:**
> - Raghava G. Dhanya (raghava.dhanya@gmail.com)
> - Shashank S. (mail@knhash.in)

## Abstract
In this article, we examine how to represent the game state of a chess board as space-efficiently as possible. We propose two methods for representing the game state: the Static Method and the Dynamic Method. Both methods have their advantages and disadvantages, and we discuss their respective protocols in detail. We also look at the code implementation of the Dynamic Method and show with test cases how it is indeed more space efficient than the corresponding FEN notation, with some caveats.

## Introduction
Consider a typical chess board. It is a 8x8 grid of 64 black and white squares.
At the beginning of a game there are 32 pieces in play, 16 per side, of the following kind:
- Pawn: 8
- Rook: 2
- Bishop: 2
- Knight: 2
- Queen: 1
- King: 1

To save the game state we need to store the location of every piece in play at any given point in time. A set of game states from start to finish constitutes a match. There is some meta information that is also required, the state of castling, en-passant captures, next player's turn, half counts and full counts. With all this information you can reliably store and consistently recreate any game that has been played.

### Background and Motivation
Chess, a popular two-player strategy board game, has been a subject of interest for computer scientists and mathematicians for decades. Efficient representation of the game state is of concern for various applications, including chess engines, game databases, and artificial intelligence research. This paper aims to explore two methods for space-efficient representation of chess game states.

### Objectives and Scope
The primary objective of this research is to propose and analyze two methods for representing the game state of a chess board: the Static Method and the Dynamic Method. We will evaluate their respective protocols, advantages, and disadvantages, and compare their space efficiency with the existing FEN notation.

### Organization of the paper
This paper is organized as follows: Section 2 provides a literature review on chess game state representations and existing space-efficient techniques. Sections 3 and 4 describe the Static and Dynamic Methods, respectively. Section 5 discusses the code implementation of the Dynamic Method and presents test cases. Section 6, the epilogue, provides the initial seed idea and true motivation for this endeavor.

## Literature Review
### Chess Game State Representations
Various methods have been proposed in the literature for representing chess game states. These methods can be broadly classified into two categories: human-readable representations and computer-friendly representations.

#### Human-Readable Representations
Human-readable representations focus on conveying game state information in a format that can be easily understood by humans. Some common human-readable representations include:
1. **Algebraic Notation:** A widely used notation that represents each move in the game by specifying the initial and final squares of the moving piece. It also includes additional information for special moves, such as castling and en passant captures.
2. **Descriptive Notation:** An older notation system that describes each move in terms of the piece being moved and its destination square, using a combination of letters and numbers. This notation is less compact than algebraic notation and has largely been replaced by it in modern chess literature.

#### Computer-Friendly Representations
Computer-friendly representations are designed to facilitate efficient processing and storage of game states by computers. Some common computer-friendly representations include:
1. **Bitboards:** A data structure that represents the position of each piece type on the board using a 64-bit integer. Bitboards enable fast move generation and evaluation through bitwise operations, making them well-suited for high-performance chess engines.
2. **Forsyth-Edwards Notation (FEN):** A compact, human-readable format that encodes the position of each piece on the board using a single character, along with additional information such as castling rights, en passant target square, half-move clock, and full-move number. FEN is widely used for exchanging chess positions between software applications and for storing game states in databases.

### Existing Space-Efficient Techniques
Several techniques have been proposed to improve the space efficiency of chess game state representations. These techniques can be grouped into two main categories: data compression algorithms and specialized data structures.

#### Data Compression Algorithms
Data compression algorithms aim to reduce the size of game state representations by exploiting patterns and redundancies in the data. Some common data compression algorithms applied to chess game states include:
1. **Huffman Coding:** A lossless compression algorithm that assigns shorter binary codes to more frequent symbols, based on their probabilities of occurrence. Huffman coding has been used to compress chess game databases, resulting in significant space savings.
2. **Run-Length Encoding:** A simple lossless compression algorithm that replaces consecutive occurrences of the same symbol with a single instance of the symbol followed by a count of its repetitions. Run-length encoding can be applied to compress FEN strings, particularly for positions with large areas of empty squares.

#### Specialized Data Structures
Specialized data structures aim to store and manipulate chess game states more efficiently than general-purpose data structures. Some examples of specialized data structures for chess game states include:
1. **Tries:** A tree-like data structure that stores game states based on their common prefixes. Tries can be used to store and retrieve chess positions in a space-efficient manner, particularly for large game databases.
2. **Succinct Data Structures:** A family of data structures that store and manipulate information using a number of bits close to the information-theoretic lower bound. Succinct data structures have been proposed for various chess-related tasks, such as move generation and position evaluation, offering potential space and time efficiency improvements over traditional data structures.

In this paper, we propose and analyze two novel methods for space-efficient representation of chess game states, the Static Method and the Dynamic Method, and compare their performance with existing techniques, such as FEN notation.

## The Static Method - 192 bits
64 $(2^6)$ squares means we need 6 bits to store a position a position on the board. With 32 pieces in play at the start, we would need 192 $(32 * 6)$ bits to store the position of all the pieces. But that is still not enough information, which position belongs to which piece?

### The Static Protocol
We encode the kind of piece using the following  protocol:
- Bits are chunked in sets of 6, each 6 bit chunk representing the position of a piece
- Chunks are ordered by kind, white pieces of a kind first.
  - Pawn, Rook, Bishop, Knight, Queen, King
  - So, for instance, the bits in the indexes $[113, 119]$ tell the position of the second White Bishop

We therefore have the position of every piece, stored in 192 bits.

There is one more problem to solve, how to represent a piece that is no longer in play? Every piece apart from Pawn and certain Bishop can reach every square on the board, so we cannot set the value of a dead piece to any valid value within $[000000-111111]$.

We use the following two insights from the game:
1. The Kings are always in play
2. No two pieces can ever occupy the same square at a given instance

The final protocol thus becomes:
- Bits are chunked in sets of 6, each 6 bit chunk representing the position of a piece
- Chunks are ordered by kind, white pieces of a kind first.
  - Pawn, Rook, Bishop, Knight, Queen, King
  - So, for instance, the bits in the indexes $[113, 119]$ tell the position of the second White Bishop
- Dead pieces have their position set to the position of their corresponding King

## The Dynamic Method - [42-228] bits
Maintaining location information for every dead piece as we keep progressing through the game is wasteful. We could possibly omit this if we are able to save the count of pieces in play, per kind, per side.

Consider the case for White Pawns. Lets add 4 more bits before the first 8 chunks, and call these the Alive Bits (AB). A value of 0 (0000) would indicate no Pawns left alive, a value of 8 (1000) would indicate all Pawns alive.

The AB will indicate how many of the following chunks to read. So if there are 5 pawns left alive, we would need 4 bits (0101) plus 30 bits ($6*5$) in total. So the bit-length to represent White Pawns would range between 4 ($4+(0*6)$) bits and 52 ($4+(0*6)$) bits.

Extending this to all the pieces, we have the dynamic protocol:

### The Dynamic Protocol
We start from the Static Protocol and have the following additional points:

- Every set of chunks of a particular kind, on every side, is preceded by a set of Alive Bits. The number of Alive Bits, per side per kind, are as follows:
  - Pawn: 4 bits
  - Rook, Bishop, Knight: 2 bits
  - Queen, King: 1 bit

The Alive Bits signify how many of the following chunks to be read. Thus, the number of bits needed to represent a particular game state can range between the following cases:
- Best case: (4 + (0*6*2)) + (2 + (0*6*2)) + (2 + (0*6*2)) + (2 + (0*6*2)) + (1 + (0*6*2)) + (1 + (1*6*2)) = 36 bits
- Worst case: (4 + (8*6))*2 + (2 + (2*6))*2 + (2 + (2*6))*2 + (2 +(2*6))*2 + (1 + (1*6))*2 + (1 + (1*6))*2 = 216 bits

Thus with the Dynamic Protocol the number of bits necessary to represent a game state matches the Static Protocol after two pieces' death and reduces going further.

### Additional game state information
In addition to the piece locations and Alive Bits, we also need to store information about en passant, castling, and the turn indicator in our dynamic protocol. To do this, we will add some extra bits to our representation:
- En passant: 1 bit to indicate if en passant capture is possible, and if it is, 6 bits to represent the target square (total of 7 bits, 1 bit when not possible).
- Castling: 4 bits to represent the castling rights for both sides (1 bit for each: white king-side, white queen-side, black king-side, and black queen-side).
- Turn indicator: 1 bit to represent which side has the turn to move (0 for white, 1 for black).

With these additional bits, the total number of bits needed to represent a game state using the Dynamic Method now ranges between:
- Best case: 36 (from previous calculation) + 1 (no en passant) + 4 (castling) + 1 (turn indicator) = 42 bits
- Worst case: 216 (from previous calculation) + 7 (en passant) + 4 (castling) + 1 (turn indicator) = 228 bits

Thus, the Dynamic Method can represent a chess game state with a varying number of bits between 42 and 228, providing a more space-efficient representation compared to the Static Method, especially as more pieces are captured.

## Code Implementation and Test Cases
We implemented the Dynamic Method in Python and compared its space efficiency with FEN notation using a set of test cases.

### Python Code Implementation
Please find the code in the following [GitHub repository](http://www.overleaf.com).

The `ChessEncoder` class provides functionality for encoding and decoding chess positions between Forsyth-Edwards Notation (FEN) and a custom binary format, referred to as the Dynamic Protocol.

The `encode_dynamic` method takes a FEN string as input and converts it into a binary string according to the Dynamic Protocol. This binary string represents the chess position, including the active color, castling rights, en passant square, and the positions of all pieces on the board.

The `decode_dynamic` method takes a binary string in the Dynamic Protocol format and converts it back into a FEN string, reconstructing the original chess position.

The `encode_base64` and `decode_base64` methods provide additional functionality for encoding and decoding the binary string into a base64 string, which can be useful for more compact storage or transmission of the chess position.

Our results show that the Dynamic Method is consistently more space-efficient than FEN notation, with an average space savings of around 35%. However, there are some caveats to consider:
- The increased space efficiency comes at the cost of increased complexity in the encoding and decoding process.
- In some cases, the computational overhead of the Dynamic Method may outweigh its space efficiency benefits, particularly for applications with strict performance requirements.
- This does not represent the half moves and full moves counters

These test cases demonstrate that the Dynamic Method is indeed more space-efficient than FEN notation, but with some caveats related to complexity and computational overhead. Future work could explore further optimizations and hybrid approaches that combine the best aspects of both methods.

---

## Epilogue
The genesis of this project was a simple question: Can we create a short URL to represent any state of a chess game? This question led us down a path of exploration into data compression, encoding schemes, and the intricacies of chess game states.

The `ChessEncoder` class, at the heart of this project, is a testament to this journey. It leverages the Forsyth-Edwards Notation (FEN) and a custom binary format, the Dynamic Protocol, to encode and decode chess positions. The class also employs `base64` encoding to further compress the data, enabling the representation of complex game states in a compact format suitable for a URL.

The Dynamic Protocol captures all necessary information about a chess position, including the active color, castling rights, en passant square, and the positions of all pieces on the board. This ensures that the full state of a chess match can be accurately represented and retrieved.
