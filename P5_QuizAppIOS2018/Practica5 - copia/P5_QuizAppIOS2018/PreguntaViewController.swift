//
//  PreguntaViewController.swift
//  P5_QuizAppIOS2018
//
//  Created by Luis Martin de Vidales Palomero on 22/11/2018.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class PreguntaViewController: UIViewController {
    let token = "6038a591ed37bcad9a30"
    var pregunta : [String:Any?] = [:]{
        didSet{
            pinta()
        }
    }
    var isFav = ""
    
    @IBOutlet weak var favorita: UIButton!
    @IBOutlet weak var respuesta: UITextField!
    @IBOutlet weak var autor: UIButton!
    @IBOutlet weak var enunciado: UILabel!
    @IBOutlet weak var foto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        enunciado.text = ""
        
    }
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func favdefav(_ sender: UIButton) {
        if isFav == ""{
           isFav = String(pregunta["favourite"] as! Int)
        }
        if (isFav) == "1"{
            let queue = DispatchQueue(label: "Defav")
            queue.async {
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                let url = URL(string: "https://quiz2019.herokuapp.com/api/users/tokenOwner/favourites/" + String(self.pregunta["id"] as! Int) + "?token=" + self.token)!
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
                // La tarea para subir los datos:
                let task = session.dataTask(with: request){
                    (data: Data?, res: URLResponse?, error: Error?) in
                    
                    // El completionHandler no corre en el Main Thread
                    defer {
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    }
                    
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    let code = (res as! HTTPURLResponse).statusCode
                    if code != 201 {
                        print(HTTPURLResponse.localizedString(forStatusCode: code))
                        DispatchQueue.main.async {
                            (self.isFav) = "0"
                            self.favorita.imageView!.image = UIImage(named: "1024px-Empty_Star.svg")
                        }
                        return
                    }
                }
                task.resume() // Reanudar la tarea
                
            }
        }else{
            let queue = DispatchQueue(label: "Fav")
            queue.async {
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                let url = URL(string: "https://quiz2019.herokuapp.com/api/users/tokenOwner/favourites/" + String(self.pregunta["id"] as! Int) + "?token=" + self.token)!
                print(url)
                var request = URLRequest(url: url)
                request.httpMethod = "PUT"
                // La tarea para subir los datos:
                let task = session.dataTask(with: request){
                    (data: Data?, res: URLResponse?, error: Error?) in
                    
                    // El completionHandler no corre en el Main Thread
                    defer {
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    }
                    
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    let code = (res as! HTTPURLResponse).statusCode
                    if code != 201 {
                        print(HTTPURLResponse.localizedString(forStatusCode: code))
                        DispatchQueue.main.async {
                            (self.isFav
                            ) = "1"
                            self.favorita.imageView!.image = UIImage(named: "Gold_Star.svg")
                        }
                        return
                    }
                }
                task.resume()// Reanudar la tarea
            }
        }
    }
    func pinta(){
        var urlFoto = ""
        let fotos = (pregunta as! NSDictionary).value(forKey: "attachment") as! NSObject
        if fotos.isKind(of: NSDictionary.self){
            let fotoName = fotos.value(forKey: "url") as! String
            urlFoto = fotoName
            let queue = DispatchQueue(label: "Download Queue")
            queue.async {
                if let url = URL(string: urlFoto) {
                    print(url)
                    // Mostrar indicador de actividad de red (no funciona por bloqueo del UI)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    defer {
                        // Ocultar indicador de actividad de red
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                    
                    // Bajar los datos del sitio Web
                    if let data = try? Data(contentsOf: url),
                        
                        // Construir una imagen con los datos bajados
                        let img = UIImage(data: data) {
                        
                        // Actualizar el GUI
                        DispatchQueue.main.async {
                            self.foto?.image = img
                        }
                    }
                }
            }
        }else{
            foto?.image = UIImage(named: "default1-image.jpg")
        }
        enunciado?.text = (pregunta["question"] as! String)
        
        if (pregunta["favourite"] as! Int) == 1{
            favorita.imageView!.image = UIImage(named: "Gold_Star.svg")
        }else{
            favorita.imageView!.image = UIImage(named: "1024px-Empty_Star.svg")
        }
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "comprobar"{
            if respuesta.text == ""{
                let alert = UIAlertController(title: "Error", message: "Introduce tu respuesta", preferredStyle:.alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default))
                present(alert, animated:true)
                return false
            }
        }else{
            return true
        }
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comprobar"{
            let id = pregunta["id"] as! Int
            var url = "https://quiz2019.herokuapp.com/api/quizzes/" + String(id) + "/check?token=" + self.token + "&answer="
            var url2 = respuesta.text!
            var url3 = url + url2.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            if let data = try? Data(contentsOf: URL(string: url3)!){
                do{
                    let jsn = try JSONSerialization.jsonObject(with: data, options: [])
                    print(jsn)
                    if let resultado = jsn as? [String:Any] {
                        if 1 == resultado["result"] as! Int{
                            let bvc = segue.destination as! RespuestaViewController
                            bvc.resultado = true
                        }else{
                            let bvc = segue.destination as! RespuestaViewController
                            bvc.resultado = false
                        }
                    }
                }catch{
                    print(error)
                }
            }
                
        }
    }
}
