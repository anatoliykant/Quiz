//
//  ResultViewController.swift
//  Quiz
//
//  Created by anatoliy.kant on 27.01.16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var ratingText: UILabel!
    
    var rating: Double = 0 {
        didSet {
            if rating > 1 {
                rating = 1
            }
            if rating < 0 {
                rating = 0
            }
        }
    }//значения от 0 до 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateText()
    }
    
    func updateText() {
        switch rating {
        case 0..<0.1: ratingText.text = "Малыш"
        case 0.1..<0.4: ratingText.text = "Школьник"
        case 0.4..<0.8: ratingText.text = "Стажер"
        default: ratingText.text = "Гений"
        }        
        
        /*if(rating = 0) {
            ratingText.text = "Малыш"
        }
        if rating < 0.4 ratingText.text = "Школьник"
        */
    }

}
