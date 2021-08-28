//
//  CurrencyConverterVC.swift
//  Calculator
//
//  Created by Mahmoud Mohamed on 29/06/2021.
//

import UIKit

class CurrencyConverterVC: UIViewController,CurrencyConverterViewProtocol,UITextFieldDelegate {
    
    @IBOutlet weak var dollarLabel: UILabel!
    
    @IBOutlet weak var egpTextField: UITextField!
    
    
    @IBOutlet weak var convertBtn: UIButton!
    
    
    private var presenter:CurrencyConverterPresenterProtocol?
    private weak var calculator:CulcuatorViewProrocol?
    
    var data:String = ""
    var egpData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        egpTextField.delegate = self
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        egpTextField.text = data
    }
    
    /// init object when view controller open first time (dependancy injection)
    func setup(){
        let datasource = DataSource()
        presenter = CurrencyConverterPresenter(datasource: datasource,view: self)
//        datasource.presenter = presenter
//        APIConnect.shared.datasource = datasource
        calculator = tabBarController?.viewControllers![0] as? CalculatorViewController
    }
    
    /// call presenter intermediate layer to fetch data from network layer
    /// - Parameter sender: convert button name button
    @IBAction func convertOperator(_ sender: UIButton) {
//        presenter?.convert(egp: egpTextField.text!)
        egpData = egpTextField.text ?? ""
        presenter?.getFetchData(Amount: egpData)
    }

    
    /// update label by converted value
    /// - Parameter usd: converted value
    func updateLabel(usd: String) {
        DispatchQueue.main.async {
            self.dollarLabel.text = "\(usd)$"
            self.egpTextField.text = ""
            self.calculator?.data = self.egpData
        }
        
    }
    
    /// show alert when there is an error
    /// - Parameter message: reason of error
    func getError(message: String) {
        DispatchQueue.main.async {
            MyAlert.alert(title: "Error", message: message, viewController: self)
        }
    }
    
    /// allows writing numbers only
    /// - Parameters:
    ///   - textField: textField to apply on it
    ///   - range: range
    ///   - string: string
    /// - Returns: true or false
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedInput = "1234567890"
        let allowedInputSet = CharacterSet(charactersIn: allowedInput)
        let typedInputSet = CharacterSet(charactersIn: string)
        return allowedInputSet.isSuperset(of: typedInputSet)
    }
    

}



