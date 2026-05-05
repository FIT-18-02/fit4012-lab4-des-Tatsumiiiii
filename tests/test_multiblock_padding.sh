#!/usr/bin/env bash
set -euo pipefail

echo "[TEST] Multi-block + padding"

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

# dài > 64 bit
PLAINTEXT="101010101010101010101010101010101010101010101010101010101010101010101010"
KEY="1111000011110000111100001111000011110000111100001111000011110000"

CIPHERTEXT=$(echo -e "1\n$PLAINTEXT\n$KEY" | ./des)
DECRYPTED=$(echo -e "2\n$CIPHERTEXT\n$KEY" | ./des)

# so sánh phần đầu (vì có padding)
TRIMMED=${DECRYPTED:0:${#PLAINTEXT}}

if [[ "$TRIMMED" == "$PLAINTEXT" ]]; then
    echo "PASS"
    exit 0
else
    echo "FAIL"
    exit 1
fi