---
published: true
layout: post
title:  "Efficient Chess Board Representation"
date:   '2024-02-23 05:30:00 +0530'
tags:
  - general
  - project
---

> by [Raghava G. Dhanya](mailto:raghava.dhanya@gmail.com) and [Shashank S.](mailto:mail@knhash.in)

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

**Forsyth-Edwards Notation (FEN):** A compact, human-readable format that encodes the position of each piece on the board using a single character, along with additional information such as castling rights, en passant target square, half-move clock, and full-move number. FEN is widely used for exchanging chess positions between software applications and for storing game states in databases.  


## The Static Method - 192 bits
`(2^6) = 64` squares means we need 6 bits to store a position a position on the board. With 32 pieces in play at the start, we would need `(32 * 6) = 192` bits to store the position of all the pieces. But that is still not enough information, which position belongs to which piece?

### The Static Protocol
We encode the kind of piece using the following  protocol:
- Bits are chunked in sets of 6, each 6 bit chunk representing the position of a piece
- Chunks are ordered by kind, white pieces of a kind first.
  - Pawn, Rook, Bishop, Knight, Queen, King
  - So, for instance, the bits in the indexes `[113, 119]` tell the position of the second White Bishop

We therefore have the position of every piece, stored in 192 bits.

There is one more problem to solve, how to represent a piece that is no longer in play? Every piece apart from Pawn and certain Bishop can reach every square on the board, so we cannot set the value of a dead piece to any valid value within `[000000-111111]`.

We use the following two insights from the game:
1. The Kings are always in play
2. No two pieces can ever occupy the same square at a given instance

The final protocol thus becomes:
- Bits are chunked in sets of 6, each 6 bit chunk representing the position of a piece
- Chunks are ordered by kind, white pieces of a kind first.
  - Pawn, Rook, Bishop, Knight, Queen, King
  - So, for instance, the bits in the indexes `[113, 119]` tell the position of the second White Bishop
- Dead pieces have their position set to the position of their corresponding King

## The Dynamic Method - [42-228] bits
Maintaining location information for every dead piece as we keep progressing through the game is wasteful. We could possibly omit this if we are able to save the count of pieces in play, per kind, per side.

Consider the case for White Pawns. Lets add 4 more bits before the first 8 chunks, and call these the Alive Bits (AB). A value of 0 (0000) would indicate no Pawns left alive, a value of 8 (1000) would indicate all Pawns alive.

The AB will indicate how many of the following chunks to read. So if there are 5 pawns left alive, we would need `4 bits (0101)` plus `30 bits (6*5)` in total. So the bit-length to represent White Pawns would range between `(4+(0*6)) = 4 bits` and `(4+(0*6)) = 52 bits`.

Extending this to all the pieces, we have the dynamic protocol:

### The Dynamic Protocol
We start from the Static Protocol and have the following additional points:

- Every set of chunks of a particular kind, on every side, is preceded by a set of Alive Bits. The number of Alive Bits, per side per kind, are as follows:
  - Pawn: 4 bits
  - Rook, Bishop, Knight: 2 bits
  - Queen, King: 1 bit

The Alive Bits signify how many of the following chunks to be read. Thus, the number of bits needed to represent a particular game state can range between the following cases:
```
Best case:
(4 + (0*6*2)) + (2 + (0*6*2)) + (2 + (0*6*2)) + (2 + (0*6*2)) + (1 + (0*6*2)) + (1 + (1*6*2)) = 36 bits

Worst case:
(4 + (8*6))*2 + (2 + (2*6))*2 + (2 + (2*6))*2 + (2 +(2*6))*2 + (1 + (1*6))*2 + (1 + (1*6))*2 = 216 bits
```

Thus with the Dynamic Protocol the number of bits necessary to represent a game state matches the Static Protocol after two pieces' death and reduces going further.

### Additional game state information
In addition to the piece locations and Alive Bits, we also need to store information about en passant, castling, and the turn indicator in our dynamic protocol. To do this, we will add some extra bits to our representation:
- En passant: 1 bit to indicate if en passant capture is possible, and if it is, 6 bits to represent the target square (total of 7 bits, 1 bit when not possible).
- Castling: 4 bits to represent the castling rights for both sides (1 bit for each: white king-side, white queen-side, black king-side, and black queen-side).
- Turn indicator: 1 bit to represent which side has the turn to move (0 for white, 1 for black).

With these additional bits, the total number of bits needed to represent a game state using the Dynamic Method now ranges between:
```
Best case:
36 (from previous calculation) + 1 (no en passant) + 4 (castling) + 1 (turn indicator) = 42 bits

Worst case:
216 (from previous calculation) + 7 (en passant) + 4 (castling) + 1 (turn indicator) = 228 bits
```

Thus, the Dynamic Method can represent a chess game state with a varying number of bits between 42 and 228, providing a more space-efficient representation compared to the Static Method, especially as more pieces are captured.

## Code Implementation and Test Cases
We implemented the Dynamic Method in Python and compared its space efficiency with FEN notation using a set of test cases.

### Python Code Implementation
Please find the code in the following [GitHub repository](http://www.overleaf.com).

The `ChessEncoder` class provides functionality for encoding and decoding chess positions between Forsyth-Edwards Notation (FEN) and a custom binary format, referred to as the Dynamic Protocol.

The `encode_dynamic` method takes a FEN string as input and converts it into a binary string according to the Dynamic Protocol. This binary string represents the chess position, including the active color, castling rights, en passant square, and the positions of all pieces on the board.

The `decode_dynamic` method takes a binary string in the Dynamic Protocol format and converts it back into a FEN string, reconstructing the original chess position.

The `encode_base85` and `decode_base85` methods provide additional functionality for encoding and decoding the binary string into a base85 string, which can be useful for more compact storage or transmission of the chess position.

Our results show that the Dynamic Method is consistently more space-efficient than FEN notation, with an average space savings of around 35%. However, there are some caveats to consider:
- The increased space efficiency comes at the cost of increased complexity in the encoding and decoding process.
- In some cases, the computational overhead of the Dynamic Method may outweigh its space efficiency benefits, particularly for applications with strict performance requirements.
- This does not represent the half moves and full moves counters

These test cases demonstrate that the Dynamic Method is indeed more space-efficient than FEN notation, but with some caveats related to complexity and computational overhead. Future work could explore further optimizations and hybrid approaches that combine the best aspects of both methods.

### Test cases

```python
.
----------------------------------------------------------------------
Ran 1 test in 0.003s

OK
FEN: rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1
FEN notation size: 56
Encoded bit size: 222
base85 size: 35
base85: K7t7-vkf@-!yL2IUAKW6=jb7By?`F$_<rJi

FEN: rnbqkbnr/pppp1ppp/8/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2
FEN notation size: 62
Encoded bit size: 222
base85 size: 35
base85: 9)bxdvraw8lMHgtUAKW&=jb7By?`F$_<rJi

FEN: 8/4k3/8/8/8/8/8/4K3 w - - 0 1
FEN notation size: 29
Encoded bit size: 42
base85 size: 8
base85: 0ssI2B6I

FEN: rnbqkb1r/pppp1ppp/2n5/4P3/8/8/PPPP1PPP/RNBQKBNR w KQkq - 0 3
FEN notation size: 60
Encoded bit size: 216
base85 size: 34
base85: `UoVV%{ciV406w1w}Bd~m?3VxfF9%ce&T!

FEN: rnbqkbnr/pppp1ppp/8/4Pp2/8/8/PPPP1PPP/RNBQKBNR w KQkq f6 0 3
FEN notation size: 60
Encoded bit size: 228
base85 size: 37
base85: 5AA{pD6>vJNS6$9&t12H8t3RCZoPmW<M@8!d;

```

---

## Epilogue
The genesis of this project was a simple question: Can we create a short URL to represent any state of a chess game? This question led us down a path of exploration into data compression, encoding schemes, and the intricacies of chess game states.

The `ChessEncoder` class, at the heart of this project, is a testament to this journey. It leverages the Forsyth-Edwards Notation (FEN) and a custom binary format, the Dynamic Protocol, to encode and decode chess positions. The class also employs `base85` encoding to further compress the data, enabling the representation of complex game states in a compact format suitable for a URL.

The Dynamic Protocol captures all necessary information about a chess position, including the active color, castling rights, en passant square, and the positions of all pieces on the board. This ensures that the full state of a chess match can be accurately represented and retrieved.

> For more fun, we also wrote this structured as a research paper but we couldn't find a place that would accept this as a paper. If you want to read this in LaTeX format, check it out [here](https://github.com/knhash/EfficientChessBoardRepresentation/blob/main/ECBR.pdf)
