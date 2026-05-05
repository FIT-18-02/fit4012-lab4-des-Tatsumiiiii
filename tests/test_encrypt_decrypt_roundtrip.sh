#!/usr/bin/env bash
set -euo pipefail

echo "[TEST] Encrypt -> Decrypt roundtrip"

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

PLAINTEXT="1100110011001100110011001100110011001100110011001100110011001100"
KEY="1010101010101010101010101010101010101010101010101010101010101010"

CIPHERTEXT=$(echo -e "1\n$PLAINTEXT\n$KEY" | ./des)
DECRYPTED=$(echo -e "2\n$CIPHERTEXT\n$KEY" | ./des)

if [[ "$DECRYPTED" == "$PLAINTEXT" ]]; then
    echo "PASS"
    exit 0
else
    echo "FAIL"
    exit 1
fi