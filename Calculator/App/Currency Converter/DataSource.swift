//
//  DataSource.swift
//  Calculator
//
//  Created by Mahmoud Mohamed on 29/06/2021.
//

import Foundation




class DataSource:DataSourceProtocol{
    
//    var presenter: CurrencyConverterPresenterProtocol?
    

    ///fetch data from network layer by delegation
//    func getDataSucceffully(usd: String) {
//        print("datasource\(usd)")
//        presenter?.getDataSucceffully(usd: usd)
//    }
//    
//    func convert(egp: String) {
//        APIConnect.shared.getData(amount: egp)
//    }
//    
//    
//    func failedFetch(message: String) {
//        presenter?.failedFetch(message: message)
//    }
    
    /// fetch data from network layer by closure
    /// - Parameters:
    ///   - Amount: amount of money
    ///   - complitionHandler: data or error
    func fetchSucc(Amount:String, complitionHandler: @escaping (CurrencyConvertModel?,Error?)->Void){
        APIConnect.shared.fetchData(amount: Amount, complitionHandler: complitionHandler)
    }
}
