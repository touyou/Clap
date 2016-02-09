//
//  ViewController.swift
//  Clap
//
//  Created by 藤井陽介 on 2016/02/01.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var clapPickerView: UIPickerView!
    var audioPlayer: AVAudioPlayer!
    var soundCount:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let soundFilePath = NSBundle.mainBundle().pathForResource("clap", ofType: "wav")!
        // とりあえず求められているのがString型なのでキャストして対応
        let fileURL = NSURL(fileURLWithPath: String(soundFilePath))
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: fileURL)
        } catch {
            print("音楽ファイルが読み込めませんでした。")
        }
        clapPickerView.delegate = self
        clapPickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // PickerViewのセクションの数
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    // PickerViewの選択肢の数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 20
    }
    // PickerViewの選択肢の文字列
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(row+1)回"
    }
    // 選ばれた選択肢に応じてどうするか
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        soundCount = row
    }
    // 選択肢の数だけ連続再生
    @IBAction func playButton() {
        audioPlayer.numberOfLoops = soundCount
        audioPlayer.play()
    }
}

