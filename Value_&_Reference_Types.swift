import Playgrounds
import Foundation

#Playground {
  
  // MARK: - Запитання 1. Value Semantics
  
  struct User {
    var name: String
    var age: Int
  }
  
  var firstUser = User(name: "Alex", age: 22)
  var secondUser = firstUser
  
  secondUser.name = "John"
  
  // Результат виконання коду: "Alex John". Під час присвоєння secondUser = firstUser створюється окремий екземпляр User. Так як структури мають value-type, зміни у другому екземплярі не впливають на попередній.
  
  
  // MARK: - Запитання 2. Reference Semantics
  
  final class Employee {
    var name: String
    
    init(name: String) {
      self.name = name
    }
  }
  
  let firstEmployee = Employee(name: "Alex")
  let secondEmployee = firstEmployee
  
  secondEmployee.name = "John"
  
  // Результат виконання коду: "John John". Оскільки клас це reference-type, firstEmployee отримує унікальне посилання на зберігання в пам'яті. Об'єкту secondEmployee присвоюється посилання firstEmployee, тому зміна властивості "name" у secondEmployee буде мати вплив на firstEmployee.
  // Чому ми можемо змінити secondUser.name? Тому що за допомогою let ми фіксуємо посилання на об'єкт, але властивості об'єкту можемо змінювати, оскільки вони оголошені як var.
  
  // MARK: - Запитання 3. Copy-on-Write та пам'ять
  
  var numbers = [1, 2, 3]
  var copiedNumbers = numbers

  copiedNumbers.append(4)

  // print(numbers)
  // print(copiedNumbers)
  
  /*
   1. Код виведе: [1,2,3] та [1,2,3,4].
   2. Чи означає присвоєння copiedNumbers = numbers, що Swift обов'язково одразу копіює всі елементи масиву в окрему ділянку пам'яті?
   Ні, copiedNumber будуть зберігатись по тому самому посиланню, як і numbers. А от при додаванні 4, вже буде створена окрема копія, зберігаючи минулу.
   3. Що ти знаєш про механізм Copy-on-Write (CoW)? Це механізм оптимізації кількості посилань для value-типів. Наприклад, якщо ми створимо масив, він буде займати якесь місце в пам'яті. Якщо створимо присвоємо цю змінну іншій змінній, то кількість копій не збільшиться через механізм CoW. Але якщо ми внесемо зміни в будь-який масив, то одразу створиться нова копія. Це зроблено для оптимізації пам'яті.
   */
  
  
  // MARK: - Task 1
  
  struct BankAccount {
    var owner: String
    var balance: Decimal
  }
  
  final class AccountManager {
    var account: BankAccount
    
    init(account: BankAccount) {
      self.account = account
    }
  }
  
  let bankAccount = BankAccount(owner: "Alex", balance: 1000)
  
  var bankAccount2 = bankAccount
  bankAccount2.balance = 500
  
  let accountManager = AccountManager(account: bankAccount)
  
  let accountManager2 = accountManager
  
  accountManager2.account.balance = 2000

  //print(bankAccount.balance)
  //print(bankAccount2.balance)
  //print(accountManager.account.balance)
  //print(accountManager2.account.balance)
  
  struct Profile {
    var username: String
  }
  
  final class UserSession {
    var profile: Profile
    
    init(profile: Profile) {
      self.profile = profile
    }
  }
  
  var originalProfile = Profile(username: "Alex")
  
  let session1 = UserSession(profile: originalProfile)
  var session2 = UserSession(profile: session1.profile)
  
  originalProfile.username = "John"
  session2.profile.username = "Mike"
  
  //print(originalProfile.username) // John
  //print(session1.profile.username) // Alex
  //print(session2.profile.username) // Mike
}
