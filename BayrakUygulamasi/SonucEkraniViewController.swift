//
//  SonucEkraniViewController.swift
//  BayrakUygulamasi
//
//  Created by Hüdahan Altun on 7.07.2022.
//

import UIKit

class SonucEkraniViewController: UIViewController {

    @IBOutlet weak var sonucLabel: UILabel!
    
    
    @IBOutlet weak var basarıLabel: UILabel!
    
    var doğruSayısı:Int? 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        if let d = doğruSayısı {
            
            sonucLabel.text = "\(d) Doğru  \(5-d) Yanlış"
            
            basarıLabel.text = " % \(d*100/5) Başarı"
        }
    }
    
    @IBAction func tekrarDene(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
    }
    
   
}
