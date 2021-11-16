import 'crypto.dart';

class CryptoManager {
  /// CryptoManager-Singleton, access via CryptoManager().<function>
  static final CryptoManager _instance = CryptoManager._internal();

  factory CryptoManager() => _instance;

  CryptoManager._internal();

  final List<Crypto> _cryptos = [];

  void addCrypto(Crypto crypto) {
    _cryptos.add(crypto);
  }

  void addCryptos(List<Crypto> cryptos) {
    _cryptos.addAll(cryptos);
  }

  List<Crypto> getCryptos() {
    return _cryptos;
  }

  Crypto getCryptoById(String id) {
    for (Crypto c in _cryptos) {
      if (c.id == id) {
        return c;
      }
    }
    throw Exception("Krypto-Id nicht vorhanden!");
  }

  void initializeExampleCryptos() {
    List<Crypto> exampleCryptos = [
      Crypto('bitcoin-btc', 'Bitcoin', 'BTC', 'https://cryptologos.cc/logos/bitcoin-btc-logo.png?v=014', 55387.47, 1045529794163),
      Crypto('ethereum-eth', 'Ethereum', 'ETH', 'https://cryptologos.cc/logos/ethereum-eth-logo.png?v=014', 3957.18, 469811659516),
      Crypto('binance-coin-bnb', 'Binance Coin', 'BNB', 'https://cryptologos.cc/logos/binance-coin-bnb-logo.png?v=014', 558.29, 92574201095),
      Crypto('tether-usdt', 'Tether', 'USDT', 'https://cryptologos.cc/logos/tether-usdt-logo.png?v=014', 0.882865, 64811537761),
      Crypto('solana-sol', 'Solana', 'SOL', 'https://cryptologos.cc/logos/solana-sol-logo.png?v=014', 205.38, 62639558963),
      Crypto('cardano-ada', 'Cardano', 'ADA', 'https://cryptologos.cc/logos/cardano-ada-logo.png?v=014', 1.75, 56231136342),
      Crypto('xrp-xrp', 'XRP', 'XRP', 'https://cryptologos.cc/logos/xrp-xrp-logo.png?v=014', 1.01, 48012651470),
      Crypto('polkadot-new-dot', 'Polkadot', 'DOT', 'https://cryptologos.cc/logos/polkadot-new-dot-logo.png?v=014', 38.64, 40355883545),
      Crypto('dogecoin-doge', 'Dogecoin', 'DOGE', 'https://cryptologos.cc/logos/dogecoin-doge-logo.png?v=014', 0.223296, 29524296859),
      Crypto('terra-luna-luna', 'Terra', 'LUNA', 'https://cryptologos.cc/logos/terra-luna-luna-logo.png?v=014', 41.88, 18367916192),
    ];
    _cryptos.addAll(exampleCryptos);
  }
}