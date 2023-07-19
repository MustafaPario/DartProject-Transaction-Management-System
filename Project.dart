import 'dart:io';

List<Map> accounts = [
  {"Id": 0, "Name": "admin", "Pin": 0000, "Balance": 10}
];
List Ledger = [];

void main() {
  print("====== Welcome to the Transaction Management System ======");

  showATMMenu(); // Call the menu function
}

void showATMMenu() {
  bool exit = false;

  while (!exit) {
    print("\n====== ATM Menu ======");
    print("1. Create Account");
    print("2. Check Balance");
    print("3. Deposit Balance");
    print("4. Withdraw Balance");
    print("5. Delete Account");
    print("6. Exit");

    print("Enter your choice:");
    int choice = int.parse(stdin.readLineSync() ?? '0');

    switch (choice) {
      case 1:
        String result = createAccount();
        print(result);
        break;

      case 2:
        print("Enter your account ID:");
        int accountId = int.parse(stdin.readLineSync() ?? '0');
        int balance = Check_Balance(accountId);
        print("Current balance: $balance");
        break;

      case 3:
        print("Enter your account ID:");
        int accountId = int.parse(stdin.readLineSync() ?? '0');
        print("Enter the amount to deposit:");
        int amount = int.parse(stdin.readLineSync() ?? '0');
        String result = Deposit(accountId, amount);
        print(result);
        break;

      case 4:
        print("Enter your account ID:");
        int accountId = int.parse(stdin.readLineSync() ?? '0');
        print("Enter the amount to withdraw:");
        int amount = int.parse(stdin.readLineSync() ?? '0');
        String result = Widthdraw(accountId, amount);
        print(result);
        break;

      case 5:
        print("Enter the account ID to delete:");
        int accountId = int.parse(stdin.readLineSync() ?? '0');
        String result = deleteAccount(accountId);
        print(result);
        break;

      case 6:
        exit = true;
        print(
            "Thank you for using the Transaction Management System Of Mustafa & Haseeb");
        break;

      default:
        print("Invalid choice. Please try again.");
        break;
    }
  }
}

int Check_Balance(int Id) {
  int Balance = 0;

  final userAccountTemp = accounts.where((account) => account["Id"] == Id);
  userAccountTemp.forEach((element) {
    Balance = element["Balance"];
  });
  return (Balance);
}

String Widthdraw(int Id, int Amount) {
  int Balance = 0;

  final userAccountTemp = accounts.where((account) => account["Id"] == Id);
  userAccountTemp.forEach((element) {
    Balance = element["Balance"];
  });

  if (Amount > Balance) {
    return ("Current balance is insufficient for this transaction.");
  } else {
    int Index = accounts.indexWhere((element) => element["Id"] == Id);

    Balance = Balance - Amount;

    accounts[Index]["Balance"] = Balance;

    return ("Transaction Completed Succesfully");
  }
}

String Deposit(int Id, int Amount) {
  int Balance = 0;

  final userAccountTemp = accounts.where((account) => account["Id"] == Id);
  userAccountTemp.forEach((element) {
    Balance = element["Balance"];
  });

  int Index = accounts.indexWhere((element) => element["Id"] == Id);

  Balance = Balance + Amount;

  accounts[Index]["Balance"] = Balance;

  return ("Transaction completed succesfully, Your Balance is: $Balance");
}

String createAccount() {
  String? name;
  int? pin;
  int Id = accounts.length;

  while (name == null) {
    print("Enter Name:");
    name = stdin.readLineSync();
  }
  while (pin == null || pin < 4) {
    print("Enter a PIN that is longer than Four digits");
    pin = int.parse(stdin.readLineSync() ?? '0');
  }

  accounts.add({"Id": Id, "Name": name, "Pin": pin, "Balance": 0});

  return ("Account Created Succesfully");
}

String deleteAccount(int Id) {
  accounts.removeWhere((element) => element["Id"] == Id);

  return ("Account deleted succesfully");
}

int getIdWithName(String name) {
  int Index = accounts.indexWhere((element) => element["Name"] == name);
  int Id = accounts[Index]["Id"];

  return Id;
}
