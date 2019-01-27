//
//  RespuestaViewController.swift
//  P5_QuizAppIOS2018
//
//  Created by Luis Martin de Vidales Palomero on 22/11/2018.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class RespuestaViewController: UIViewController {
    var resultado : Bool = false
    
    @IBOutlet weak var Respuesta: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if resultado {
           Respuesta.text = "CORRECTA"
            Respuesta.textColor = UIColor.green
        }
        else {
            Respuesta.text = "INCORRECTA"
            Respuesta.textColor = UIColor.red
        }
        // Do any additional setup after loading the view.
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
