//
//  CassiniViewController.swift
//  Cassini
//
//  Created by 陈志鹏 on 12/11/16.
//  Copyright © 2016 陈志鹏. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate
{
    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
    }

//方法一：通过segue跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == Storyboard.ShowImageSegue {
            if let ivc = segue.destination.contentViewController   as? ImageViewController {
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.HZWImageNamed(imageName)
                ivc.title =  imageName
            }
        }
    }
    
//方法二：code跳转
    @IBAction func showImage(_ sender: UIButton)
    {
        if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController {
            let imageName = sender.currentTitle
            ivc.imageURL = DemoURL.HZWImageNamed(imageName)
            ivc.title = imageName
        } else {
            performSegue(withIdentifier: Storyboard.ShowImageSegue, sender: sender)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool
    {
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController.contentViewController as? ImageViewController, ivc.imageURL == nil {
                return true
            }
        }
        return false
    }
}

extension UIViewController
{
    var contentViewController: UIViewController {
        if let navcom = self as? UINavigationController {
            return navcom.visibleViewController ?? self
        } else {
            return self
        }
    }
}
