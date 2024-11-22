
#!/bin/bash


. utils.sh

validator_path=$1
min_utxo_lovelace=$2
sender=addr_test1vqqxcn992d3c9vvuzzc59zu9hz3rshus4juwwg8luh5tx0q0hh5s4
sender_key=payment.skey
reference_scripts_addr=addr_test1wqlf3rtpxy0pk5yumt3uceyjyfhk38690vh8zhdmez0am5s0hmzmg

tx_in_fees=$(get_address_biggest_lovelace ${sender})

cardano-cli conway transaction build \
  --testnet-magic 1 \
  --tx-in ca1bfc580b408f05f3172b311c1bd854cca9971478651002c5328b9420f69269#0 \
  --tx-out addr_test1wqlf3rtpxy0pk5yumt3uceyjyfhk38690vh8zhdmez0am5s0hmzmg+0 \
  --tx-out-reference-script-file slt2054.plutus \
  --change-address addr_test1vqqxcn992d3c9vvuzzc59zu9hz3rshus4juwwg8luh5tx0q0hh5s4 \
  --out-file deploy-reference-script.draft

cardano-cli conway transaction sign \
  --signing-key-file $sender_key \
  --testnet-magic 1 \
  --tx-body-file deploy-reference-script.draft \
  --out-file deploy-reference-script.signed

cardano-cli conway transaction submit \
  --tx-file deploy-reference-script.signed \
  --testnet-magic 1

echo "Successful txHash:"
echo $(cardano-cli conway transaction txid --tx-file deploy-reference-script.signed)