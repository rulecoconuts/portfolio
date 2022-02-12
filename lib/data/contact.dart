class Contact{
  String firstName;
  String lastName;
  String? middleName;
  String email;
  String phone;

  Contact(this.firstName, this.lastName, this.email, this.phone, {this.middleName});
}