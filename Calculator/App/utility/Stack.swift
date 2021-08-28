//
//  Stack.swift
//  Calculator
//
//  Created by Mahmoud Mohamed on 26/06/2021.
//

import Foundation

struct Stack {
  fileprivate var array: [Double] = []
    
    
  mutating func push(_ element: Double) {
      array.append(element)
    }
  
  mutating func pop() -> Double? {
     return array.popLast()
    }
    
  func peek() -> Double? {
      return array.last
    }
    func isEmpty() -> Bool {
        return array.isEmpty
    }

}
