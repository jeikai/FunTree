class AbQuestion {
  String id;
  String questionText;

  AbQuestion({required this.id, required this.questionText});
}

class InputQuestion extends AbQuestion {
  AbQuestion? nextQuestion;
  InputType inputType;
  String? placeholder;

  InputQuestion(
      {required String id,
      required String q,
      this.nextQuestion,
      this.inputType = InputType.text,
      this.placeholder})
      : super(id: id, questionText: q);
}

enum InputType {
  text,
  number,
  date,
  time,
  dateTime,
  email,
  phone,
  url,
  password,
  color,
  file,
  month,
  week,
  range,
  search,
  tel,
  timeLocal
}

class Question extends AbQuestion {
  Map<String, AbQuestion> answers = {};

  Question(
      {required String id,
      required String q,
      required Map<String, AbQuestion> a})
      : answers = a,
        super(id: id, questionText: q);
}

Question q0 = Question(
    id: "type",
    q: "How would you like to go about planting your tree?",
    a: {
      "r-Recommendation /n Automatically with your GPS": q1,
      "Special floras /n (themes, regions, etc)": q1,
    });

Question q1 =
    Question(id: "room", q: "Where would you like to plant your tree?", a: {
  "Bedroom": Question(
      id: "furniture",
      q: "Where would you like to plant your tree in bedroom?",
      a: {
        "NightStand": q2,
        "Windowsill": q2,
        "Desk": q2,
        "Entryway": q2,
        "Wardrobe": q2,
        "Shelf": q2,
      }),
  "Living Room": Question(
      id: "furniture",
      q: "Where would you like to plant your tree in living room?",
      a: {
        "Coffee Table": q2,
        "Windowsill": q2,
        "Entryway": q2,
        "TV Stand": q2,
        "Shelf": q2,
      }),
  "Kitchen": Question(
      id: "furniture",
      q: "Where would you like to plant your tree in kitchen?",
      a: {
        "Countertop": q2,
        "Windowsill": q2,
        "Entryway": q2,
        "Kitchen Island": q2,
        "Shelf": q2,
        "Dining Table": q2,
      }),
  "Dining Room": Question(
      id: "furniture",
      q: "Where would you like to plant your tree in dining room?",
      a: {
        "Dining Table": q2,
        "Windowsill": q2,
        "Entryway": q2,
        "Shelf": q2,
        "Display Cabinet": q2,
      }),
  "Guest Room": Question(
      id: "furniture",
      q: "Where would you like to plant your tree in guest room?",
      a: {
        "NightStand": q2,
        "Windowsill": q2,
        "Desk": q2,
        "Entryway": q2,
        "Wardrobe": q2,
        "Shelf": q2,
      }),
});

InputQuestion q2 = InputQuestion(
    id: "room_area",
    q: "What is the area of your land for planting?",
    inputType: InputType.number,
    placeholder: "Enter your plot's size: circle, height");

