//
//  QuizEkraniViewController.swift
//  BayrakUygulamasi
//
//  Created by Hüdahan Altun on 7.07.2022.
//

import UIKit

class QuizEkraniViewController: UIViewController {

    @IBOutlet weak var labelDoğru: UILabel!
    @IBOutlet weak var labelYanlıs: UILabel!
    @IBOutlet weak var labelSoruSayisi: UILabel!
    @IBOutlet weak var imageViewBayrak:UIImageView!
     
    //butonların üzerine anlık veri yazdırmak için outlet şeklinde tanımladık
    
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    var sorular:[Bayraklar] = [Bayraklar] ()//soruları tutacka olan liste
    var yanlısSıklar:[Bayraklar] = [Bayraklar]()//yanlıs sıkları tutacak olan liste
    var doğruSoru:Bayraklar = Bayraklar() //doğru bayrağı tutacak olan nesne
    
    //sayaçlar
    
    var soruSayaç:Int = 0
    var doğruSayaç:Int = 0
    var yanlısSayac:Int = 0
    
    var seçenekler:[Bayraklar] = [Bayraklar]() //
    var karışıkseçenekler = Set <Bayraklar>()//Set yapısı içindeki verileri rastgele karıştırdığı için algoritma yazmamıza gerek yoktur.bu set yapısı seçeneklerimizi karıştıracak.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sorular = BayraklarDAO().rastgele5Getir()//rastgele oluşan 5 bayrak sorular dizimize yüklenir
        
        soruYukle()//uyg yüklenir yüklenmez sorular alınmalıdır.
        
        navigationController?.navigationItem.hidesBackButton = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let gidilecekVc = segue.destination as! SonucEkraniViewController
        
        gidilecekVc.doğruSayısı = sender as? Int //sender a perform segue den doğru sayaç verisi geliyor
    }
   

    func soruYukle(){//arayüze soru yükleyen metod
        
        labelSoruSayisi.text = "\(soruSayaç + 1).Soru" //soru sayısının gösterimi
        
        labelDoğru.text = "Doğru: \(doğruSayaç  )"
        
        labelYanlıs.text = "Yanlış: \(yanlısSayac  )"
        
        
        doğruSoru = sorular[soruSayaç] //sorular dizisinden soruSayaç index numarasına göre bayrak nesnesini alıp doğruSoru nesnesine atanır.
        
        imageViewBayrak.image = UIImage(named: doğruSoru.getBayrak_resim()!)//doğruSoru'da mevcut olan bayrağın  bayrak_resim ismiyle imageview'e aktardık yani ekranda gözükecek bayrak bdur.
        
        
        yanlısSıklar = BayraklarDAO().rastgele3YanlısGetir(bayrak_id: doğruSoru.getBayrak_id()!)//ilk çnce doğru sorunun bayrak_id si hariç olacak şekilde 3 yanlış seçenek getiriyoruz.
        
        
        karışıkseçenekler.removeAll()//soru yükleme metodu  her cevaplama sonrası tekrar çalışacağı için  seçenekle sürekli  tekrar karıştırırlı
        
        
        //setimize verilemizi ekliyoruz bu sayede seçeneklerin yerleri sürekli değişecek.
        karışıkseçenekler.insert(doğruSoru)
        karışıkseçenekler.insert(yanlısSıklar[0])
        karışıkseçenekler.insert(yanlısSıklar[1])
        karışıkseçenekler.insert(yanlısSıklar[2])
        
        //set içinde artık karışık seçeneklerimiz mevcut fakat set yapısından direkt verileri alamıyoruz bunun iiçn for döngüsü ile verileri alıp başka listeye yazmak lazım
        
        seçenekler.removeAll() //ilk önce temizliyoruz.
        
        for s in karışıkseçenekler{
            
            seçenekler.append(s)//seçenekler listesine seçenekler gelir
        }
        
        //bundan sonra seçenekleri butonların üzerine yazabiliriz.
        
        buttonA.setTitle(seçenekler[0].getBayrak_ad(), for: .normal)
        buttonB.setTitle(seçenekler[1].getBayrak_ad(), for: .normal)
        buttonC.setTitle(seçenekler[2].getBayrak_ad(), for: .normal)
        buttonD.setTitle(seçenekler[3].getBayrak_ad(), for: .normal)
        
    }
    

    func doğruKontrol(button:UIButton){//doğru şıkkı seçtik mi seçmedikmi kotnrolü
        
        let buttonYazı = button.titleLabel?.text//bununla paramtere olarak geçilen buton üzerindeki yazı alınır.
        
        let doğruCevap = doğruSoru.getBayrak_ad() //doğru cevabımız ise anlık olarak yüklenen doğru soru nesnesinin bayrak_ad 'ıdır.
        
        print("button yazı :\(buttonYazı!)")
        print("doğru cevap :\(doğruCevap!)")
        
        
        if doğruCevap == buttonYazı{ // doğru cevap button üzerindeki yazıya eşitse doğru bilinmiştir.
             
            doğruSayaç = doğruSayaç + 1
            
        }else{
             
            yanlısSayac += 1
    
        }
        
        //burda ise arayüze yazdırdık.
        labelDoğru.text = "Doğru: \(doğruSayaç  )"
        
        labelYanlıs.text = "Yanlış: \(yanlısSayac  )"
    }
    
    func soruSayaçKontrol(){//sisteme 5 soru yükleyeceğiz sayacımız 5 e ulaiınca artık sisteme soru yüklemeyecek ve diğer sayfaya geçecektir.
        
        soruSayaç += 1 //metod her çalıtığında sayaç 1 artacak
        
        if soruSayaç != 5 {
            soruYukle()
            
        }else{
             
            performSegue(withIdentifier: "toSonuc", sender: doğruSayaç)
            
        }
        
        
    }
    
    @IBAction func buttonA(_ sender: Any) {
        doğruKontrol(button: buttonA)
        soruSayaçKontrol()
    }
    
    @IBAction func buttonB(_ sender: Any) {
        doğruKontrol(button: buttonB)
        soruSayaçKontrol()
    }
    @IBAction func buttonC(_ sender: Any) {
        doğruKontrol(button: buttonC)
        soruSayaçKontrol()
    }
    @IBAction func buttonD(_ sender: Any) {
        doğruKontrol(button: buttonD)
        soruSayaçKontrol()
    }
    
    
}
