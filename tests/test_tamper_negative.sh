#!/usr/bin/env bash
set -euo pipefail

echo "[TEST] Tamper ciphertext (negative test)"

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

PLAINTEXT="1010101010101010101010101010101010101010101010101010101010101010"
KEY="1111000011110000111100001111000011110000111100001111000011110000"

CIPHERTEXT=$(echo -e "1\n$PLAINTEXT\n$KEY" | ./des)

# tamper: đảo bit đầu
TAMPERED="1${CIPHERTEXT:1}"

DECRYPTED=$(echo -e "2\n$TAMPERED\n$KEY" | ./des)

if [[ "$DECRYPTED" != "$PLAINTEXT" ]]; then
    echo "PASS"
    exit 0
else
    echo "FAIL"
    exit 1
fi