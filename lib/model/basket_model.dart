class BasketState {
  int fruits;

  BasketState({this.fruits = 0});

  BasketState addFruit() {
    return BasketState(fruits: fruits + 1);
  }
  // Convert a BasketState into a Map. The keys must correspond to the names of the variables.
  Map<String, dynamic> toJson() => {
    'fruits': fruits,
  };

  // A method to create a BasketState from a Map.
  factory BasketState.fromJson(Map<String, dynamic> json) {
    return BasketState(
      fruits: json['fruits'],
    );
  }
}
