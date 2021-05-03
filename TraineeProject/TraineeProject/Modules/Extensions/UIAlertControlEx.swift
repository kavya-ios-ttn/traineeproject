//
//  UIAlertControlEx.swift
//  TraineeProject
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    // Global Alert
    // Defines number of buttons, styles and completion
    
    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
  
}
