class TrayState {
  int bananas;
  int apples;
  int mangoes;

  TrayState({this.bananas = 3, this.apples = 5, this.mangoes = 10});


  TrayState copyWith({String? fruitType, bool? add}) {
    return TrayState(
      bananas: fruitType == 'banana' ? (add! ? bananas + 1 : bananas - 1) : bananas,
      apples: fruitType == 'apple' ? (add! ? apples + 1 : apples - 1) : apples,
      mangoes:
      fruitType == 'mango' ? (add! ? mangoes + 1 : mangoes - 1) : mangoes,
    );


  }

  Map<String, dynamic> toJson() => {
    'bananas': bananas,
    'apples': apples,
    'mangoes': mangoes,
  };

  factory TrayState.fromJson(Map<String, dynamic> json) {
    return TrayState(
      bananas: json['bananas'],
      apples: json['apples'],
      mangoes: json['mangoes'],
    );
  }
}
