//
//  ViewController.swift
//  P5_QuizAppIOS2018
//
//  Created by Luis Martin de Vidales Palomero on 19/11/2018.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController {
    let token = "6038a591ed37bcad9a30"
    let defaultuser = UserDefaults.standard
    var score = 0
    
    let reachability = SCNetworkReachabilityCreateWithName(nil, "https://quiz2019.herokuapp.com")
    var flags = SCNetworkReachabilityFlags()
    @IBOutlet weak var puntos: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let myMaxScore = defaultuser.object(forKey: "score") as? Int{
            score = myMaxScore
        }
        puntos.text = String(score)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "usuarios"{
            let queue = DispatchQueue(label: "Download Queue")
            queue.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                defer {
                    // Ocultar indicador de actividad de red
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                if let data = try? Data(contentsOf: URL(string:  "https://quiz2019.herokuapp.com/api/users?"
                     + "token=" + self.token)!){
                    do{
                        let jsn = try JSONSerialization.jsonObject(with: data, options: [])
                        let bvc = segue.destination as! UsuariosTableViewController
                        DispatchQueue.main.async {
                            bvc.usuarios = jsn as! [Any?]
                        }
                    }catch{
                        print(error)
                    }
                }
            }
        }
        if segue.identifier == "1Aleatorio"{
            let queue = DispatchQueue(label: "Download Queue")
            queue.async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                defer {
                    // Ocultar indicador de actividad de red
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                if let data = try? Data(contentsOf: URL(string:  "https://quiz2019.herokuapp.com/api/quizzes/random/" + "?token=" + self.token)!){
                    do{
                        let jsn = try JSONSerialization.jsonObject(with: data, options: [])
                        print(jsn)
                        let bvc = segue.destination as! UITabBarController
                        let a = bvc.viewControllers![0] as! PreguntaViewController
                        let b = bvc.viewControllers![1] as! PistasTableViewController
                        DispatchQueue.main.async {
                            a.pregunta = jsn as! [String:Any?]
                            b.pregunta = jsn as! [String:Any?]
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        if segue.identifier == "epico"{
            let queue = DispatchQueue(label: "Download Queue")
            queue.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                defer {
                    // Ocultar indicador de actividad de red
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                if let data = try? Data(contentsOf: URL(string:  "https://quiz2019.herokuapp.com/api/quizzes/randomPlay/new" + "?token=" + self.token)!){
                    do{
                        let jsn = try JSONSerialization.jsonObject(with: data, options: [])
                        print(jsn)
                        let bvc = segue.destination as! UITabBarController
                        let a = bvc.viewControllers![0] as! PreguntaEpicaViewController
                        let b = bvc.viewControllers![1] as! PistasEpicasTableViewController
                        DispatchQueue.main.async {
                            a.pregunta = jsn as! [String:Any?]
                            b.pregunta = jsn as! [String:Any?]
                            a.scoreMax = self.score
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        if segue.identifier == "10Aleatorios"{
            let queue = DispatchQueue(label: "Download Queue")
            queue.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                defer {
                    // Ocultar indicador de actividad de red
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                if let data = try? Data(contentsOf: URL(string:  "https://quiz2019.herokuapp.com/api/quizzes/random10wa" + "?token=" + self.token)!){
                    do{
                        let jsn = try JSONSerialization.jsonObject(with: data, options: [])
                        print(jsn)
                        let bvc = segue.destination as! UITabBarController
                        let a = bvc.viewControllers![0] as! PreguntasRandomViewController
                        let b = bvc.viewControllers![1] as! PistasRandomTableViewController
                        DispatchQueue.main.async {
                            a.pregunta = jsn as! [Any?]
                            b.pregunta = jsn as! [Any?]
                            a.preguntaActual = 0
                            b.preguntaActual = 0
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
            
    }

    @IBAction func Cancelar(_ segue: UIStoryboardSegue){
        if let bvc = try? segue.source as! RespuestaEpicaViewController{
            let scoreMax = bvc.scoreMax
            if scoreMax < score{
                score = bvc.score
                puntos.text = String(score)
            }else{
                score = bvc.scoreMax
                puntos.text = String(score)
            }
        }
    }
    @IBAction func Vuelve(_ segue: UIStoryboardSegue){
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        SCNetworkReachabilityGetFlags(reachability!, &self.flags)
        let isReachable: Bool = flags.contains(.reachable)
        if isReachable{
            return true
        }else{
            let alert = UIAlertController(title: "Network Error", message: "No se puede jugar sin conexión a internet", preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default))
            present(alert, animated:true)
            return false
        }
    }
}

