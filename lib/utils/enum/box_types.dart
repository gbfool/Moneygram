enum BoxType { accounts, category, transactions }

extension BoxTypeMapping on BoxType {
  String get stringValue {
    switch (this) {
      case BoxType.accounts:
        return 'accounts';
      case BoxType.category:
        return 'category';
      case BoxType.transactions:
        return 'transactions';
    }
  }
}
