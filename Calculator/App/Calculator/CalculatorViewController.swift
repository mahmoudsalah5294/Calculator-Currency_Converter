//
//  ViewController.swift
//  Calculator
//
//  Created by Mahmoud Mohamed on 25/06/2021.
//

import UIKit


protocol CulcuatorViewProrocol:AnyObject {
    var data:String{set get}
}

class CalculatorViewController: UIViewController,CulcuatorViewProrocol,UICollectionViewDelegate,UICollectionViewDataSource, UITextFieldDelegate {
    
    
    var data: String = ""
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var undoBtn: UIButton!
    @IBOutlet weak var redoBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var subtractBtn: UIButton!
    @IBOutlet weak var multiplyBtn: UIButton!
    @IBOutlet weak var dividedBtn: UIButton!
    @IBOutlet weak var equalBtn: UIButton!
    
    var currencyConverterVC: CurrencyConverterViewProtocol?
    
    var resultNumber:Double = 0
    var inputNumber:Double = 0
    var operand:Operator!
    var undoStack = Stack()
    var fullStack = Stack()
    var redoStack = Stack()
    
    var list:[String] = []
    
    enum Operator{
        case add,subtract,multiply,divison
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fullStack.push(resultNumber)
        resultLabel.text = "Result = \(resultNumber)"
        check(stack: undoStack, btn: undoBtn)
        check(stack: redoStack, btn: redoBtn)
        myCollectionView.delegate =  self
        myCollectionView.dataSource = self
        
        numberTextField.delegate = self
        
        currencyConverterVC =  tabBarController?.viewControllers![1] as? CurrencyConverterVC
        
        equalBtn.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if data != "" {
            print("data:\(data)")
            if resultNumber != 0 {
            var newResult = Double(data)!/resultNumber
            let numberAfterDecimal = Decimal(newResult).countNumberAfterDecimal
            if numberAfterDecimal <= 2{
                list.append("*\(newResult)")
            }else{
                newResult = Double(data)! - resultNumber
                if newResult > 0 {
                    list.append("+\(newResult)")
                }else{
                    list.append("\(newResult)")
                }
                
            }
            }else{
                list.append("+\(data)")
            }
            resultNumber = Double(data)!
            undoStack.push(resultNumber)
            fullStack.push(resultNumber)
            myCollectionView.reloadData()
            updateResultLabel(value: data)
        }
        
    }

    
    
    
    /// choose opration (+,-,*,/)
    /// - Parameter sender: (+,-,*,/,undo,redo) button
    @IBAction func operatorBtn(_ sender: UIButton) {
        switch sender.currentTitle {
        case "Undo":
            disableBtns(button: undoBtn)
        case "Redo":
            disableBtns(button: redoBtn)
        case "+":
            disableBtns(button: addBtn)
            operand = .add
        case "-":
            disableBtns(button: subtractBtn)
            operand = .subtract
        case "*":
            disableBtns(button: multiplyBtn)
            operand = .multiply
        case "/":
            disableBtns(button: dividedBtn)
            operand = .divison
        default:
            print("noThing happen in switch")
        }
        
    }
    
    
    /// make the calculation and show it
    /// - Parameter sender: "equal button (=)"
    @IBAction func equalOperation(_ sender: UIButton) {
        if numberTextField.text != "" {
            
//        undoStack.push(resultNumber)
        
        
        inputNumber = Double(numberTextField.text!) ?? 0
        
        switch operand {
        case .add:
            resultNumber = resultNumber + inputNumber
            collectionList(input: "+\(inputNumber)")
        case .subtract:
            resultNumber = resultNumber - inputNumber
            collectionList(input: "-\(inputNumber)")
        case .multiply:
            resultNumber = resultNumber * inputNumber
            collectionList(input: "*\(inputNumber)")
        case .divison:
            if inputNumber != 0 {
                resultNumber = resultNumber / inputNumber
                collectionList(input: "/\(inputNumber)")
            }else{
                MyAlert.alert(title: "Error", message: "Can not divided on zero", viewController: self)
            }
            
        default:
            print("noThing happen in switch")
        
        }
        fullStack.push(resultNumber)
        undoStack = fullStack
        resultLabel.text = "Result = \(resultNumber)"
        enableBtns()
        
        
        numberTextField.text = ""
        currencyConverterVC?.data = "\(resultNumber)"
        check(stack: undoStack, btn: undoBtn)
        check(stack: redoStack, btn: redoBtn)
        myCollectionView.reloadData()
        }else{
            MyAlert.alert(title: "Error", message: "Please Fill the Blank", viewController: self)
        }
    }
    
    
    /// return to previous result
    /// - Parameter sender: undo button
    @IBAction func undoOperation(_ sender: UIButton) {
        check(stack: undoStack, btn: undoBtn)
        
        guard undoStack.pop() != nil else{return}
        guard let lastNumber = undoStack.peek()else{return}
        redoStack.push(lastNumber)
        fullStack.push(lastNumber)
        resultLabel.text = "Result = \(lastNumber)"
        resultNumber = lastNumber
        check(stack: redoStack, btn: redoBtn)
        
    }
    
   
    /// return to next result after undo done
    /// - Parameter sender: redo button
    @IBAction func redoOperation(_ sender: UIButton) {
        
        check(stack: redoStack, btn: redoBtn)
        guard redoStack.pop() != nil else {return}
        guard let lastNumber = redoStack.peek()else{return}
        fullStack.push(lastNumber)
        resultLabel.text = "Result = \(lastNumber)"
        resultNumber = lastNumber
        check(stack: undoStack, btn: undoBtn)
        
    }
    
    
    /// disable all buttons except the passing button
    /// - Parameter button: passing button
    func disableBtns(button:UIButton) {
        undoBtn.isEnabled = false
        redoBtn.isEnabled = false
        addBtn.isEnabled = false
        subtractBtn.isEnabled = false
        multiplyBtn.isEnabled = false
        dividedBtn.isEnabled = false
        
        equalBtn.isEnabled = true
        button.isEnabled = true
    }
    
    /// enable some buttons except equal button
    /// - Parameter button: no parameter
    func enableBtns() {
        undoBtn.isEnabled = true
        redoBtn.isEnabled = true
        addBtn.isEnabled = true
        subtractBtn.isEnabled = true
        multiplyBtn.isEnabled = true
        dividedBtn.isEnabled = true
        
        equalBtn.isEnabled = false
    }
    
    
    
    /// check if stack have elements or not to disable the undo, redo or both buttons
    /// - Parameters:
    ///   - stack: passing stack
    ///   - btn: button will enable or disable depend on stack have item or not
    func check(stack:Stack,btn:UIButton){
        if stack.isEmpty() {
            btn.isEnabled = false
        }else{
            btn.isEnabled = true
        }
        
    }
    
    
    
    /// number of sections of collection view
    /// - Parameter collectionView: collectionView
    /// - Returns: number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    /// number of items in section of collection view
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - section: sections
    /// - Returns: number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    
    /// handle the cell of collection view
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - indexPath: position of cell
    /// - Returns: cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCustomCollectionViewCell
        
        
        let text = list[indexPath.row]
        
        
        cell.cellLabel.text = text
        
        return cell
    }
    
    /// handle the press on cell of collection view
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - indexPath: position of cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let value = list[indexPath.row]
        let char = value[0]
        let number = Double(value.dropFirst(1))!
        
       if char == "+"{
        print("add\(number)")
        resultNumber -= number
       }else if char == "-"{
        print("sub\(number)")
        resultNumber += number
       }else if char == "*"{
        print("mul\(number)")
        if number != 0 {
            resultNumber /= number
        }else{
            MyAlert.alert(title: "Error", message: "Can not divided on zero", viewController: self)
        }
       }else if char == "/"{
        print("divid\(number)")
        resultNumber *= number
       }
        updateResultLabel(value: resultNumber)
        list.remove(at: indexPath.row)
        currencyConverterVC?.data = "\(resultNumber)"
        collectionView.reloadData()
    }
    
    func collectionList(input:String) {
        list.append(input)
    }
    
    
    
    /// allows writing numbers only
    /// - Parameters:
    ///   - textField: textField to apply on it
    ///   - range: range
    ///   - string: string
    /// - Returns: true or false
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedInput = ".1234567890"
        let allowedInputSet = CharacterSet(charactersIn: allowedInput)
        let typedInputSet = CharacterSet(charactersIn: string)
        return allowedInputSet.isSuperset(of: typedInputSet)
    }
    
}


/// extension functionality of CalculatorViewController
extension CalculatorViewController{
    /// update result label by new value
    /// - Parameter value: new value
    func updateResultLabel(value:String){
        resultLabel.text = "Result = \(value)"
    }
    func updateResultLabel(value:Double){
        resultLabel.text = "Result = \(value)"
    }
}
///extension functionality of string to substring by subscript
extension String{
    subscript(i:Int)->String{
        return String(self[index(startIndex,offsetBy: i)])
    }
}

///extension functionality of Decimal to count the number after decimal
extension Decimal{
        var countNumberAfterDecimal:Int{
            return max(-exponent,0)
        }
}

