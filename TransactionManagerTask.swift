import Playgrounds
import Foundation

#Playground {
  
  struct Transaction: Identifiable {
    let id: UUID
    let title: String
    let amount: Decimal
    let type: TransactionType
  }
  
  enum TransactionType {
    case income, expense
  }
  
  final class TransactionManager {
    private(set) var transactions: [Transaction] = []
    
    var balance: Decimal {
      var result: Decimal = 0
      for transaction in transactions {
        switch transaction.type {
        case .income:
          result += transaction.amount
        case .expense:
          result -= transaction.amount
        }
      }
      return result
    }
    
    func addTransaction(_ transaction: Transaction) {
      transactions.append(transaction)
    }
    
    func deleteTransaction(id: UUID) {
      transactions.removeAll { $0.id == id }
    }
  }
  
  let manager = TransactionManager()
  
  let transaction1 = Transaction(id: UUID(), title: "Salary", amount: 25000, type: .income)
  let transaction2 = Transaction(id: UUID(), title: "Products", amount: 1500, type: .expense)
  let transaction3 = Transaction(id: UUID(), title: "Freelance", amount: 5000, type: .income)
  let transaction4 = Transaction(id: UUID(), title: "Coffee", amount: 200, type: .expense)
  
  manager.addTransaction(transaction1)
  manager.addTransaction(transaction2)
  manager.addTransaction(transaction3)
  manager.addTransaction(transaction4)
  
  print(manager.balance)

}


/*
 
 */
