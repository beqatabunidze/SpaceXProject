//
//  UIVIewController + Extensions.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    
    func openSafari(_ url: String) {
        
        guard let url = URL(string: url) else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
}
