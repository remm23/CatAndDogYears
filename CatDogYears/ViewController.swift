//
//  ViewController.swift
//  CatDogYears
//
//  Created by Remi Tobias on 11/11/2017.
//  Copyright © 2017 Remi Tobias. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var catAgeLable: UILabel!
    @IBOutlet weak var dogAgeLabel: UILabel!
    @IBOutlet weak var catEntry: UITextField!
    @IBOutlet weak var dogEntry: UITextField!
    @IBOutlet weak var randomFactLabel: UILabel!
    @IBOutlet weak var dogEntryBottomConstraint: NSLayoutConstraint!
    
    var player: AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        catEntry.delegate = self
        dogEntry.delegate = self
        getRandomFact()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Closes keyboard when screen is tapped
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Closes keyboard when "return" button is pressed
        textField.resignFirstResponder()
        return true
    }
    
    func getRandomFact() {
        let randomNumber = Int(arc4random_uniform(UInt32(facts.count)))
        randomFactLabel.text = facts[randomNumber]
    }
    
    func playSound(_ file:String) {
        guard let sound = Bundle.main.url(forResource:file, withExtension: "mp3") else {
            return
        }
        
        do{
            player = try AVAudioPlayer(contentsOf: sound)
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
        } catch {
            print("error getting audio file")
        }
    }
    
    @IBAction func calculateCatTapped(_ sender: Any) {
        if catEntry.text == "" {
            catEntry.text = "1"
        }
        
        let age = Double(catEntry.text!)!
        var result: Double = 0
        
        switch age {
        case 1: result = 15
        case 2: result = 24
        default: result = (((age - 2) * 4) + 24)
        }
        
        catAgeLable.text = String(result)
        
        playSound("meow")
        
        catAgeLable.isHidden = false
        catEntry.text = ""
        catEntry.resignFirstResponder()
        getRandomFact()
    }
    
    @IBAction func calculateDogTapped(_ sender: Any) {
        if dogEntry.text == "" {
            dogEntry.text = "1"
        }
        
        let age = Double(dogEntry.text!)!
        var result: Double = 0
        
        switch age {
        case 1,2: result = age * 10.5
        default: result = (age - 2) * 4
        }
        
        dogAgeLabel.text = String(result)
        
        playSound("bark")
        
        dogAgeLabel.isHidden = false
        dogEntry.text = ""
        dogEntry.resignFirstResponder()
        getRandomFact()
    }
    
}

