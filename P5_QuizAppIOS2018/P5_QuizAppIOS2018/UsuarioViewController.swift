//
//  UsuarioViewController.swift
//  P5_QuizAppIOS2018
//
//  Created by Luis Martin de Vidales Palomero on 23/11/2018.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class UsuarioViewController: UIViewController {
    var nn = ""
    var i = ""
    var usuarios : [NSDictionary] = []
    var fotos : [String] = []
    var Ids : [Int] = []
    var n = 0
    let token = "6038a591ed37bcad9a30"
    var preguntas : [String] = []
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var id: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
            nombre.text = nn
            id.text = i
        // Do any additional setup after loading the view.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "quizzes" {
           let bvc = segue.destination as! PUsuarioTableViewController
            bvc.i = i
        }
    }

}
