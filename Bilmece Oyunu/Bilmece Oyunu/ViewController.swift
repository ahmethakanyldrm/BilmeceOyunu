//
//  ViewController.swift
//  Bilmece Oyunu
//
//  Created by AHMET HAKAN YILDIRIM on 13.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    let answer = "DIŞTARAFTA"
    
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var answerChar1lbl: UILabel!
    
    @IBOutlet weak var answerChar2lbl: UILabel!
    
    @IBOutlet weak var answerChar3lbl: UILabel!
    
    @IBOutlet weak var answerChar4lbl: UILabel!
    
    @IBOutlet weak var answerChar5lbl: UILabel!
    
    @IBOutlet weak var answerChar6lbl: UILabel!
    
    @IBOutlet weak var answerChar7lbl: UILabel!
    
    @IBOutlet weak var answerChar8lbl: UILabel!
    
    @IBOutlet weak var answerChar9lbl: UILabel!
    
    @IBOutlet weak var answerChar10lbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var answerButton: UIButton!
    
    var timer = Timer()
    var counter = 10
    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        timerStart()
       
    }
    
    // MARK: - Actions

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
       
        let trimmedAnswer = answerTextField.text?.filter{!$0.isWhitespace}.uppercased()
        let okButton = UIAlertAction(title: "Ok", style: .default)
        let replayButton = UIAlertAction(title: "Tekrar Oyna", style: .default)
        
        guard let answerText = trimmedAnswer else { return }
        
        if answerText == answer {
            
            makeAlert(title: "Tebrikler", message: "Bilmecenin cevabını doğru bildiniz... Tebrikler 😇, Cevap : \(answerText)!", okButton: okButton, replayButton: nil)
            fillLabels()
            timer.invalidate()
            counter = 10
            timeLbl.text = "SÜRE: \(counter)"
            
        } else {
            timer.invalidate()
            counter = 10
            playAgain(warningMessage: "Cevabı doğru bulamadınız tekrar oynayalım mı ?")
        }
    }
    
    func fillLabels() {
        answerTextField.text = ""
        answerChar1lbl.text = String(answer[0]) + "\n..."
        answerChar2lbl.text = String(answer[1]) + "\n..."
        answerChar3lbl.text = String(answer[2]) + "\n..."
        answerChar4lbl.text = String(answer[3]) + "\n..."
        answerChar5lbl.text = String(answer[4]) + "\n..."
        answerChar6lbl.text = String(answer[5]) + "\n..."
        answerChar7lbl.text = String(answer[6]) + "\n..."
        answerChar8lbl.text = String(answer[7]) + "\n..."
        answerChar9lbl.text = String(answer[8]) + "\n..."
        answerChar10lbl.text = String(answer[9]) + "\n..."
    }
    
    // MARK: - Helper
    
    @objc func timerMakeAlert() {
        if counter != 0 {
            timeLbl.text = "SÜRE: \(counter)"
            counter -= 1
            
        }else {
            answerButton.isEnabled = false
            timer.invalidate()
            timeLbl.text = "SÜRE: \(counter)"
            counter = 10
            playAgain(warningMessage: "Belirtilen Sürede oyunu başarıyla tamamlayamadınız.")
        }
    }
    
    func timerStart() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerMakeAlert), userInfo: nil, repeats: true)
        timeLbl.text = "SÜRE: \(counter)"
    }
    
    func makeAlert(title:String, message: String, okButton: UIAlertAction, replayButton:UIAlertAction? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = okButton
        alert.addAction(okButton)
        if let replayButton = replayButton {
            alert.addAction(replayButton)
        }
        self.present(alert, animated: true)
    }
    
   
    
    func playAgain(warningMessage: String){
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { _ in
            self.fillLabels()
            
        }
        let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { _ in
            self.counter = 10
            self.answerButton.isEnabled = true
            self.timeLbl.text = "SÜRE: \(self.counter)"
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerMakeAlert), userInfo: nil, repeats: true)
            
        }
        makeAlert(title: "Süre Doldu !!", message: warningMessage, okButton: okButton, replayButton: replayButton)
        
    }
    
}

// MARK: - Helper

extension StringProtocol {
    subscript(offset:Int)-> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

