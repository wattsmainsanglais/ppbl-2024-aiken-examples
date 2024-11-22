#!/bin/bash

. env.sh
. utils.sh

validator_path=$1
min_utxo_lovelace=$2
sender=addr_test1vqqxcn992d3c9vvuzzc59zu9hz3rshus4juwwg8luh5tx0q0hh5s4
sender_key=payment.skey
reference_address=addr_test1wqlf3rtpxy0pk5yumt3uceyjyfhk38690vh8zhdmez0am5s0hmzmg


tx_in_fees=$(get_address_biggest_lovelace ${sender})

cardano-cli conway transaction build \
--testnet-magic 1 \
--tx-in $tx_in_fees \
--tx-out $reference_address+$min_utxo_lovelace \
--tx-out-reference-script-file $validator_path \
--change-address $sender \
--out-file deploy-reference-script.draft

cardano-cli transaction sign \
--signing-key-file $sender_key \
--testnet-magic 1 \
--tx-body-file deploy-reference-script.draft \
--out-file deploy-reference-script.signed

cardano-cli transaction submit \
--tx-file deploy-reference-script.signed \
--testnet-magic 1
