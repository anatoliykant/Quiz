//
//  SelectQuizViewController.swift
//  Quiz
//
//  Created by anatoliy.kant on 27.01.16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class SelectQuizViewController: UIViewController {

    //коллекция из объектов вида Ключ:Значение
    var allQuizes:[[String:AnyObject]]?
    /*= {
        return loadAllQuizes()

    }()
*/
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        allQuizes = loadAllQuizes()
            }
    
    func loadAllQuizes() -> [[String:AnyObject]] {
        let allJSONfilesPaths = NSBundle.mainBundle().pathsForResourcesOfType("json", inDirectory: nil)
        
        var loadedJSONs = [[String:AnyObject]]()
        
        //преоразуем все пути к файлам формата JSON
        for aPath in allJSONfilesPaths {
            let dataAtPath = NSData(contentsOfFile: aPath)
            //попытаемся считать данные из некой директории
            do {//преобразуем их в объект
                let json = try NSJSONSerialization.JSONObjectWithData(dataAtPath!, options: [])
                
                loadedJSONs.append(json as! [String: AnyObject])
            }
            catch {
                print("Can't get objects from file \(aPath))")
                //return loadedJSONs
            }
            
        }
        print("found jsons \(loadedJSONs))")
        return loadedJSONs
    }
}
