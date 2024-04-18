//Util class for asking widget
class AskingUtil {

  static List<String> splitString(String input) {
    return input.split(" /n ");
  }

  static (bool, String) isRecommended(String input) {
    if (input.startsWith("r-")) {
      return (true, input.substring(2));
    }
    return (false, input);
  }
}