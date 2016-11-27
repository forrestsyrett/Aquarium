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
    
    var name = ""
    var image = UIImage(named: "")
    var info = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient(self.view)
        dismissButton.layer.cornerRadius = 19.5
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.animalNameLabel.text = name
        self.animalImage.image = image
        self.animalInfo.text = info
        animalImage.layer.cornerRadius = 5.0
        animalImage.clipsToBounds = true

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