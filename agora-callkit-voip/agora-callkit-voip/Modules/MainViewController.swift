//
//  ViewController.swift
//  agora-callkit-voip
//
//  Created by Furkan Alioglu on 8.12.2023.
//

import UIKit
import AgoraUIKit

class MainViewController: UIViewController {
    // Fill the App ID of your project generated on Agora Console.
    let appId: String = "966f894700004efaa9a5086820075c85"

    // Fill the temp token generated on Agora Console.
    let token: String? = "007eJxTYHj+5IzFwjKp22KvtnS46r2VFFx36MG3CVPnW7hvfR8qeE1ZgcHSzCzNwtLE3AAITFLTEhMtE00NLMwsjAwMzE2TLUxPmxenNgQyMtxgLGZhZIBAEJ+NIa20KDsxj4EBAOsMIKg="

    // Fill the channel name.
    let channelName: String = "furkan"
    
    
    @IBOutlet weak var callButtonLabel: UILabel!
    @IBOutlet weak var callButtonOutlet: UIButton!
    let leaveChannelButton = UIButton()
     var agoraView: AgoraVideoViewer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func callButtonAction(_ sender: Any) {
        self.setupAgoraView()
        self.setupLeaveChannelButton()
    }
        
    func setupAgoraView() {
        agoraView = AgoraVideoViewer(
          connectionData: AgoraConnectionData(
            appId: appId, rtcToken: token
          )
        )
        if let agoraView = agoraView {
            agoraView.fills(view: self.view)
        }
        agoraView?.join(
            channel: channelName,
            with: token,
            as: .broadcaster
        )
    }
    
    func setupLeaveChannelButton() {
        leaveChannelButton.setTitle("Leave", for: .normal)
        leaveChannelButton.backgroundColor = .red
        leaveChannelButton.addTarget(self, action: #selector(leaveChannel), for: .touchUpInside)

        if let agoraView = agoraView {
            agoraView.addSubview(leaveChannelButton)
        }
        
        leaveChannelButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            leaveChannelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            leaveChannelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            leaveChannelButton.widthAnchor.constraint(equalToConstant: 100),
            leaveChannelButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func leaveChannel() {
        agoraView?.leaveChannel()
        DispatchQueue.main.async {[weak self] in
            guard let self else { return }
            leaveChannelButton.removeFromSuperview()
            agoraView?.removeFromSuperview()
        }
    }

}

