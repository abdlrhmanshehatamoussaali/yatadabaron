class LetterFrequency {
  String Letter;
  int Count;
  LetterFrequency(this.Letter, this.Count);

  static List<LetterFrequency> MapAll(Map<String, int> model) {
    List<LetterFrequency> viewModels = [];
    for (String letter in model.keys) {
      int count = model[letter];
      LetterFrequency viewModel = LetterFrequency(letter, count);
      viewModels.add(viewModel);
    }
    viewModels.sort((a, b) => b.Count.compareTo(a.Count));
    return viewModels;
  }
}
