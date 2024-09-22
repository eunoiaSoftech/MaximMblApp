String getValidatedString(String? value) {
  if (value == null) {
    return '-';
  } else if (value == "" || value.isEmpty) {
    return "-";
  } else {
    return value;
  }
}
