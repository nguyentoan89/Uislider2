//
//  ViewController.swift
//  UISlider
//
//  Created by Nguyen Cong Toan on 3/22/17.
//  Copyright © 2017 mr.t. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate

{
    
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var tbl_music: UITableView!
    
    
    @IBOutlet weak var lbl_CurrentTime: UILabel!
    @IBOutlet weak var lbl_TimeTotal: UILabel!
    @IBOutlet weak var btn_Play: UIButton!
    @IBOutlet weak var sld_Duration: UISlider!
    var audio = AVAudioPlayer()
    
    var file_Nhac = ["Chac ai do se ve", "Lac troi", "Nay chan dat oi", "Mua"]
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return file_Nhac.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = file_Nhac[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lbl_name.text = file_Nhac[indexPath.row]
        //audio = setAudioPlayer(file: file_Nhac[indexPath.row], type: "mp3")
        //audio.play()
       // sld_Duration.maximumValue = Float(audio.duration)
        //sld_Duration.minimumValue = 0
        //sld_Duration.value = 0
        

    }
    

    @IBOutlet weak var sld_volume: UISlider!
    @IBAction func action_Play(_ sender: Any) {
        if audio.isPlaying
      {
            audio.stop()
            btn_Play.setImage(UIImage(named: "play.png"), for: UIControlState.normal)
      }
        else
      {
        audio.play()
        btn_Play.setImage(UIImage(named: "pause.png"), for: UIControlState.normal)
        }
    }
    @IBAction func sld_Volume(_ sender: UISlider) {
        audio.volume = sender.value
    }
    @IBAction func sld_ActionTime(_ sender: UISlider) {
      audio.currentTime = TimeInterval(sld_Duration.value)
    }
    
    @IBAction func uis_Repeat(_ sender: UISwitch) {
        if sender.isOn == true
        {
            audio.numberOfLoops = -1
        }
        
        if sender.isOn == false
        {
            audio.numberOfLoops = 0
        }
    }
    
    
    func setAudioPlayer(file: String, type: String) -> AVAudioPlayer
    {
        let path = Bundle.main.path(forResource: file, ofType: type)
        let url = NSURL.fileURL(withPath: path!)
        do
        {
            audio = try! AVAudioPlayer(contentsOf: url)
        }
         catch
         {
            print("Player not available")
        }
        return audio
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tim file nhac
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "chac ai do se ve", ofType: ".mp3")!) as URL)
        //setAudioPlayer(file: file_Nhac[0], type: "mp3")
        audio.numberOfLoops = -1
        audio.prepareToPlay()
        sld_Duration.maximumValue = Float(audio.duration)
        sld_Duration.minimumValue = 0
        sld_Duration.value = 0
        tbl_music.delegate = self
        tbl_music.dataSource = self
        lbl_name.text = file_Nhac[0]
        addThumbImgForSlider()
        setThump()
        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
       
    }
        func setThump()
    {
        sld_Duration.setThumbImage(UIImage(named: "duration.png"), for: UIControlState.normal)
    }

    func updateTime()
    {
        
        sld_Duration.value = Float(audio.currentTime)
        self.lbl_CurrentTime.text = String(format: "%2.2f", audio.currentTime/60)
        self.lbl_TimeTotal.text = String(format: "%2.2f", audio.duration/60)
        if audio.currentTime == 0
        {
            btn_Play.setImage(UIImage(named: "play.png"), for: UIControlState.normal)
        }
    }
    func addThumbImgForSlider()
    {
        sld_volume.setThumbImage(UIImage(named: "thumb.png"), for: UIControlState.normal)
        sld_volume.setThumbImage(UIImage(named: "thumbHightLight.png"), for: UIControlState.highlighted)
    }
    
   
}

