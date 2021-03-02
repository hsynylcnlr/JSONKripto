//
//  ViewController.swift
//  Kripto
//
//  Created by Hüseyin Yalçınlar on 1.02.2021.
//  Copyright © 2021 Hüseyin Yalçınlar. All rights reserved.
//

import UIKit

class KriptoViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
   
    private var cryptoListViewModel : CryptoListViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
      
    }

    func getData(){
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        
        WebService().downloadCurrencies(url: url) { (cryptos) in
            if let cryptos = cryptos {
                
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KriptoCell", for: indexPath) as! KriptoTableViewCell
        
        let cryptoViewModel = self.cryptoListViewModel.cryptoIndex(indexPath.row)
        
        cell.currencyText.text = cryptoViewModel.name
        cell.priceText.text = cryptoViewModel.price
        
        return cell
    }
    
    
    
    
    
    
    
}

