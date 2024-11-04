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

String? validateNickname(String? value) {
  if (value == null || value.isEmpty || value.trim() == "") {
    return "이 항목을 입력해주세요.";
  } else if (value.length < 3 || value.length > 15) {
    return "닉네임의 길이는 3자 이상, 15자 이하 입니다.";
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  RegExp exp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  if (!exp.hasMatch(value ?? "")) {
    return "이메일 형식이 옳지 않습니다.";
  } else if (value == null || value.isEmpty || value.trim() == "") {
    return "이 항목을 입력해주세요.";
  } else if (value.length >= 30) {
    return "이메일 길이는 30자 미만입니다.";
  } else {
    return null;
  }
}
