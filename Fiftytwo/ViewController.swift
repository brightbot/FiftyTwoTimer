//
//  ViewController.swift
//  FiftyTwo
//
//  Created by Azin Mehrnoosh on 5/8/15.
//
//  Copyright (c) 2015 Azin Mehrnoosh
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //Defining the little clickity click sounds
    var buttonClick = AVAudioPlayer()
    var buttonTick = AVAudioPlayer()
    var buttonClicko = AVAudioPlayer()
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        //1
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        
        //2
        var error: NSError?
        
        //3
        var audioPlayer:AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        //4
        return audioPlayer!
    }
    
    //Interface stuff - mainly the color changer
    var greenColor: UIColor = UIColor(red:0.19, green:0.71, blue:0.76, alpha:1.0)
    var redColor: UIColor = UIColor(red:0.91, green:0.3, blue:0.24, alpha:1.0)
    var blueColor: UIColor = UIColor(red:0.26, green:0.64, blue:0.79, alpha:1.0)
    
    @IBOutlet weak var backgroundObject: UIView!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var playButton: UIBarButtonItem!
 
    //Interface color changer
    @IBAction func colorButton1(sender: UIButton) {
        self.backgroundObject.backgroundColor = blueColor
        playButton.tintColor = blueColor
        stopButton.tintColor = blueColor
        buttonTick.play()
    }
    @IBAction func colorButton2(sender: UIButton) {
        self.backgroundObject.backgroundColor = redColor
        playButton.tintColor = redColor
        stopButton.tintColor = redColor
        buttonTick.play()
    }
    @IBAction func colorButton3(sender: UIButton) {
        self.backgroundObject.backgroundColor = greenColor
        playButton.tintColor = greenColor
        stopButton.tintColor = greenColor
        buttonTick.play()
    }


    //Timer Stuff
    
    var timer = NSTimer()
    var count = 3120 //number of seconds in 52 minutes
    
    //The following code allows for HH:MM:SS type of output
    func secondsToHoursMinutesSeconds (var seconds : Int) -> (h:Int, m:Int, s:Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func updateTime() {
        var (h,m,s) = secondsToHoursMinutesSeconds(count)
        
        var str_min = String(format: "%01d", m)
        var str_sec = String(format: "%02d", s)
        
        count--
        
        time.text = "\(str_min):\(str_sec)" //This displays the function that ultimately splits the seconds into H,M,S
        
        if count == 0 {
            timer.invalidate()
            count = 1020
        }
        
    }
    
    @IBOutlet var time: UILabel!
    
    
    //This stops the timer
    @IBAction func stop(sender: AnyObject) {
        
        timer.invalidate()
        
        count = 3120
        
        time.text = "52:00"

        buttonClicko.play()
        
    }
    
    @IBAction func start(sender: AnyObject) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        
        buttonClick.play()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonClick = self.setupAudioPlayerWithFile("click", type:"m4a")
        buttonTick = self.setupAudioPlayerWithFile("tick", type: "m4a")
        buttonClicko = self.setupAudioPlayerWithFile("clicko", type: "m4a")

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}