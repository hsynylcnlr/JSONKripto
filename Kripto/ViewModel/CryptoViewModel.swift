//
//  CryptoViewModel.swift
//  Kripto
//
//  Created by Hüseyin Yalçınlar on 2.02.2021.
//  Copyright © 2021 Hüseyin Yalçınlar. All rights reserved.
//

import Foundation

struct CryptoListViewModel {
    
    let cryptoCurrencyList : [kriptoParaBirimi]
    
   func numberOfRowInSection() -> Int {
        return self.cryptoCurrencyList.count
    }
 
    func cryptoIndex(_ index : Int) -> CryptoViewModel {
        let crypto = self.cryptoCurrencyList[index]
        return CryptoViewModel(cryptoCurrency: crypto)
    }
    
}

struct CryptoViewModel {
    
    let cryptoCurrency : kriptoParaBirimi
    
    var name : String {
        
        return self.cryptoCurrency.currency
    }
    
    var price : String {
        return self.cryptoCurrency.price
    }
}
