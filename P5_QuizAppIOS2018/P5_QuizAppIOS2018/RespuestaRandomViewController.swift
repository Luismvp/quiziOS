//
//  RespuestaRandomViewController.swift
//  P5_QuizAppIOS2018
//
//  Created by Luis Martin de Vidales Palomero on 23/11/2018.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class RespuestaRandomViewController: UIViewController {
    var resultado = false{
        didSet{
            
        }
    }
    var punto = 0
    var preguntaActual = 0
    var pregunta : [Any?] = []
    @IBOutlet weak var Respuesta: UILabel!
    @IBOutlet weak var puntos: UILabel!
    @IBOutlet weak var Continuar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if resultado {
            Respuesta.text = "CORRECTA"
            Respuesta.textColor = UIColor.green
            puntos.text = "Has acertado " + String(punto) + " de 10"
        }
        else {
            Respuesta.text = "INCORRECTA"
            Respuesta.textColor = UIColor.red
            puntos.text = "Has acertado " + String(punto) + " de 10"
        }
        if preguntaActual == 10{
            Continuar.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "siguiente"{
            let bvc =  segue.destination as! UITabBarController
            let a = bvc.viewControllers![0] as! PreguntasRandomViewController
            let b = bvc.viewControllers![1] as! PistasRandomTableViewController
            print(pregunta)
            a.pregunta = pregunta
            a.puntos = punto
            a.preguntaActual = preguntaActual
            b.pregunta = pregunta
            b.preguntaActual = preguntaActual
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
