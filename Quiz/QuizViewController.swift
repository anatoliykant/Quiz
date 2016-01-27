//
//  QuizViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 20/01/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quizView: ViewWilthButton!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    var question:Question?
    var victorine:[Question]?
    
    var earnedPoints = 0 {
        //каждый раз, когда значение заработанных очков меняется
        //будет обновляться текст заработанных очков
        didSet {
            setupPointsLabel()
        }
    }
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        //pointsLabel.text =
    }
    
    //MARK: - Setup
    func setup() {
        
        title = "Кино"
        self.view.backgroundColor = UIColor.orangeColor()
        //button.titleLabel?.numberOfLines = 0
        //button1.titleLabel?.numbersOfLines = 0
        //Button1.ti
        setupModel()
        setupViewWithQuestion(question!)
        setupPointsLabel()
    }
    
    func setupModel() {
        let storeManager = StoreManager()
        
        victorine = storeManager.loadQuestionsByTheme("theme")
        question = victorine?.first
    }
    
    func setupViewWithQuestion(aQuestion:Question) {
        
        quizView.updateTopText(aQuestion.text)
        quizView.updateImage(aQuestion.image)
        quizView.updateButtonsTitles(aQuestion.answers)
        
        quizView.delegate = self
    }
    
    func setupPointsLabel() {
        let totalQuestionsCount = victorine!.count
        let result = "Очков набрано \(earnedPoints) из \(totalQuestionsCount)"
        pointsLabel.text = result
     }
}



extension QuizViewController: ViewWilthButtonDelegate {
    func buttonWithTitlePressed(title: String) {
        
        if question!.isCorrectAnswer(title) {
            print("You winner")
            earnedPoints++

        }
        else {
            print("Sorry. Go back to school")
        }
        
        let nextQuestion: Question
        
        var index = victorine?.indexOf({ $0 === question! })
        index!++
        
        //Пока не дошли до последнего вопроса, будем показывать следующее
        if index < victorine?.count  {
            nextQuestion = victorine![index!]
            question = nextQuestion
            setupViewWithQuestion(question!)
            return
        }
        
        let result  = Double(earnedPoints) / Double(victorine!.count)
        //запустим переход к новому вьюконтроллеру
        performSegueWithIdentifier("Show Rating", sender: result)
        
    }
    
    //перед переходом на новый экран вызвывается этот метод,
    // где может получить информацию о следующем вью контроллере
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is ResultViewController {
            let nextViewControler = segue.destinationViewController as! ResultViewController
            nextViewControler.rating = sender as! Double
        }
    }
}
























