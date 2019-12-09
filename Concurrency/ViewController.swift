//
//  ViewController.swift
//  Concurrency
//
//  Created by Alex Paul on 12/5/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var planetImageView: UIImageView!
    
    let imageURLString = "https://apod.nasa.gov/apod/image/1912/NGC6744_FinalLiuYuhang.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Thread.isMainThread {
            print("on the main thread")
        }
    }
    
    @IBAction func loadImage(_ sender: UIBarButtonItem) {
        guard let url = URL(string: imageURLString) else {
            fatalError("bad url \(imageURLString)")
        }
        
        // NOT CONCURRENT - BLOCKS THE MAIN THREAD
        //        do {
        //            // querying the url online resource and downloading to a data object
        //            // anytime you are querying an online source do not use Data(contentsOf:), use URLSession() instead
        //
        //            let imageData = try Data(contentsOf: url)
        //            let image = UIImage(data: imageData)
        //            planetImageView.image = image
        //        } catch {
        //            print("loading contents error: \(error)")
        //        }
        //    }
        
        DispatchQueue.global(qos: .userInitiated).async {
            // data processing off the main thread
            
            do {
                let imageData = try Data(contentsOf: url)
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.planetImageView.image = image
                }
                
            } catch {
                print("contents of error: \(error)")
            }
        }
        
    }
}

