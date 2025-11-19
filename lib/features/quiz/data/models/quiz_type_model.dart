enum QuizType {
  nameToFruit('Nom → Fruit', 'Devine le fruit du démon du personnage'),
  fruitToName('Fruit → Nom', 'Devine le personnage qui a ce fruit'),
  nameToCrew('Nom → Équipage', 'Devine l\'équipage du personnage'),
  nameToSize('Nom → Taille', 'Devine la taille du personnage');

  final String title;
  final String description;

  const QuizType(this.title, this.description);
}