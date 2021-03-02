//
//  OturumAcController.swift
//  Kripto
//
//  Created by Hüseyin Yalçınlar on 7.02.2021.
//  Copyright © 2021 Hüseyin Yalçınlar. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class OturumAcController: UIViewController {
    
  
    let txtEmail : UITextField = {
        let txt = UITextField()
        txt.placeholder = "Email Adresiniz..."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 15)
        txt.addTarget(self, action: #selector(veriDegisimi), for: .editingChanged)
        return txt
        }()
    
    let txtParola : UITextField = {
        let txt = UITextField()
        txt.placeholder = "Parolanız..."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.isSecureTextEntry = true
        txt.font = UIFont.systemFont(ofSize: 15)
        txt.addTarget(self, action: #selector(veriDegisimi), for: .editingChanged)
        return txt
    }()
    
    @objc fileprivate func veriDegisimi() {
        //veriler girildiğinde butonu aktif etme
        //veri yoksa 0 eğer 0 dan da büyükse
        let formGecerlimi = (txtEmail.text?.count ?? 0 ) > 0 &&
            (txtParola.text?.count ?? 0) > 0
        
        if formGecerlimi {
            btnGirisYap.isEnabled = true
            btnGirisYap.backgroundColor = UIColor.rgbDonustur(red: 20, green: 155, blue: 235)
        }else{
            btnGirisYap.isEnabled = false
            btnGirisYap.backgroundColor = UIColor.rgbDonustur(red: 150, green: 205, blue: 245)
        }
        
    }
    
    let btnGirisYap : UIButton = {
       
        let buton = UIButton()
        buton.setTitle("Giriş Yap", for: .normal)
        buton.backgroundColor = UIColor.rgbDonustur(red: 150, green: 205, blue: 245)
        buton.layer.cornerRadius = 6
        buton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        buton.setTitleColor(.white, for: .normal)
        buton.isEnabled = false
        buton.addTarget(self, action: #selector(btnGirisYapPressed), for: .touchUpInside)
        return buton
    }()
    
    @objc fileprivate func btnGirisYapPressed(){
        //firebaseden kayıtlı kullanıcıyı çekelim.
        guard let emailAdresi = txtEmail.text , let parola = txtParola.text else{return}
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Oturum Açılıyor..."
        hud.show(in: self.view)
        
        //kullanıcıyı alalım
        Auth.auth().signIn(withEmail: emailAdresi, password: parola) { (sonuc, hata) in
            
            if let hata = hata {
                print("Oturum Açılırken hata meydana geldi:\(hata)")
                hud.dismiss(animated: true)
                let hataliHud = JGProgressHUD(style: .light)
                hataliHud.textLabel.text = "hata meydana geldi : \(hata.localizedDescription)"
                hataliHud.show(in: self.view)
                hataliHud.dismiss(afterDelay: 2)
                return
            }
            //print("Başarılı bir şekilde oturum açıldı.",sonuc?.user.uid)
            hud.dismiss(animated: true)
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let kriptoVC = storyBoard.instantiateViewController(withIdentifier: "kriptoVC")
            self.present(kriptoVC,animated: true,completion: nil)
            
            let basariliHud = JGProgressHUD(style: .light)
            basariliHud.textLabel.text = "Başarılı"
            basariliHud.show(in: self.view)
            basariliHud.dismiss(afterDelay: 1)
            
        }
      
    }
    
    let logoView : UIView = {
        let view = UIView()
        let imgLogo = UIImageView(image: #imageLiteral(resourceName: "logos"))
        imgLogo.contentMode = .scaleAspectFill
        view.addSubview(imgLogo)
        imgLogo.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 150, height: 150)
        imgLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true   
        view.backgroundColor = UIColor.rgbDonustur(red: 255, green: 255, blue: 255)
        
        return view
    }()
    
 

    let btnKayitOl : UIButton = {
       
        let btn = UIButton(type: .system)
        let attrBaslik = NSMutableAttributedString(string: "Henüz bir hesabınız yok mu?", attributes: [.font : UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor.lightGray])
        attrBaslik.append(NSAttributedString(string: " Kayit Ol.", attributes: [
            .font : UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor.rgbDonustur(red: 20, green: 155, blue: 135)]))
            btn.setAttributedTitle(attrBaslik, for: .normal)
        
        
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(btnKayitOlPressed), for: .touchUpInside)
        return btn
    }()
    
    @objc fileprivate func btnKayitOlPressed(){
        
        let kayitOl = KayitOlController()
        present(kayitOl, animated: true,completion: nil)
        kayitOl.modalPresentationStyle = .fullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(logoView)
        logoView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 150)
        view.addSubview(btnKayitOl)
        btnKayitOl.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 50)
                girisGorunumuOlustur()
        
            view.backgroundColor = .white
    }
    

    
    fileprivate func girisGorunumuOlustur() {
        
        let stackView = UIStackView(arrangedSubviews: [txtEmail,txtParola,btnGirisYap])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.anchor(top: logoView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 40, paddingBottom: 0, paddingLeft: 40, paddingRight: -40, width: 0, height: 170)
    }
    
    
   

}
