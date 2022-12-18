//
//  Bayraklar.swift
//  BayrakUygulamasi
//
//  Created by Hüdahan Altun on 7.07.2022.
//


import Foundation

class Bayraklar:Equatable,Hashable{//set yapısı içinde kayıtların nasıl karışacağının durumu için bu iki protocolü sınıfa ekledik
    
    private var bayrak_id:Int?
    private var bayrak_ad:String?
    private var bayrak_resim:String?
    
    
    init(){
        
    }
    
    init(bayrak_id:Int,bayrak_ad:String,bayrak_resim:String){
        
        self.bayrak_ad = bayrak_ad
        self.bayrak_id = bayrak_id
        self.bayrak_resim = bayrak_resim
    }
    
    func getBayrak_id()->Int?{
        
        return bayrak_id!
    }
    
    func getBayrak_ad()->String?{
        
        return bayrak_ad!
    }
    
    func getBayrak_resim()->String?{
        
        return bayrak_resim!
    }
    
    
    var hashValue: Int{//bu bir  closure protocoldür burda bayrak_id'ye göre set in kıyaslama olacağını belirtiyoruz
        
        get{
            
            return bayrak_id.hashValue
        }
    }
    
    //burada ise bu kıyaslamayı tarif ediyoruz.
    
    static func == (lhs:Bayraklar,rhs:Bayraklar)->Bool{//equal metodu

        return lhs.bayrak_id == rhs.bayrak_id //bayrak_id lere göre kıyaslama 
    }
}
