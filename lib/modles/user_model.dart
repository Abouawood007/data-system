
const String tableEmployee= 'employee';
const String columnId= 'id';
const String columnName= 'name';
const String columnAge= 'age';
const String columnAccountNumber= 'accountNumber';
const String columnSalary= 'salary';
const String columnDebt= 'debt';
class Employee {
  String name, age, accountNumber, salary, debt;
int id;
  Employee({
    this.id,
    this.name,
    this.age,
    this.accountNumber,
    this.salary,
    this.debt,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    age = json["age"];
    accountNumber = json["accountNumber"];
    salary = json["salary"];
    debt = json["debt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['age'] = age;
    data['salary'] = salary;
    data['debt'] = debt;
    data['accountNumber'] = accountNumber;
    data['name'] = name;

    return data;
  }
}