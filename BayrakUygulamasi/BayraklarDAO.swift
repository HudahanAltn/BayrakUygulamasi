//
//  BayraklarDAO.swift
//  BayrakUygulamasi
//
//  Created by Hüdahan Altun on 7.07.2022.
//

import Foundation


class BayraklarDAO{
    
    var dB:FMDatabase?
    
    init(){
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let veritabanıURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("bayrakquiz.sqlite")
        
        dB =  FMDatabase(path: veritabanıURL.path)
        
        
    }
    
    
    func rastgele5Getir()->[Bayraklar]{//quiz için rastgele 5 bayrak getirir.
        
        var bayraklarListe:[Bayraklar] = [Bayraklar]()
        
        dB?.open()
        
        
        do{
            let rs = try dB!.executeQuery("SELECT * FROM bayraklar ORDER BY RANDOM () LIMIT 5 ", values: nil)
            //rastgele 5 kayıt getiren sql sorgusu
            while rs.next(){
                
                let bayrak = Bayraklar(bayrak_id: Int(rs.string(forColumn: "bayrak_id"))!, bayrak_ad: rs.string(forColumn: "bayrak_ad")!, bayrak_resim: rs.string(forColumn: "bayrak_resim")!)
                
                bayraklarListe.append(bayrak)
            }
            
            print("veritabanından bayrak alma başarılı!")
        }catch{
            
            print("veritabanından bayrak alma başarısız!")
        }
        
        
        return bayraklarListe
    }
    
    
    func rastgele3YanlısGetir(bayrak_id:Int)->[Bayraklar]{// doğru cevap bayrak_id si hariç 3 yanlış seçenek geitren fonskiyon
        
        var bayraklarListe:[Bayraklar] = [Bayraklar]()
        
        dB?.open()
        
        
        do{
            let rs = try dB!.executeQuery("SELECT * FROM bayraklar WHERE bayrak_id != ?  ORDER BY RANDOM () LIMIT 3 ", values: [bayrak_id])
            //rastgele 3  yanlış şık için bayrak getiren sql sorgusu
            
            while rs.next(){
                
                let bayrak = Bayraklar(bayrak_id: Int(rs.string(forColumn: "bayrak_id"))!, bayrak_ad: rs.string(forColumn: "bayrak_ad")!, bayrak_resim: rs.string(forColumn: "bayrak_resim")!)
                
                bayraklarListe.append(bayrak)
            }
            
            print("veritabanından bayrak alma başarılı!")
        }catch{
            
            print("veritabanından bayrak alma başarısız!")
        }
        
        
        return bayraklarListe
    }
    
    
    
    
}
