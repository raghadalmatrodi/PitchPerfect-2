//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Raghad Almatrodi on 10/23/18.
//  Copyright © 2018 raghad almatrodi. All rights reserved.
//

import UIKit
import AVFoundation
class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled=false
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"
        {
            let playSoundsVC=segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        recordingLabel.text="Recording in progress"
        stopRecordingButton.isEnabled=true
        recordButton.isEnabled=false
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode:AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate=self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    
    @IBAction func stopRecording(_ sender: AnyObject) {
        recordButton.isEnabled=true
        stopRecordingButton.isEnabled=false
        recordingLabel.text="Tap to Record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
       if flag
       {performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
    }
        else
       { print("Recording was not successful")}
    
     
   

}
}
