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
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is QuizViewController {
            let nextViewController = segue.destinationViewController as! QuizViewController
            let quizJSON = sender as! [String : AnyObject]
            
            let name = quizJSON["name"] as! String
            //let question = quizJSON["questions"] as! []
            let questionsInfos = quizJSON["questions"] as! [NSDictionary]
            
            //создадим массив Question объектов
            var questionsObjects = [Question]()
            
            for info in questionsInfos {
                let questionObject = Question(json: info)
                questionsObjects.append(questionObject)
            }
            
            nextViewController.victorine = questionsObjects
            nextViewController.title = name

        }
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

extension SelectQuizViewController: UITableViewDataSource {
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuizes!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QuizCell", forIndexPath: indexPath)
        let quize = quizAtIndexPath(indexPath)
        let name = quize["name"] as! String
        cell.textLabel?.text = name
        return cell
    }
    
    func quizAtIndexPath(index: NSIndexPath) -> [String : AnyObject] {
        return allQuizes![index.row]
    }
}

extension SelectQuizViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedQuiz = quizAtIndexPath(indexPath)
        performSegueWithIdentifier("ShowQuiz", sender: selectedQuiz)
    }
}
