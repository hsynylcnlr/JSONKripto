//
//  KayitOlController.swift
//  Kripto
//
//  Created by Hüseyin Yalçınlar on 3.02.2021.
//  Copyright © 2021 Hüseyin Yalçınlar. All rights reserved.
//

import UIKit
import Firebase

class KayitOlController: UIViewController {

    
    let btnFotografEkle : UIButton = {
       
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "fotograf_sec").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(btnFotografEklePressed), for: .touchUpInside)
        return btn
    }()
    
    @objc fileprivate func btnFotografEklePressed() {
        
        let imgPickerController = UIImagePickerController()
        imgPickerController.delegate = self
        
        present(imgPickerController, animated: true, completion: nil)
    }
    let txtEmail : UITextField = {
       
        let txt = UITextField()
        txt.placeholder = "Email Adresinizi Giriniz."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 15)
        txt.addTarget(self, action: #selector(veriDegisimi), for: .editingChanged)
        return txt
    }()
    
    @objc fileprivate func veriDegisimi() {
        //veriler girildiğinde butonu aktif etme
        //veri yoksa 0 eğer 0 dan da büyükse
        let formGecerlimi = (txtEmail.text?.count ?? 0 ) > 0 &&
            (txtKullaniciAdi.text?.count ?? 0) > 0 &&
            (txtParola.text?.count ?? 0) > 0
        
        if formGecerlimi {
            btnKayitOl.isEnabled = true
            btnKayitOl.backgroundColor = UIColor.rgbDonustur(red: 20, green: 155, blue: 235)
        }else{
            btnKayitOl.isEnabled = false
            btnKayitOl.backgroundColor = UIColor.rgbDonustur(red: 150, green: 205, blue: 245)
        }
        
    }
    
    let txtKullaniciAdi : UITextField = {
        
        let txt = UITextField()
        txt.placeholder = "Kullanıcı Adınızı Giriniz."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 15)
        txt.addTarget(self, action: #selector(veriDegisimi), for: .editingChanged)
        return txt
    }()
    let txtParola : UITextField = {
        
        let txt = UITextField()
        txt.placeholder = "Parolanızı giriniz."
        txt.isSecureTextEntry = true
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 15)
        txt.addTarget(self, action: #selector(veriDegisimi), for: .editingChanged)
        return txt
    }()
    
    let btnKayitOl : UIButton = {
       
        let btn = UIButton(type: .system)
        btn.setTitle("Kayıt Ol", for: .normal)
        btn.backgroundColor = UIColor.rgbDonustur(red: 150, green: 205, blue: 245)
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(btnKayitOlPressed), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    
    @objc fileprivate func btnKayitOlPressed(){
        
        guard let emailAdresi = txtEmail.text else{return}
        guard let kullaniciAdi = txtKullaniciAdi.text else{return}
        guard let parola = txtParola.text else{return}
        
        Auth.auth().createUser(withEmail: emailAdresi, password: parola) { (sonuc, hata) in
            if let hata = hata {
                print("Hata meydana geldi :",hata)
                return
            }
            print("kullanici basarıyla gercekleşti",sonuc?.user.uid)
            self.txtParola.text = ""
            self.txtKullaniciAdi.text = ""
            self.txtEmail.text = ""
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(btnFotografEkle)
        
        btnFotografEkle.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 40, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 150, height: 150)

        btnFotografEkle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      
        girisAlanlariniOlustur()
    }
    
    fileprivate func girisAlanlariniOlustur(){
        
        let stackView = UIStackView(arrangedSubviews: [txtEmail,txtKullaniciAdi,txtParola,btnKayitOl])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 8
        view.addSubview(stackView)
        
        
        stackView.anchor(top: btnFotografEkle.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingBottom: 0, paddingLeft: 45, paddingRight: -45, width: 0, height: 230)
        
    }
    

}

extension UIView {

    func anchor(top : NSLayoutYAxisAnchor?,
                bottom : NSLayoutYAxisAnchor?,
                leading : NSLayoutXAxisAnchor?,
                trailing : NSLayoutXAxisAnchor?,
                paddingTop : CGFloat,
                paddingBottom : CGFloat,
                paddingLeft : CGFloat,
                paddingRight : CGFloat,
                width : CGFloat,
                height : CGFloat){
        //aouto laout için gerekli kısıtlamaları kabul etsin diye false yaptık.
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: paddingRight).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    
}


