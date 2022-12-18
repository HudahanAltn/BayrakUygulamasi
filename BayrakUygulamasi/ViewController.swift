//
//  ViewController.swift
//  BayrakUygulamasi
//
//  Created by Hüdahan Altun on 7.07.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        veritabaniKopyala()
    }

    
    
    func veritabaniKopyala(){
        
        let bundleYolu = Bundle.main.path(forResource: "bayrakquiz", ofType: ".sqlite")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        
        let fileManager = FileManager.default
        
        let kopyala = URL(fileURLWithPath: hedefYol).appendingPathComponent("bayrakquiz.sqlite")
        
        if fileManager.fileExists(atPath: kopyala.path){
            
            print("veritabanı zaten kopyalandı!")
        }else{
            
            do{
                
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyala.path)
                
                print("veritabanı kopyalama başarılı!")
                
            }catch{
                
                print("veritabanı kopyalamada hata oluştu")
            }
        }
    }

}

