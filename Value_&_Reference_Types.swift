import Playgrounds
import Foundation

#Playground {
  
  // MARK: - Запитання №1. Value Semantics.
  
  struct User {
    var name: String
    var age: Int
  }
  
  var firstUser = User(name: "Alex", age: 22)
  var secondUser = firstUser
  secondUser.name = "John"
  
  // Результат виконання коду: "Alex John". Під час присвоєння secondUser = firstUser створюється окремий екземпляр User. Так як структури мають value-type, зміни у другому екземплярі не впливають на попередній.
  
  // MARK: - Запитання №2. Reference Semantics.
  
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
  
  // MARK: - Запитання №3. Copy-on-Write та пам'ять.
  
  var numbers = [1, 2, 3]
  var copiedNumbers = numbers
  copiedNumbers.append(4)
  
  /*
   1. Код виведе: [1,2,3] та [1,2,3,4].
   2. Чи означає присвоєння copiedNumbers = numbers, що Swift обов'язково одразу копіює всі елементи масиву в окрему ділянку пам'яті?
   Ні, copiedNumber будуть зберігатись по тому самому посиланню, як і numbers. А от при додаванні 4, вже буде створена окрема копія, зберігаючи минулу.
   3. Що ти знаєш про механізм Copy-on-Write (CoW)? Це механізм оптимізації кількості посилань для value-типів. Наприклад, якщо ми створимо масив, він буде займати якесь місце в пам'яті. Якщо створимо присвоємо цю змінну іншій змінній, то кількість копій не збільшиться через механізм CoW. Але якщо ми внесемо зміни в будь-який масив, то одразу створиться нова копія. Це зроблено для оптимізації пам'яті.
   */
  
  // MARK: - Завдання №1:
  
  /*
   1.Створи BankAccount із власником "Alex" та балансом 1000.
   2.Створи незалежну копію цього рахунку й зміни баланс копії на 500.
   3.Переконайся через print, що початковий рахунок зберіг баланс 1000.
   4.Створи AccountManager, передавши йому початковий рахунок.
   5.Створи другу змінну, яка посилається на той самий AccountManager.
   6.Через другу змінну зміни баланс рахунку менеджера на 2000.
   7.Виведи баланси початкового рахунку, його копії та рахунку всередині обох посилань на менеджер.
   */
  
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
  
  // MARK: - Завдання №2:
  
  /*
   Уяви, що користувач створює кошик покупок, а потім робить його копію для експериментів із цінами.
   1.Створи два товари: iPhone за 1000 і MacBook за 2000.
   2.Створи ShoppingCart з обома товарами.
   3.Створи копію кошика у змінній copiedCart.
   4.Через copiedCart зміни ціну iPhone на 800.
   5.Виведи ціну iPhone в оригінальному та скопійованому кошиках.
   6.Додай новий товар AirPods за 200 тільки до copiedCart.
   7.Виведи кількість товарів в обох кошиках.
   */
  
  final class Product {
    let id: UUID
    var name: String
    var price: Decimal
    
    init(id: UUID = UUID(), name: String, price: Decimal) {
      self.id = id
      self.name = name
      self.price = price
    }
  }
  
  struct ShoppingCart {
    var products: [Product]
  }
  
  let iphone = Product(name: "iPhone", price: 1000)
  let macbook = Product(name: "MacBook", price: 2000)
  
  let shoppingCart = ShoppingCart(products: [iphone, macbook])
  var copiedCart = shoppingCart
  
  for product in copiedCart.products where product.name == "iPhone" {
    product.price = 800
  }
  
  /*
  for product in copiedCart.products where product.name == "iPhone" {
    print(product.price)
  }
  
  for product in shoppingCart.products where product.name == "iPhone" {
    print(product.price)
  }
  
  let airpods = Product(name: "AirPods", price: 200)
  copiedCart.products.append(airpods)
  
  print(shoppingCart.products.count)
  print(copiedCart.products.count)

  */
  
  
  // MARK: - Завдання №3:
  
  /*
   Ти розробляєш iOS-застосунок для керування завданнями.
   Користувач може створити список завдань, а потім зробити його копію, щоб експериментувати зі змінами, не впливаючи на оригінал.
   Якщо скопіювати TaskList, а потім змінити isCompleted одного із завдань у копії, оригінальний список також побачить зміну.
   Потрібно забезпечити повну логічну незалежність двох списків завдань.
   
   Вимоги:
   1.Створи список originalList із двома завданнями: "Learn Swift" та "Build iOS App".
   2.Створи незалежну копію copiedList.
   3.Познач "Learn Swift" як виконане лише в copiedList.
   4.Зміни назву copiedList на "Updated Tasks".
   5.Додай до copiedList нове завдання "Write Unit Tests".
   6.Переконайся через print, що оригінальний список залишився незмінним, включно зі станом завдань.
   */
  
  struct Task {
    var title: String
    var isCompleted: Bool = false
  }
  
  struct TaskList {
    var name: String
    var tasks: [Task]
    
    init(name: String, tasks: [Task]) {
      self.name = name
      self.tasks = tasks
    }
  }
  
  let learnSwiftTask = Task(title: "Learn Swift")
  let buildiOSAppTask = Task(title: "Build iOS App")
  let originalList = TaskList(name: "Original List", tasks: [learnSwiftTask, buildiOSAppTask])
  
  var copiedList = originalList
  
  copiedList.tasks[0].isCompleted = true
  
  copiedList.name = "Updated Tasks"
  
  let writeUnitTestsTask = Task(title: "Write Unit Tests")
  copiedList.tasks.append(writeUnitTestsTask)
  
  print("ORIGINAL LIST:")
  for task in originalList.tasks {
    print("Task: \(task.title) | IsCompleted: \(task.isCompleted)")
  }
  
  print("UPDATED LIST:")
  for task in copiedList.tasks {
    print("Task: \(task.title) | IsCompleted: \(task.isCompleted)")
  }
}
