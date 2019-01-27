//
//  TodosTableViewController.swift
//  P5_QuizAppIOS2018
//
//  Created by Luis Martin de Vidales Palomero on 19/11/2018.
//  Copyright © 2018 UPM. All rights reserved.
//
import UIKit

class TodosTableViewController: UITableViewController {
    
    let token = "6038a591ed37bcad9a30"
    var preguntas : [String] = []{
        didSet{
            tabla.reloadData()
        }
    }
    var usuarios : [NSDictionary] = []
    var fotos : [String] = []
    var Ids : [Int] = []
    var n = 0
    
    @IBOutlet var tabla: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargaPreguntas(url: "https://quiz2019.herokuapp.com/api/quizzes?token=")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Pregunta"{
            let queue = DispatchQueue(label: "Download Queue")
            queue.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                defer {
                    // Ocultar indicador de actividad de red
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                let celula = sender as! QuizzesTableViewCell
                if let data = try? Data(contentsOf: URL(string:  "https://quiz2019.herokuapp.com/api/quizzes/" + celula.id.text! + "?token=" + self.token)!){
                    do{
                        let jsn = try JSONSerialization.jsonObject(with: data, options: [])
                            print(jsn)
                        let bvc = segue.destination as! UITabBarController
                        let a = bvc.viewControllers![0] as! PreguntaViewController
                        let b = bvc.viewControllers![1] as! PistasTableViewController
                        DispatchQueue.main.async {
                            b.pregunta = jsn as! [String:Any?]
                            a.pregunta = jsn as! [String:Any?]
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        
    }
    // MARK: - Table view data source
    func cargaPreguntas ( url: String ){
            var preguntasi: NSMutableArray = []
            var usuariosi : [NSDictionary] = []
            var fotosi : NSMutableArray = []
            var Idi: NSMutableArray = []
            print(self.n)
        let queue = DispatchQueue(label: "Download Queue")
        queue.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            defer {
                // Ocultar indicador de actividad de red
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            if self.n==0{
                if let data = try? Data(contentsOf: URL(string: url + self.token)!){
                    
                    do{
                        let jsn = try JSONSerialization.jsonObject(with: data, options: [])
                        //print(jsn)
                        if let quizzes = jsn as? [String:Any] {
                            //    print(quizzes)
                            
                            //    print(nextURL)
                            let aQuizzes = quizzes["quizzes"] as! NSArray
                            //    print(aQuizzes)
                            
                            for i in aQuizzes{
                                let aaQuizzes = i as! NSDictionary
                                
                                let aaaQuizzes = aaQuizzes.value(forKey: "question") as! NSString
                                preguntasi.add(aaaQuizzes)
                                Idi.add(aaQuizzes.value(forKey: "id") as! Int)
                                let foto = aaQuizzes.value(forKey: "attachment") as! NSObject
                                if foto.isKind(of: NSDictionary.self){
                                    let fotoName = foto.value(forKey: "url") as! String
                                    fotosi.add(fotoName)
                                }else{
                                    fotosi.add("default1-image.jpg")
                                }
                                
                                
                                
                                let uuuQuizzes = aaQuizzes.value(forKey: "author") as! NSObject
                                if uuuQuizzes.isKind(of: NSDictionary.self){
                                    usuariosi.append(uuuQuizzes as! NSDictionary)
                                }else{
                                    let diccionario : NSDictionary = ["username":"anonymous", "id":"unknown"]
                                    usuariosi.append(diccionario)
                                }
                            }
                            // El GUI se actualiza en el Main Thread
                            DispatchQueue.main.async {
                                for i in preguntasi{
                                    self.preguntas.append(i as! String)
                                }
                                for i in fotosi{
                                    self.fotos.append(i as! String)
                                }
                                for i in usuariosi{
                                    self.usuarios.append(i)
                                }
                                for i in Idi{
                                    self.Ids.append(i as! Int)
                                }
                                let nextURL = quizzes["nextUrl"] as! String
                                if nextURL == ""{
                                    return
                                }else{
                                    let nextURL1 = quizzes["nextUrl"] as! String
                                    print(nextURL1)
                                    self.n = self.n + 1
                                    self.cargaPreguntas(url: nextURL1)
                                }
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            } else {
                print(url)
                if let data = try? Data(contentsOf: URL(string: url)!){
                    do{
                        let jsn = try JSONSerialization.jsonObject(with: data, options: [])
                        //print(jsn)
                        if let quizzes = jsn as? [String:Any] {
                            //    print(quizzes)
                            
                            //    print(nextURL)
                            let aQuizzes = quizzes["quizzes"] as! NSArray
                            //    print(aQuizzes)
                            
                            for i in aQuizzes{
                                let aaQuizzes = i as! NSDictionary
                                
                                let aaaQuizzes = aaQuizzes.value(forKey: "question") as! NSString
                                preguntasi.add(aaaQuizzes)
                                Idi.add(aaQuizzes.value(forKey: "id") as! Int)
                                let foto = aaQuizzes.value(forKey: "attachment") as! NSObject
                                if foto.isKind(of: NSDictionary.self){
                                    let fotoName = foto.value(forKey: "url") as! String
                                    fotosi.add(fotoName)
                                }else{
                                    fotosi.add("default1-image.jpg")
                                }
                                
                                
                                
                                let uuuQuizzes = aaQuizzes.value(forKey: "author") as! NSObject
                                if uuuQuizzes.isKind(of: NSDictionary.self){
                                    usuariosi.append(uuuQuizzes as! NSDictionary)
                                }else{
                                    let diccionario : NSDictionary = ["username":"anonymous", "id":"unknown"]
                                    usuariosi.append(diccionario)
                                }
                            }
                            // El GUI se actualiza en el Main Thread
                            DispatchQueue.main.async {
                                for i in preguntasi{
                                    self.preguntas.append(i as! String)
                                }
                                for i in fotosi{
                                    self.fotos.append(i as! String)
                                }
                                for i in usuariosi{
                                    self.usuarios.append(i)
                                }
                                for i in Idi{
                                    self.Ids.append(i as! Int)
                                }
                                let nextURL = quizzes["nextUrl"] as! String
                                if nextURL == ""{
                                    return
                                }else{
                                    let nextURL1 = quizzes["nextUrl"] as! String
                                    print(nextURL1)
                                    self.n = self.n + 1
                                    self.cargaPreguntas(url: nextURL1)
                                }
                            }
                            
                                
                            
                            
                            /*let nextURL = quizzes["nextUrl"] as! NSObject
                             if !nextURL.isKind(of: NSNull.self){
                             let nextURL1 = quizzes["nextUrl"] as! String
                             self.cargaPreguntas(url: nextURL1)
                             }
                             else{
                             for i in self.preguntas{
                             print(i)
                             }
                             for i in self.fotos{
                             print(i)
                             }
                             for i in self.usuarios{
                             print(i)
                             }
                             }*/
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preguntas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> QuizzesTableViewCell {
        let def = UIImage(named: "default1-image.jpg")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pregunta", for: indexPath) as! QuizzesTableViewCell
       
        cell.id.text = String(Ids[indexPath.row])
        cell.user.text = "by "+(usuarios[indexPath.row].value(forKey: "username"  ) as! String)
        cell.quiz.text = preguntas[indexPath.row]
        let img = fotos[indexPath.row]
        if img == "default1-image.jpg"{
            cell.foto.image = def
        }else{
            let queue = DispatchQueue(label: "Download Queue")
            queue.async {
                if let url = URL(string: img) {
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
                        
                        DispatchQueue.main.async {
                            cell.foto.image = img
                            
                        }
                    }
                }
            }
        }
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

