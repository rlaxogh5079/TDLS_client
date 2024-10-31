String? validateID(String? value) {
  if (value == null || value.isEmpty || value.trim() == "") {
    return "이 항목을 입력해주세요.";
  } else if (value.length < 8 || value.length > 15) {
    return "아이디의 길이는 8자 이상, 15자 이하 입니다.";
  } else {
    return null;
  }
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty || value.trim() == "") {
    return "이 항목을 입력해주세요.";
  } else if (value.length < 8 || value.length > 15) {
    return "비밀번호의 길이는 8자 이상, 15자 이하 입니다.";
  } else {
    return null;
  }
}

String? validatePasswordConfirm(String? valueOld, String? valueConfirm) {
  if (valueOld != valueConfirm) {
    return "비밀번호가 일치하지 않습니다.";
  } else if (validatePassword(valueConfirm) != null) {
    return validatePassword(valueConfirm);
  } else {
    return null;
  }
}
