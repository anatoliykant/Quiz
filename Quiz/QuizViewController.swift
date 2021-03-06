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
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup
    func setup() {
        self.view.backgroundColor = UIColor.orangeColor()
        
        setupModel()
        setupViewWithQuestion(question!)
    }
    
    func setupModel() {
        question = Question(text: "Как звали няню Пушкина?",
            answers: ["Вася",
                      "Арина Радионовна",
                      "Виолетта Акардионовна",
                      "Александра Юрьевна"],
            correctAnswer: "Арина Радионовна",
            imageName: "1")
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
    }
}
























