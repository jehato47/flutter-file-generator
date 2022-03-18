extension Truncate on String {
  String truncate({int max, String suffix = ''}) {
    return length < max
        ? this
        : '${substring(0, substring(0, max - suffix.length).lastIndexOf(" "))}$suffix' +
            "...";
  }
}

extension ShortenName on String {
  shortenName({int nameLimit = 100, bool addDots = false}) => this.isNotEmpty
      ? this.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';
}
