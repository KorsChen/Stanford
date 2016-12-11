//
//  ImageViewController.swift
//  Cassini
//
//  Created by 陈志鹏 on 11/25/16.
//  Copyright © 2016 陈志鹏. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate
{

    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
            return imageView
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            spinner?.stopAnimating()
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private func fetchImage()
    {
        if let url = imageURL {
            spinner?.startAnimating()
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async { [weak weakSelf = self] in
                let contentsOfURL = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if url == weakSelf?.imageURL {
                        if let imageData = contentsOfURL {
                            weakSelf?.image = UIImage(data: imageData)
                        } else {
                            weakSelf?.spinner.stopAnimating()
                        }
                    } else {
                        print("ignored data returned from url \(url)")
                    }

                }
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }

    override func viewWillAppear(_ animated: Bool)
    {
        if image == nil {
            fetchImage()
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
