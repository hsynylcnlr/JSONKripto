//
//  ViewController.swift
//  Kripto
//
//  Created by Hüseyin Yalçınlar on 1.02.2021.
//  Copyright © 2021 Hüseyin Yalçınlar. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class KriptoViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    

    private var filtrelenmisKripto = [kriptoParaBirimi]()
    private var listenerHandle : AuthStateDidChangeListenerHandle?
    private var cryptoListViewModel : CryptoListViewModel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
   /* override func viewWillAppear(_ animated: Bool) {
      
        
    }*/
    
  
    
    func kullaniciOturumVarmi(){
        
        listenerHandle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            
            if user == nil {
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let girisVC = storyBoard.instantiateViewController(withIdentifier: "girisVc")
                self.present(girisVC,animated: true,completion: nil)
                
                
            }else {
                self.getData()
            }
            
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
       
        //getData()
        kullaniciyiGetir()
        kullaniciOturumVarmi()
        
    }
    
    fileprivate func kullaniciyiGetir() {
        
        guard let gecerliKullaniciID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("Kullanıcılar").document(gecerliKullaniciID).getDocument { (snapshot, hata) in
            if let hata = hata {
                print("kullanici bilgileri getirilemedi : \(hata.localizedDescription)")
                return
            }
            guard let kullaniciVerisi = snapshot?.data() else {return}
            let kullaniciAdi = kullaniciVerisi["KullaniciAdi"]  as? String
            print("kullaniciAdi :",kullaniciAdi)
            print(kullaniciVerisi)
        }
        
        
    }
    

    
    @IBAction func btnOturumKapatPressed(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let oturumHatasi as NSError  {
            debugPrint("oturum kapatılırkne hata meydana geldi : \(oturumHatasi.localizedDescription)")
        }
        
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
        return self.filtrelenmisKripto.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KriptoCell", for: indexPath) as! KriptoTableViewCell
        
        let cryptoViewModel = self.cryptoListViewModel.cryptoIndex(indexPath.row)
        
        cell.currencyText.text = cryptoViewModel.name
        cell.priceText.text = cryptoViewModel.price
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        if searchText.isEmpty {
            
            filtrelenmisKripto = cryptoListViewModel.cryptoCurrencyList
            
        } else {
        
        self.filtrelenmisKripto = self.cryptoListViewModel.cryptoCurrencyList.filter({ (currency) -> Bool in
            
            return currency.currency.contains(searchText)
            
        })
            
        }
        //print(filtrelenmisKripto.count)
        self.tableView.reloadData()
    }
 
}


    
    

