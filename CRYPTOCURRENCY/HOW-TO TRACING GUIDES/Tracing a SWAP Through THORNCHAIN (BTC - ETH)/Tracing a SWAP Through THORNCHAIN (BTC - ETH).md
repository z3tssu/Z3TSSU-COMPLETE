To determine the output transaction in a THOR Swap transaction, there are two options:

- **For BTC transactions, you can use any blockchain explorer with OP_RETURN data:**

In my previous email, I shared you the one that I use, MEMPOOL ([https://mempool.space/](https://mempool.space/))

You need to check OP_RETURN in the input transaction. The hash of the output transaction appears here (in the orange box)_._

_=:ETH.ETH:0x205D79624266335636180D4cc4365aE99159312B:0/1/0:ti:70_

The first _ETH_ shows the blockchain used; the second _ETH_ shows the asset used; and then you can see the output transaction ID.

![[asas.png]]

If you only have the ETH output transaction and you are searching for the input transaction, you need to check on ETHERSCAN ([https://etherscan.io/](https://etherscan.io/)).

First, search for the output transaction. Second, click on 'More Details'. Then, click on 'Decode Input Data'. Finally, you can see the input transaction ID (in the orange box).

![[2.png]]

You can check the 1st swap input here on MEMPOOL [https://mempool.space/tx/9c2ed99e1e3cca3c74cb491d02f90272b494526df70c7d34e87e125d9653fe56](https://mempool.space/tx/9c2ed99e1e3cca3c74cb491d02f90272b494526df70c7d34e87e125d9653fe56)

And the output transfer here on ETHERSCAN [https://etherscan.io/tx/0xc89b01e61435792b82afc3af197d5e6e09e0e0ea23d8a7fbabb1fa47840eb3ea](https://etherscan.io/tx/0xc89b01e61435792b82afc3af197d5e6e09e0e0ea23d8a7fbabb1fa47840eb3ea)

You can check the 2nd swap input here on MEMPOOL [https://mempool.space/tx/8511e18ead59872075ddac9802b34a6ebb5b04c18f21a6d2d738a49d1ad7c9f5](https://mempool.space/tx/8511e18ead59872075ddac9802b34a6ebb5b04c18f21a6d2d738a49d1ad7c9f5)

And the output transfer here on ETHERSCAN [https://etherscan.io/tx/0x8d6beb95ed714065dbdf2fc7a3208d417df3337789b508fb503f219c477680f3](https://etherscan.io/tx/0x8d6beb95ed714065dbdf2fc7a3208d417df3337789b508fb503f219c477680f3)

- **Check the swap in THORCHAIN EXPLORER:**

This explorer shows you the input transaction, the output transaction and the swap, on the same page ([https://thorchain.net/dashboard](https://thorchain.net/dashboard)).

In the 'Inbound' section, you can see the input address and transaction (in the green box).

In the 'Outbound' section, you can see the output address and transaction (in the red box).

You can also see the amount, the blockchains and the assets involved in the swap (in the blue box).

![[3.png]]

You can check the 1st swap input here on THORCHAIN EXPLORER [https://thorchain.net/tx/9c2ed99e1e3cca3c74cb491d02f90272b494526df70c7d34e87e125d9653fe56](https://thorchain.net/tx/9c2ed99e1e3cca3c74cb491d02f90272b494526df70c7d34e87e125d9653fe56)

And the 2nd swap input here on THORCHAIN EXPLORER [https://thorchain.net/tx/8511e18ead59872075ddac9802b34a6ebb5b04c18f21a6d2d738a49d1ad7c9f5](https://thorchain.net/tx/8511e18ead59872075ddac9802b34a6ebb5b04c18f21a6d2d738a49d1ad7c9f5)

I hope this helps you understand better how to determine THOR Swap output.