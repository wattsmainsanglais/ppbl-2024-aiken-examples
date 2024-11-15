use aiken/interval.{Finite}
use cardano/transaction.{OutputReference, Transaction, ValidityRange} as tx

pub type Redeemer {
  msg: ByteArray,
}

validator my_example {

   spend(_datum, redeemer: Redeemer , _input: OutputReference, tx: Transaction) {
        
        let Transaction {validity_range, ..} = tx

        let lock_until = 178515515151
        let must_msg = redeemer.msg == "Hello"

        must_start_after(validity_range, lock_until)&&must_msg

    } else(_){
        fail
    }
}


fn must_start_after(range: ValidityRange, lock_expiration_time: Int) {
  when range.lower_bound.bound_type is {
    Finite(tx_earliest_time) -> lock_expiration_time <= tx_earliest_time
    _ -> False
  }
}