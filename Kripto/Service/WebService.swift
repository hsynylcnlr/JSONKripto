//
//  WebService.swift
//  Kripto
//
//  Created by Hüseyin Yalçınlar on 2.02.2021.
//  Copyright © 2021 Hüseyin Yalçınlar. All rights reserved.
//

import Foundation


class WebService {
    
    func downloadCurrencies(url : URL, completion: @escaping ([kriptoParaBirimi]?) -> ()){
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                
            }else if let data = data {
                
                let cryptoList = try? JSONDecoder().decode([kriptoParaBirimi].self, from: data)
                
                if let cryptoList = cryptoList {
                    completion(cryptoList)
                
            }
            
        }
        
        
    }.resume()
    
    
}
}
