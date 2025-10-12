# Day 1

## Bitcoin Node Data

1. [bitnodes.io](https://bitnodes.io/nodes/?q=United%20States)
    - Get node data
    - Identify how any nodes on the Bitcoin Blockchain

## Wallet Cluster (Walletexplorer.com)

1. What is a wallet cluster
    1. It is the grouping of addresses that belongs to the same entity
2. [walletexplorer.com](https://www.walletexplorer.com/)
    1. To identify who an address belongs to

## Identifying the service provider

- Once you have identified a cluster address
- Go to wallet explorer and input the identified address and verify its incoming TXS

## Identify who the address belongs to

- Go to [Bitcoinwhoswho](https://www.bitcoinwhoswho.com/)
    - Enter the suspicious address to identify what an address that you have identified belongs to

## Forums for intelligence

1. bitcoinwhoswho
    
    ![[/image 26.png|image 26.png]]
    

# Day 2

## Questionnaire

[https://bit.ly/413YrY1](https://bit.ly/413YrY1)

![[drive-download-20241126T081250Z-001.zip]]

## Ethereum

### Structure of a Transaction

==Look into it==

  

# Day 3 - Ethereum

[groupIB](https://www.group-ib.com/) - Cyber website/Articles

- Article about deadbolt ransomware

[Operation Serengeti](https://apnews.com/article/interpol-cybercrime-africa-afripol-fraud-serengeti-trafficking-208111329edd3a1a64faf85cc7c0d2c0#:~:text=Operation%20Serengeti%2C%20a%20joint%20operation,agency%20said%20in%20a%20statement).

## What is smart contracts

### Explanation

A **smart contract** is like a digital agreement or a set of rules written in computer code that automatically runs when certain conditions are met. It works on a blockchain (like Ethereum) and doesn't need a middleman, such as a lawyer or a bank, to enforce the contract.

### Example:

Imagine you and a friend make a bet about tomorrow's weather:

- You both agree that if it rains, you’ll get $10, and if it doesn’t, your friend will get $10.
- A smart contract is created with this rule.
- The contract checks the weather automatically.
- If it rains, the contract sends $10 to you; if not, it sends $10 to your friend.

The key points:

1. **Automated**: It happens without manual input once the terms are met.
2. **Transparent**: The rules are visible and cannot be changed secretly.
3. **Secure**: Runs on a blockchain, so it's hard to hack or tamper with.

Smart contracts are used in finance, insurance, real estate, and many other areas to make agreements simpler, faster, and more reliable.

### Its use cases for tokens

Smart contracts play a crucial role in creating and managing tokens on a blockchain. Here's how they work for tokens, explained simply:

---

### **1. Token Creation**

A smart contract is written with specific rules to define the token. These rules include:

- **Name**: What the token is called.
- **Symbol**: A short identifier like "BTC" or "ETH."
- **Total Supply**: The maximum number of tokens that can exist.
- **Decimals**: How divisible the token is (e.g., 1 token = 1.0000).

When the contract is deployed on the blockchain, the tokens are created according to these rules.

---

### **2. Managing Token Ownership**

The smart contract keeps track of who owns how many tokens using a ledger (like a digital spreadsheet). When tokens are transferred:

- The sender’s balance decreases.
- The receiver’s balance increases.

This happens automatically without needing a middleman.

---

### **3. Token Transfers**

When you send tokens to someone:

- You create a transaction.
- The smart contract checks if:
    - You have enough tokens.
    - The recipient address is valid.
- If all conditions are met, the transfer is executed.

---

### **4. Token Functions**

Smart contracts include specific functions for interacting with tokens:

- **transfer(address, amount)**: Move tokens from one address to another.
- **approve(address, amount)**: Allow another account to spend your tokens (like in payments).
- **transferFrom(address, recipient, amount)**: Used for spending approved tokens.
- **balanceOf(address)**: Check how many tokens an address owns.

---

### **5. Token Standards (e.g., ERC-20, BEP-20)**

Most tokens follow specific standards like **ERC-20 (Ethereum)** or **BEP-20 (Binance Smart Chain)**. These are guidelines for how the smart contract should work, ensuring all tokens of that type behave the same way. This makes it easier for wallets, exchanges, and apps to interact with tokens.

---

### Example:

Imagine a game where players earn a token called **"GameCoin"**:

1. **GameCoin's smart contract** is created with a total supply of 1 million tokens.
2. As players achieve goals, the smart contract **"mints"** (creates) new tokens and assigns them to player wallets.
3. Players can trade GameCoins with each other, and the smart contract ensures all rules are followed.

In short, the smart contract acts as the brain for the token, ensuring fair, automated, and secure management of token ownership and transactions.

### How transactions are performed in smart contract (tokens)

- The person requires native coins in their wallet
- the person will then interact with the smart contract address (lets say USDT)
- The smart contract will then take some USDT from their address and transfer it over to you.
- If the smart contract address does not hold enough liquidity they can contact another service like uniswap to gather more liquidity to send to the person

### Check Smart Contract Functions

1. Go to transactions of a contract address
    
    ![[/image 1 2.png|image 1 2.png]]
    
2. On the method column, these can be classified as functions of the contract
3. Now click on one of the transaction of the functions
4. Scroll down and click More Details
    
    ![[/image 2 3.png|image 2 3.png]]
    
5. The input data is what is being called in the smart contract

### How to identify a smart contract address on Etherscan.io

- if you see and address with a file symbol in front of it, you can identify that this is a smart contract address

## Hashing Algorithm than Ethereum Use

- KSHAK

## Opensource Tools For Ethereum tracing

[etherscan.io](http://etherscan.io)

[chainkeeper.ai](http://chainkeeper.ai)

## Ethereum Node Tracker

- Why are nodes important for investigations
    1. You can contact a mining pool and request information about a specific IP address
    2. Directly talk to a full node
        1. There are some programs that can directly interact with a full node and reveal the wallet address of a node
- You can view the application used to mine by the minder
    - You can later then try and understand what technologies was used by the possible threat actor.

## Transaction Monitoring

[chainkeeper](https://chainkeeper.ai/)

## Identifying Labels for a Wallet Address

[Arkham Intelligence](https://intel.arkm.com/)

[chainkeeper.ai](http://chainkeeper.ai)

## Decentralized Finance Applications

- ==What is DeFi?==
    
    Here are some good examples of **DeFi applications**, along with a simple way to explain them if someone asks:
    
    ---
    
    ### **1. Uniswap**
    
    - **What It Does**: A decentralized exchange (DEX) where users can trade cryptocurrencies directly with each other without an intermediary.
    - **How to Explain**:_"Imagine you want to trade one cryptocurrency for another, like exchanging your Ethereum for a different token. Instead of going to a bank or a centralized exchange like Binance, Uniswap lets you swap directly with other people using a smart contract. No middleman, lower fees, and it's all done on the blockchain."_
    
    ---
    
    ### **2. Aave**
    
    - **What It Does**: A decentralized lending and borrowing platform. Users can lend their crypto to earn interest or borrow by putting up their crypto as collateral.
    - **How to Explain**:_"It's like a bank for lending and borrowing, but no bank is involved. If you have extra cryptocurrency, you can lend it on Aave and earn interest. If you need a loan, you can borrow by putting your crypto up as collateral. It's all automatic and handled by blockchain smart contracts."_
    
    ---
    
    ### **3. MakerDAO (and DAI Stablecoin)**
    
    - **What It Does**: MakerDAO allows users to deposit cryptocurrency as collateral and generate **DAI**, a stablecoin pegged to the US dollar.
    - **How to Explain**:_"Think of MakerDAO as a platform where you can create your own digital dollars. You lock up some of your cryptocurrency, and the system generates a stablecoin (DAI) you can use for payments or trading. It's like a loan but entirely decentralized and pegged to the value of the dollar."_
    
    ---
    
    ### **4. Compound**
    
    - **What It Does**: A protocol for earning interest on crypto or borrowing against it.
    - **How to Explain**:_"Imagine you have spare crypto sitting around. Instead of leaving it idle, you can deposit it into Compound to earn interest. Or if you need extra funds, you can borrow crypto by putting your existing crypto as collateral—all without talking to a bank."_
    
    ---
    
    ### **5. Curve Finance**
    
    - **What It Does**: A DEX focused on stablecoins, allowing users to trade stablecoins with very low fees and slippage.
    - **How to Explain**:_"Curve is like a money market for stablecoins. If you want to exchange one stablecoin for another—say USDC for DAI—you can do it very efficiently and cheaply on Curve."_
    
    ---
    
    ### **6. Yearn Finance**
    
    - **What It Does**: An aggregator that helps users optimize their yields across different DeFi protocols.
    - **How to Explain**:_"If you want to earn the best returns on your crypto but don't know where to put it, Yearn Finance automatically moves your funds to the platforms offering the highest returns. It’s like having an AI financial advisor for your crypto."_
    
    ---
    
    ### **7. PancakeSwap** (on Binance Smart Chain)
    
    - **What It Does**: A DEX similar to Uniswap, but on the Binance Smart Chain. It also offers features like staking, yield farming, and lotteries.
    - **How to Explain**:_"PancakeSwap is a fun and fast way to trade tokens or earn extra crypto by staking or farming rewards. It's like Uniswap but with more gamified features."_
    
    ---
    
    ### How to Explain DeFi to Someone Simply:
    
    _"DeFi, or decentralized finance, is like a digital version of a bank or stock exchange, but it’s all done on the blockchain without middlemen. Instead of relying on banks, you use computer programs (called smart contracts) to lend, borrow, trade, or earn interest on your money. It’s open to anyone with an internet connection and gives you full control of your funds."_
    
    You can add:_"For example, imagine you want to earn interest on your savings. Instead of depositing money in a bank, you deposit cryptocurrency into a platform like Aave, and other people borrow it. The program ensures you get interest, and it’s all transparent and secure on the blockchain."_
    
    This type of explanation is relatable and emphasizes the core advantages of DeFi: transparency, accessibility, and self-custody.
    
- Uniswap
    - Used to swap tokens, one of the most popular swapping DEFi applications
    - It is like a transparent bank where everything is stored on the blockchain
- AI Based Applications
    - [Fetch.ai](http://Fetch.ai)
        
        Allow people to create AI based applications and monetize them.
        
- Cybersecurity Applications
    - Sentinel Protocol
        - Uppsala token to fund their project
- Gaming Applications
    - Axie Infinity
- How to identify scam projects’
    - Check the token on [etherscan.io](http://etherscan.io) (Token Section)
    - Check its Liquidity
    - Check the Holders
    - Check the Contract (read contract)
        - totalSupply
        - Decimals
    - Check the first transaction
        - It is typically the contract creation transaction
    - Map out the activities of this project
        1. Smart Contract Creation
        2. Click on the transaction hash
            1. You will see the “input data” field
                1. This is the program in Byte code that initiated the contract
        3. Look at the method
            1. You should see “generate token” after the smart contract creation
        4. Look at one of the generate token transaction
            1. You will the amount of tokens that was transferred to a particular address
        5. Check if you see the “Change Controller” method field
            1. You will see the new controller address that the contract has been moved onto this new user
        6. Check again the transaction list and check the activity
            

# Uppsula Tool

- To get additional users into our portal
    - Request to Interpol Preshal additional users

## Typical Tracing Method (For Ethereum)

1. Follow the funds
    1. Lets say A has send 200 ETH to B
        1. Identify the transaction hash and also the hacker/scammer wallet (B), lets say 1234567 is the TXID
        2. Click on wallet B, that the funds has been sent to
        3. Look at the transactions
        4. Identify the transaction where A send to B (TXID 1234567)
        5. Now look at any outgoing transaction that account B has made
        6. Keep following this using the same method until you find a possible hot wallet
            1. Hot wallet is a large account, with lots of transactions and lots of funds.
        7. Now, if [etherscan.io](http://etherscan.io) does not provide the label of who this hot wallet belongs to
        8. Use Chainkeeper, or perform a google to try and identify who his address belongs to

## Anonymous Purchase of Cryptocurrency

Purchasing cryptocurrency anonymously and storing it in an anonymous wallet can be done, but it's important to understand the **legal implications** and **potential risks**, as some jurisdictions have strict regulations regarding anonymous crypto transactions. Here's a guide:

---

### **Anonymous Crypto Purchase Platforms**

### 1. **Peer-to-Peer (P2P) Platforms**

- **Examples**: [LocalBitcoins](https://localbitcoins.com/), [Paxful](https://paxful.com/), [HodlHodl](https://hodlhodl.com/).
- **How it works**:
    - These platforms connect buyers and sellers directly.
    - Payments can be made in cash, bank transfers, or other methods.
    - Many sellers don’t require extensive KYC for small transactions.
- **Anonymity Level**: Medium to High, depending on payment methods and local laws.

### 2. **Bitcoin ATMs**

- **How it works**:
    - Bitcoin ATMs allow you to buy crypto with cash.
    - Some ATMs don’t require ID for smaller purchases (limits vary by location).
    - You can send purchased crypto to an anonymous wallet.
- **Anonymity Level**: High for cash purchases within non-KYC limits.

### 3. **Decentralized Exchanges (DEXs)**

- **Examples**: [Uniswap](https://uniswap.org/), [PancakeSwap](https://pancakeswap.finance/), [Bisq](https://bisq.network/).
- **How it works**:
    - On DEXs, you can trade without KYC, but you typically need some cryptocurrency to start.
    - Use mixers or privacy coins (see below) to anonymize your crypto first.
- **Anonymity Level**: High if you already have crypto and use privacy tools.

### 4. **Privacy Coins (e.g., Monero, Zcash)**

- **What they are**: Cryptocurrencies designed for privacy.
- **How to use**:
    - Purchase Monero (XMR) or Zcash (ZEC) on a P2P platform or non-KYC exchange, then use it for truly anonymous transactions.
- **Anonymity Level**: Very High when used properly.

### 5. **Non-KYC Crypto Exchanges**

- **Examples**: [KuCoin](https://kucoin.com/) (for small transactions without KYC), [Godex](https://godex.io/), [SimpleSwap](https://simpleswap.io/).
- **How it works**:
    - Some platforms allow anonymous trades below specific thresholds.
    - Always check their policies, as rules can change.
- **Anonymity Level**: Medium, depending on thresholds and usage.

---

### **Anonymous Wallets**

To store crypto anonymously, you need a non-custodial wallet that doesn’t require personal information to create. Here are a few options:

1. **Bitcoin Wallets**:
    - **Wasabi Wallet**: Focuses on Bitcoin privacy with built-in coin-mixing features.
    - **Samourai Wallet**: Privacy-focused, includes features like CoinJoin and stealth addresses.
2. **Multi-Currency Wallets**:
    - **Exodus Wallet**: No account needed; supports multiple cryptocurrencies.
    - **Atomic Wallet**: A non-custodial wallet for many cryptos, no registration required.
3. **Privacy-Centric Wallets**:
    - **Monero Wallets**: Official Monero GUI Wallet or Cake Wallet (for Monero and other cryptos).
    - **Zcash Wallets**: ZecWallet for anonymous Zcash transactions.
4. **Hardware Wallets**:
    - **Ledger** or **Trezor**: Store funds offline with greater privacy if purchased anonymously.

---

### **Steps to Purchase Crypto Anonymously**

1. **Set Up an Anonymous Wallet**: Download a privacy-focused wallet like Wasabi or Samourai.
2. **Choose a Purchase Method**: Use a P2P platform, Bitcoin ATM, or DEX.
3. **Use Privacy Coins or Mixers** (Optional): Convert your purchased crypto into Monero (XMR) or use a mixer like Tornado Cash for Ethereum.
4. **Avoid Traceable Links**:
    - Use a VPN or Tor browser when accessing platforms.
    - Pay with cash or untraceable payment methods.

---

### **Important Considerations**:

1. **Legal Compliance**:
    - Some jurisdictions ban or regulate anonymous crypto transactions. Ensure you’re not violating local laws.
2. **Scam Risk**:
    - Peer-to-peer transactions and non-KYC platforms can carry higher risks. Only transact with trusted parties and platforms.
3. **Transaction Limits**:
    - Many platforms have limits for anonymous transactions, beyond which KYC is mandatory.
4. **Blockchain Tracking**:
    - Blockchain analytics can trace transactions. Privacy coins (like Monero) or mixers are essential for complete anonymity.

By following these steps and tools, you can purchase and store cryptocurrency with a high degree of privacy.

# Day 4 - Uppsala Tool Walkthrough

> [!important] Tool works best with open-source

- All Cases Tab
    - When a user submits a report to them it will go into this tab
    - Intelligence analyst within their company will take a look at this case
    - If the information provided by the client is not correct they will reject it
    - if the cases are confirm, it will go into confirmed and they will release it
- CATV Tab
    - Overview
        - 20 credits per usage
        - Most commonly used visualization tool
        - Supports different crypto included in this tool
        - Ensure that you construct the query properly
    - How to use the tool
        1. Select the blockchain type
        2. Input the source address
            1. The address that you want to search or investigate
        3. Enter the smart contract address
            1. Enter if the address has contacted or perform token transactions
        4. Enter the Timestamp
            1. You can leave it to the default time
            2. You can enter the exact time and date that the transactions were made
        5. Source depth
            1. Identifying where the money was received from into the address
            2. If you enter 1, it is like 1 Hop from the current address
        6. Distribution depth
            1. Identify where the money went to
            2. 1 Hop = only one address after the address
            3. where the money is going
    - Example 1 Usage (ransomware scenario) | Question 2 of BTC
        - The questions gives only the transaction hash
        - so we need to find the address using open-source (blockchain.info)
        - We identified the victim address in which he deposit crypto to his wallet address
        - We then select bitcoin blockchain and enter the victim address
        - Now we find the date range
            - We look at the transaction date in open-source
        - Enter this date range into CATV
            - Enter the initial date one day before
            - and the end date 1 month after
        - Enter source depth as 2 to identify where the money was coming from
        - Enter distribution depth as 3 to see where the money has gone 3 hops
        - The address will have been submitted and it will be there in your history in which you can search it again
        - If you see the “release” and click on it you will see the visualized graph
        - You can check the color code also for an address to identify it entity
            - Exchange (purple)
            - blacklisted (red)
            - whitelist (green)
            - smart contract (blue)
        - You can click on the node to view more information
        - You can click on the transaction line and scroll down it will show all the transaction that is included
        - You can export if you click the export button
        
    - Example 2 Usage | Question 1 Ethereum
        - Phase 1 (test)
            1. Put the transaction hash into opensource
            2. Identify victim and scammer wallet
            3. We enter the blockchain type (ETH)
            4. We enter the victim wallet address into the source
            5. Leave empty, since no token transactions were made
            6. We enter the date range of the request
                1. Check the transaction hash on open-source on the exact day
                2. We enter it 1 day before, and a month after for the end date
            7. Enter the source depth (if we want to see where the victim received funds)
                1. We enter 0, because we do not want to see where the victim is getting money from
            8. Enter the distribution depth (To see where the funds are going to)
                1. We enter 3 for trial
            9. The generate the graph and wait
            10. Once the graph has generated
        - Phase 2
            1. Enter the criminal address into the source
            2. Enter the Date Range
            3. Source: 2
            4. Distribution: 3
            5. Generate Graph and View
    - Ask Chainkeeper
        
        - There is a tab that directs you to chainkeeper
        - You can ask it questions about your current case
        
          
        
- CARA Tab
    - 20 credits per usage
    - Mainly used for Compliance
    - It is a risk assessment tool
    - When you put an address, it has a underlying AI algorithm that is trained to identify laundering kind of transactions
    - You can use to see if an addresses belonging to a criminal has interacted with other cases or criminals before.
- Search Feature
    - Can search as much times in the search bar for addresses

  

# Day 4 - Smart Scanner (in-progress tool by Uppsala)

- Used for analyzing smart contracts (tokens) to view their suspicious level whether legit or not.

# Presentation

1. Victim claims USDT tokens were stolen from the provided victim wallet

- Questions
    1. Modus operandi (Most important part)
        1. Confirm that the funds were stolen
    2. Identify wallet that the criminal was receiving the funds from the victim
    3. How much USDT tokens were stolen from Victim?
    4. Can you identify more victim that the criminal has taken money from using the same modus operandi (in the same manner)
    5. If you have identified other victims, what is the total amount of funds lost from the victims
    6. Is the criminal relaying the funds somewhere else to another criminal wallet
    7. How much did this criminal 2 receive?
    8. Can you guess if the criminal 2 wallets belongs to a money laundering group (Chainkeeper check)

# Day 5 Presentation - Guide

1. Question 1