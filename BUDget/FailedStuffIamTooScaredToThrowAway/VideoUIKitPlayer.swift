//
//  VideoUIKitPlayer.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 2/14/24.
//

import Foundation
import UIKit
import SwiftUI
import AVKit


class VideoViewController: UIViewController{
    
    @IBOutlet weak var playVideo: UIButton!
    @IBOutlet weak var EXIT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func EXIT(_ sender: Any) {
        switchViewController(from: self.view, to: "GameViewController")
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        guard let localPath = Bundle.main.path(forResource: VideoUrl, ofType: "mp4")else{
            print("no url")
            return
        }
        let player = AVPlayer.init(url: URL(fileURLWithPath: localPath))
        let popUpController = AVPlayerViewController()
        popUpController.player = player
        present(popUpController, animated: true){
            player.play()
        }
    }
}
