class Validators {
  /// Email regex: Validates a basic email format but adds constraints
  ///  for specific rules (e.g., no special characters allowed after @).
  static const _emailExp = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  /// Password regex: Requires at least one lowercase, one uppercase, one digit,
  ///  and one special character, with a minimum length of 8
  static const _passwordExp =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';

  /// Username regex: Only allows alphanumeric characters (3 to 15 characters
  ///  in length)
  static const _usernameExp = r'^[a-zA-Z0-9]{3,15}$';

  /// Full Name regex: Allows alphabets and spaces for first,
  /// middle, and last names
  static const _fullNameExp = r'^[A-Za-z]+(?: [A-Za-z]+)*$';

  /// User Bio regex: Allows letters, numbers, spaces, and common
  /// punctuation marks, typically for user biography input.
  /// The bio can be 10 to 200 characters long
  static const _bioExp = r'^[A-Za-z0-9.,!?()&\s]{10,200}$';

  // Function to validate email
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) return 'Email is required';
    if (!RegExp(_emailExp).hasMatch(email)) {
      return 'Please provide a valid email';
    }
    return null; // Return null if email is valid
  }

  // Function to validate password
  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) return 'Password is required';
    if (!RegExp(_passwordExp).hasMatch(password)) {
      return 'Password must have at least one lowercase, one uppercase, one'
          ' number, and one special character';
    }
    return null; // Return null if password is valid
  }

  // Function to validate username
  static String? usernameValidator(String? username) {
    if (username == null || username.isEmpty) return 'Username is required';
    if (!RegExp(_usernameExp).hasMatch(username)) {
      return 'Username must be alphanumeric and 3 to 15 characters long';
    }
    return null;
  }

  // Function to validate full name
  static String? fullNameValidator(String? fullName) {
    if (fullName == null || fullName.isEmpty) return 'Full name is required';
    if (!RegExp(_fullNameExp).hasMatch(fullName)) {
      return 'Full name must contain only letters and spaces';
    }
    return null;
  }

  // Function to validate user bio
  static String? bioValidator(String? bio) {
    if (bio == null || bio.isEmpty) return 'Bio is required';
    if (!RegExp(_bioExp).hasMatch(bio)) {
      return 'Bio must be 10 to 200 characters long and may contain letters, '
          'numbers, and common punctuation';
    }
    return null;
  }
}
