//
//  CurrencyConverterPresenter.swift
//  Calculator
//
//  Created by Mahmoud Mohamed on 29/06/2021.
//

import Foundation


class CurrencyConverterPresenter: CurrencyConverterPresenterProtocol {
    
    private let datasource:DataSourceProtocol
    private weak var view:CurrencyConverterViewProtocol?
    
    
    init(datasource:DataSourceProtocol,view:CurrencyConverterViewProtocol) {
        self.datasource = datasource
        self.view = view
    }
    
    
/// fetch data from network by delegation method
//    func convert(egp: String) {
//        if validate(text: egp) {
//            datasource.convert(egp: egp)
//        }else{
//            view?.getError(message: "Please fill the blank")
//        }
//    }
    
//    func getDataSucceffully(usd:String){
////        print("presenter\(usd)")
////        view?.updateLabel(usd: usd)
//    }
//
//    func failedFetch(message: String) {
//        view?.getError(message: message)
//    }
    
    /// call data source layer (intermediate layer) to fetch data from network layer by closure
    /// - Parameter Amount: amount of money
    func getFetchData(Amount:String){
        if validate(text: Amount) {
            datasource.fetchSucc(Amount: Amount) { data, error in
                if let data = data{
                    self.view?.updateLabel(usd: "\(data.conversion_result!)")
                }else if let error = error{
                    self.view?.getError(message: error.localizedDescription)
                }
            }
        }else{
            view?.getError(message: "Please fill the blank")
        }
        
    }
    
    
}


extension CurrencyConverterPresenter{
    /// validate the input to avoid crash
    /// - Parameter text: input text
    /// - Returns: true if correct and false if wrong
    private func validate(text:String)->Bool{
        if text.isEmpty{
            return false
        }else{
            return true
        }
    }
}
