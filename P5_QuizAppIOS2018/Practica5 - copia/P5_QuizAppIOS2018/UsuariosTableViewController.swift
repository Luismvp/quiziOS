//
//  UsuariosTableViewController.swift
//  P5_QuizAppIOS2018
//
//  Created by Luis Martin de Vidales Palomero on 23/11/2018.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class UsuariosTableViewController: UITableViewController {
    var usuarios : [Any?] = []{
        didSet{
            tabla.reloadData()
            print(usuarios)
        }
    }
    
    @IBOutlet var tabla: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usuarios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usuario", for: indexPath)
        if let nombre = ((usuarios[indexPath.row] as! NSDictionary).value(forKey: "username") as? String){
            cell.textLabel?.text = nombre
            cell.detailTextLabel?.text = String((usuarios[indexPath.row] as! NSDictionary).value(forKey: "id") as! Int)
        }else{
            cell.textLabel?.text = "Anónimo"
            cell.detailTextLabel?.text = String((usuarios[indexPath.row] as! NSDictionary).value(forKey: "id") as! Int)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "autor"{
            let bvc = segue.destination as! UsuarioViewController
            let celula = sender as! UITableViewCell
            let nombre = celula.textLabel?.text
            bvc.nn = nombre!
            bvc.i = (celula.detailTextLabel?.text)!
        }
    }
    

}
