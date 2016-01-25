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
    
    var question:Question?
    var victorine:[Question]?
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup
    func setup() {
        self.view.backgroundColor = UIColor.orangeColor()
        //button.titleLabel?.numberOfLines = 0
        //button1.titleLabel?.numbersOfLines = 0
        //Button1.ti
        setupModel()
        setupViewWithQuestion(question!)
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
}



extension QuizViewController: ViewWilthButtonDelegate {
    func buttonWithTitlePressed(title: String) {
        
        if question!.isCorrectAnswer(title) {
            print("You winner")
            return
        }
        print("Sorry. Go back to school")
        
        let nextQuestion: Question
        
        var index = victorine?.indexOf({ $0 === question! })
        index!++
        
        if index < victorine?.count  {
            nextQuestion = victorine![index!]
            question = nextQuestion
            setupViewWithQuestion(question!)
        }
    }
}
























