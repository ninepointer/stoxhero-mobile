class AppConstants {
  static const String appName = 'StoxHero';
  static const String token =
      // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Mzc4OGYzOTkxZmM0YmY2MjlkZTZkZjAiLCJpYXQiOjE2ODc4MDM4MDl9.KHbHIwgbRKfbpsIb480MI8himuw5wl0p9jCiTXguuOc";
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Mzk4N2MzNDIyM2MzZmMwNzQ2ODNmMzciLCJpYXQiOjE2ODY2NzYzMjJ9.MfNKuFOp0vYIHALOXxF3rJ98iT9jMYakzAF1FZaqLcI";
  static const String equityTraderType = "Equity Trader";
  static const String buy = "BUY";
  static const String sell = "SELL";
  static const String complete = "COMPLETE";

  static const List<int> instrumentsQuantity = [
    15,
    25,
    50,
    75,
    100,
    125,
    150,
    175,
    200,
    225,
    250,
    275,
    300,
    325,
    350,
    375,
    400,
    425,
    450,
    475,
    500,
    525,
    550,
    575,
    600,
    625,
    650,
    675,
    700,
    725,
    750,
    775,
    800,
    825,
    850,
    875,
    900,
  ];
}

enum TransactionType { buy, sell, exit }
