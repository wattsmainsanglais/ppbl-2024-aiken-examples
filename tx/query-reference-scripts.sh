#!/bin/bash

. env.sh
. utils.sh

reference_address=ppbl-2024-cli-wallet/payment.addr

cardano-cli query utxo --testnet-magic 1 --address $reference_address
