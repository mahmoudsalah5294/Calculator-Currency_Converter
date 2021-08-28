//
//  Request.swift
//  Calculator
//
//  Created by Mahmoud Mohamed on 29/06/2021.
//

import Foundation

final public class APIConnect:NetworkManagerProtocol{
    
    static var shared:APIConnect = APIConnect()
    ///use singleton design pattern
    private init(){}
    
    
    ///get data from api by delegation
//    var datasource:DataSourceProtocol?
//    func getData(amount: String){
//        
//        if let url = URL(string: Endpoints.converterApi+amount){
//        let request = URLRequest(url: url)
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        let task = session.dataTask(with: request){
//            (data,response,err) in
//            
//            if let data = data{
//            do{
//                var decodedResponse = try JSONDecoder().decode(CurrencyConvertModel.self,from:data)
//                    self.datasource?.getDataSucceffully(usd:"\(decodedResponse.conversion_result!)")
//                
//            }catch{
//                print("catch:\(error.localizedDescription)")
//                self.datasource?.failedFetch(message: error.localizedDescription)
//            }
//            }else if err != nil{
//                self.datasource?.failedFetch(message: err!.localizedDescription)
//            }
//            
//           }.resume()
//        }else{
//            datasource?.failedFetch(message: "Wrong URL")
//        }
//    }
    
    
    /// get data from api by clouse
    /// - Parameters:
    ///   - amount: amount of money
    ///   - complitionHandler: data or error
    func fetchData(amount: String, complitionHandler: @escaping (CurrencyConvertModel?,Error?)->Void){
        
        if let url = URL(string: Endpoints.converterApi+amount){
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request){
            (data,response,err) in
            
            if let err = err {
                DispatchQueue.main.async {
                    complitionHandler(nil,err)
                }
            }
            else{
            do{
                let decodedResponse = try JSONDecoder().decode(CurrencyConvertModel.self,from:data!)
                    
    
                DispatchQueue.main.async {
                    complitionHandler(decodedResponse,nil)
                }
            }catch{
                print("catch:\(error.localizedDescription)")
            }
            }
            
           }.resume()
        }
    }
    
    
}

