//
//  Quiestion.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 20/01/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class Question {
    
    //текст вопроса
    let text:String
    //массив строк
    let answers:[String]
    let correctAnswer:String
    let imageName:String
    
    //тип optional. Может создасться изображение, а может быть и нет
    var image:UIImage? {
        get {
            //Создаст объект с изображением
            return UIImage(named: imageName)
        }
    }
    
    init(text:String, answers:[String], correctAnswer:String, imageName:String){
        self.text = text
        self.answers = answers
        self.correctAnswer = correctAnswer
        self.imageName = imageName
    }
    
    //метод для проверки одного из вариантов ответа
    func isCorrectAnswer(variant:String) -> Bool {
        return variant == correctAnswer
    }
}
