//
//  Protocols.swift
//  Calculator
//
//  Created by Mahmoud Mohamed on 29/06/2021.
//

import Foundation

///protocols for every layer for abstruction

protocol CurrencyConverterViewProtocol:AnyObject{
    var data:String{set get}
    func updateLabel(usd:String)
    func getError(message:String)
}

protocol CurrencyConverterPresenterProtocol{
//    func convert(egp:String)
//    func getDataSucceffully(usd:String)
//    func failedFetch(message:String)
    func getFetchData(Amount:String)
}

protocol DataSourceProtocol{
//    func convert(egp:String)
//    func getDataSucceffully(usd:String)
//    func failedFetch(message:String)
    func fetchSucc(Amount:String, complitionHandler: @escaping (CurrencyConvertModel?,Error?)->Void)
}

protocol NetworkManagerProtocol{
//    func getData(amount:String)
    func fetchData(amount: String, complitionHandler: @escaping (CurrencyConvertModel?,Error?)->Void)
    
}

