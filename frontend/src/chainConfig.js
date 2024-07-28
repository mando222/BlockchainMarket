export const chainConfig = {
  chainId: "marketchain-1", // Replace with your actual chain ID
  chainName: "Blockchain Market",
  rpc: "https://rpc.marketchain.example.com", // Replace with your RPC endpoint
  rest: "https://rest.marketchain.example.com", // Replace with your REST endpoint
  bip44: {
    coinType: 118,
  },
  bech32Config: {
    bech32PrefixAccAddr: "market", // Replace with your address prefix
    bech32PrefixAccPub: "marketpub",
    bech32PrefixValAddr: "marketvaloper",
    bech32PrefixValPub: "marketvaloperpub",
    bech32PrefixConsAddr: "marketvalcons",
    bech32PrefixConsPub: "marketvalconspub",
  },
  currencies: [
    {
      coinDenom: "MKT", // Replace with your token denomination
      coinMinimalDenom: "umkt", // Replace with your minimal denomination
      coinDecimals: 6,
    },
  ],
  feeCurrencies: [
    {
      coinDenom: "MKT",
      coinMinimalDenom: "umkt",
      coinDecimals: 6,
    },
  ],
  stakeCurrency: {
    coinDenom: "MKT",
    coinMinimalDenom: "umkt",
    coinDecimals: 6,
  },
  gasPriceStep: {
    low: 0.01,
    average: 0.025,
    high: 0.04,
  },
};
