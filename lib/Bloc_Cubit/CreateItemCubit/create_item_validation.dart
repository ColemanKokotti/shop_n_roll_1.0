class CreateItemValidation {
  static bool validateFields(String name, String description, String icon) {
    return name.isNotEmpty && description.isNotEmpty && icon.isNotEmpty;
  }
}
