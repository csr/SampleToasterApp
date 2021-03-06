//
//  ToasterViewController.swift
//  MES_Full_Stack_Intro_to_iOS
//
//  Created by Cesare De Cal on 20/08/2021.
//

import UIKit
import AVFoundation

class ToasterViewController: UIViewController {

    var toasterImageView: UIImageView!

    // To play the toaster sound
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set view background color
        view.backgroundColor = UIColor(red: 254/255, green: 247/255, blue: 242/255, alpha: 1)

        // Creates a label for the title
        let titleLabel = UILabel()
        titleLabel.text = "Toaster"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)

        // Creates a label for the subtitle
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Let's toast some toast."
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)

        // Take the labels and put them in a vertical container
        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 8

        // Image view to display the awesome toast
        toasterImageView = UIImageView()
        toasterImageView.contentMode = .scaleAspectFit
        toasterImageView.image = UIImage(named: "toaster_no_bread")

        // Set image view height
        toasterImageView.translatesAutoresizingMaskIntoConstraints = false
        toasterImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true

        // Button users can tap to toast bread
        let toastButton = UIButton()
        toastButton.backgroundColor = UIColor(red: 147/255, green: 82/255, blue: 203/255, alpha: 1)
        toastButton.setTitle("Toast!", for: .normal)

        toastButton.layer.cornerRadius = 5

        // Add action to toast button
        toastButton.addTarget(self, action: #selector(didTapToastButton), for: .touchUpInside)

        // Create a container view with labels, image view, and button
        let containerStackView = UIStackView(arrangedSubviews: [labelsStackView, toasterImageView, toastButton])
        containerStackView.axis = .vertical
        containerStackView.distribution = .equalSpacing

        // Enable AutoLayout
        containerStackView.translatesAutoresizingMaskIntoConstraints = false

        // Add container stack view to view controller's view
        view.addSubview(containerStackView)

        // Anchor the container view to the view controller's view
        containerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    }

    @objc
    private func didTapToastButton() {
        turnOnToaster()
    }

    private func turnOnToaster() {
        // Update image
        toasterImageView?.image = UIImage(named: "toaster_with_bread")

        playToasterSpringSound()
    }
}

extension ToasterViewController {
    func playToasterSpringSound() {
        guard let url = Bundle.main.url(forResource: "toaster_spring", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

