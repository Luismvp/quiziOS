//
//  RespuestaEpicaViewController.swift
//  P5_QuizAppIOS2018
//
//  Created by Luis Martin de Vidales Palomero on 23/11/2018.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class RespuestaEpicaViewController: UIViewController {
    let token = "6038a591ed37bcad9a30"
    var resultado : Bool = false{
        didSet{
            pinta()
        }
    }
    var score = 0{
        didSet{
            pinta()
        }
    }
    var scoreMax = 0;
    @IBOutlet weak var Respuesta: UILabel!
    @IBOutlet weak var puntos: UILabel!
    @IBOutlet weak var inicio: UIButton!
    @IBOutlet weak var Continuar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if resultado {
            Respuesta.text = "CORRECTA"
            Respuesta.textColor = UIColor.green
            puntos.text = String(score)
            Respuesta.isHidden = true
            puntos.isHidden = true
            Continuar.isHidden = true
        }
        else {
            Respuesta.text = "INCORRECTA"
            Respuesta.textColor = UIColor.red
            puntos.text = String(score)
            Respuesta.isHidden = true
            puntos.isHidden = true
            Continuar.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    func pinta(){
        if resultado {
            Respuesta.text = "CORRECTA"
            Respuesta.textColor = UIColor.green
            puntos.text = String(score)
            Respuesta.isHidden = false
            puntos.isHidden = false
            Continuar.isHidden = false
        }
        else {
            Respuesta.text = "INCORRECTA"
            Respuesta.textColor = UIColor.red
            puntos.text = String(score)
            Respuesta.isHidden = false
            puntos.isHidden = false
            Continuar.isHidden = true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "siguiente"{
            let queue = DispatchQueue(label: "Download Queue")
            queue.async{
                if let data = try? Data(contentsOf: URL(string:  "https://quiz2019.herokuapp.com/api/quizzes/randomPlay/next/" + "?token=" + self.token)!){
                    do{
                        let jsn = try JSONSerialization.jsonObject(with: data, options: [])
                        print(jsn)
                        let bvc = segue.destination as! UITabBarController
                        let a = bvc.viewControllers![0] as! PreguntaEpicaViewController
                        let b = bvc.viewControllers![1] as! PistasEpicasTableViewController
                        DispatchQueue.main.async{
                            a.pregunta = jsn as! [String:Any?]
                            b.pregunta = jsn as! [String:Any?]
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
