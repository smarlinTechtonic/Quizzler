//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var questionNumber: Int = 0
    let questionBank = QuestionBank()
    var chosenAnswer: Bool = false
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            chosenAnswer = true
        } else {
            chosenAnswer = false
        }
        checkAnswer()
        questionNumber += 1
        updateUI()
    }
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1 )
        progressLabel.text = "\(questionNumber + 1)/ \(questionBank.list.count)"
        nextQuestion()
    }

    func nextQuestion() {
        if questionNumber >= questionBank.list.count {
            let alert = UIAlertController(title: "Redo?", message: "You finished the quix. Would you like to retake it?", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Retake Quiz", style: .default, handler: { UIAlertAction in
                self.startOver()
            })
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } else {
            questionLabel.text = questionBank.list[questionNumber].questionText
        }
    }
    
    func checkAnswer() {
        let correctAnswer = questionBank.list[questionNumber].answer
        if chosenAnswer == correctAnswer {
            score += 1
            ProgressHUD.showSuccess("Correct!")
        } else {
            ProgressHUD.showError("Incorrect!")
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        updateUI()
    }
    
}
