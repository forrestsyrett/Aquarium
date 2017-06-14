//
//  AnimalDetailViewController.swift
//  Aquarium
//
//  Created by TLPAAdmin on 11/26/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import UIKit


class AnimalDetailViewController: UIViewController {
    
    
    @IBOutlet weak var animalNameLabel: UILabel!
    
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var animalInfo: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var ThreeDView: UIButton!
    
    @IBOutlet weak var conservationStatusImage: UIImageView!
    
    var name = ""
    var image = UIImage(named: "")
    var info = ""
    
    var animal = "none"
    var status = "none"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient(self.view)
        dismissButton.layer.cornerRadius = 19.5
        ThreeDView.layer.cornerRadius = 5.0
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 2000)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.animalNameLabel.text = name
        self.animalImage.image = image
        self.animalInfo.text = info
        animalImage.layer.cornerRadius = 5.0
        animalImage.clipsToBounds = true
        
        // Added to test 3D model functionality. Will hide button if no 3D Model is available.
        if self.name == "Blacktip Reef Shark" {
            self.ThreeDView.isHidden = false
            
        } else {
            self.ThreeDView.isHidden = true
        }
        
        
        switch self.status {
            case "Least Concern": conservationStatusImage.image = #imageLiteral(resourceName: "LeastConcern")
            case "Near Threatened": conservationStatusImage.image =
            #imageLiteral(resourceName: "NearThreatened")
            case "Vulnerable": conservationStatusImage.image = #imageLiteral(resourceName: "Vulnerable")
            case "Endangered": conservationStatusImage.image =
            #imageLiteral(resourceName: "Endangered")
            case "Critically Endangered": conservationStatusImage.image = #imageLiteral(resourceName: "CriticallyEndangered")
            case "Extinct in the Wild": conservationStatusImage.image = #imageLiteral(resourceName: "Extinct_In_Wild")
        default: break
        }

    }
    
    
    @IBAction func toModelButtonTapped(_ sender: Any) {
        
        if self.name == "Blacktip Reef Shark" {
            self.performSegue(withIdentifier: "toModel", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateInfo(animal: Animals) {
        self.name = animal.info.name
        self.image = animal.info.animalImage
        self.info = animal.info.description!
        self.status = animal.info.status
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
