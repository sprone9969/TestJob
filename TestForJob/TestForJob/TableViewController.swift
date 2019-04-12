//
//  TableViewController.swift
//  TestForJob
//
//  Created by Умид Халилов on 12/04/2019.
//  Copyright © 2019 Умид Халилов. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class TableViewController: UITableViewController{

    
    var bd:[Person] = []
    
    // это нужно для того что бы парсить данные начало
    struct jj {
        
        var name: String
        var height: String
        var mass: String
        var hair_color: String
        var skin_color: String
        var eye_color: String
        var birth_year: String
        var gender: String
        var homeworld: String
        var films: String  //[String] // подумай что с этим можно сделать !! нужно массив положить в бд
        var species: String  //[String] // подумай что с этим можно сделать !! нужно массив положить в бд
        var vehicles: String  //[String] // подумай что с этим можно сделать !! нужно массив положить в бд
        var starships: String  //[String] // подумай что с этим можно сделать !! нужно массив положить в бд
        var created: String
        var edited: String
        var url: String
        
        init(json:[String: Any ])
        {
            name = json["name"] as? String ?? ""
            height = json["height"] as? String ?? ""
            mass = json["mass"] as? String ?? ""
            hair_color = json["hair_color"] as? String ?? ""
            skin_color = json["skin_color"] as? String ?? ""
            eye_color = json["eye_color"] as? String ?? ""
            birth_year = json["birth_year"] as? String ?? ""
            gender = json["gender"] as? String ?? ""
            homeworld = json["homeworld"] as? String ?? ""
            films = json["films"] as? String ?? "" //as! [String] // подумай что с этим можно сделать !! нужно массив положить в бд
            species = json["species"] as? String ?? "" //as! [String] // подумай что с этим можно сделать !! нужно массив положить в бд
            vehicles = json["vehicles"] as? String ?? "" //as! [String] // подумай что с этим можно сделать !! нужно массив положить в бд
            starships = json["starships"] as? String ?? "" //as! [String] // подумай что с этим можно сделать !! нужно массив положить в бд
            created = json["created"] as? String ?? ""
            edited = json["edited"] as? String ?? ""
            url = json["url"] as? String ?? ""
        }
    }
    // это нужно для того что бы парсить данные конец
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //место нахождение бд начало
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        //место нахождение бд конец
        
        //парсим данные начало
        Alamofire.request("https://swapi.co/api/people/1" ).responseJSON
        {
            response in //считываем данные из сайта
            print("Request: \(String(describing: response.request))")   // ссылка на сайт откуда берем
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            guard let json = response.result.value as? [String: Any] else { return }
            let cc = jj(json: json)
            print("Name  \(cc.name)") // выводим из переменной данные
            
            //сохрание в бд начало
            self.save(name: cc.name)
           
        }
        //парсим данные конец
    }

    
    
    //функция сохранения данных в бд начало
    func save(name: String)
    {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Person
        taskObject.name = name
        
        do {
            try context.save()
            bd.append(taskObject)
            print("Saved! Good Job!")
            
            self.tableView.reloadData()
            //print(taskObject.name)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //функция сохранения данных в бд конец
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)


       // cell.textLabel?.text = task
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
