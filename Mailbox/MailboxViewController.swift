//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Kyle DeHovitz on 5/21/15.
//  Copyright (c) 2015 Kyle DeHovitz. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var helpView: UIImageView!
    @IBOutlet weak var searchView: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var archiveIconView: UIImageView!
    @IBOutlet weak var laterIconView: UIImageView!
    @IBOutlet weak var deleteIconView: UIImageView!
    @IBOutlet weak var listIconView: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    
    
    var initialCenter: CGPoint!
    var rightPosition: CGFloat!
    var leftPosition: CGFloat!
    
    let blueColor = UIColor(red:68/255, green: 170/255, blue: 210/255, alpha: 1)
    let yellowColor = UIColor(red: 254/255, green: 202/255, blue: 22/255, alpha: 1)
    let brownColor = UIColor(red: 206/255, green: 150/255, blue: 98/255, alpha: 1)
    let greenColor = UIColor(red: 85/255, green: 213/255, blue: 80/255, alpha: 1)
    let redColor = UIColor(red: 231/255, green: 61/255, blue: 14/255, alpha: 1)
    let grayColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 320, height: 2500)
        rightPosition = messageView.center.x + 100
        leftPosition = messageView.center.x - 100
        initialCenter = messageView.center
        listView.alpha = 0
        rescheduleView.alpha = 0
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        
        
        if sender.state == UIGestureRecognizerState.Began {
            
            containerView.backgroundColor = grayColor
            
            archiveIconView.alpha = 0.5
            deleteIconView.alpha = 0
            laterIconView.alpha = 0.5
            listIconView.alpha = 0
            
        }
            
        else if sender.state == UIGestureRecognizerState.Changed {
            messageView.center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y)
            println("Gesture changed at: \(location)")
            
            //Drag Left
            
            if messageView.center.x < initialCenter.x - 60 && messageView.center.x > initialCenter.x - 240 {
                
                //laterIcon trails behind message
                self.laterIconView.center.x = CGFloat(self.messageView.center.x + 200)

                
                UIView.animateWithDuration(0.2, animations: {
                    
                    //laterIcon appears
                    self.laterIconView.alpha = 1
                    self.archiveIconView.alpha = 0
                    self.deleteIconView.alpha = 0
                    self.listIconView.alpha = 0
                    self.containerView.backgroundColor = UIColor.yellowColor()})
                
            }
                
            else if messageView.center.x < initialCenter.x - 240 {
                
                //listIcon follows messageView
                self.listIconView.center.x = CGFloat(self.messageView.center.x + 200)
                
                UIView.animateWithDuration(0.2, animations: {
                    
                    //listIcon Appears
                    self.archiveIconView.alpha = 0
                    self.deleteIconView.alpha = 0
                    self.listIconView.alpha = 1
                    self.laterIconView.alpha = 0
                    self.containerView.backgroundColor = UIColor.brownColor()
                })
                
            }
            
            //Drag Right
            
            else if messageView.center.x > initialCenter.x + 60 && messageView.center.x < initialCenter.x + 240 {
                
                //archiveIcon trails behind message
                self.archiveIconView.center.x = CGFloat(self.messageView.center.x - 200)
                
                UIView.animateWithDuration(0.2, animations: {
                    
                    //archiveIcon appears
                    self.archiveIconView.alpha = 1
                    self.deleteIconView.alpha = 0
                    self.listIconView.alpha = 0
                    self.laterIconView.alpha = 0
                    self.containerView.backgroundColor = UIColor.greenColor()
                })
                
            }
                
            else if messageView.center.x > initialCenter.x + 240 {
                
                //deleteIcon trails behind messageView
                self.deleteIconView.center.x = CGFloat(self.messageView.center.x - 200)
                
                UIView.animateWithDuration(0.2, animations: {
                    self.archiveIconView.alpha = 0
                    self.deleteIconView.alpha = 1
                    self.listIconView.alpha = 0
                    self.laterIconView.alpha = 0
                    self.containerView.backgroundColor = UIColor.redColor()
                })
                
            }
            
            else {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.containerView.backgroundColor = self.grayColor

                })
                
            }

        }
            
            
        //Gesture ended
        else if sender.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(location)")
            
            
            

                //Show the rescheduleView
            if messageView.center.x < initialCenter.x - 60 && messageView.center.x > initialCenter.x - 240 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.backgroundColor = UIColor.yellowColor()
                    self.messageView.center.x = self.initialCenter.x - 400
                    self.laterIconView.center.x = CGFloat(self.messageView.center.x + 200)

                }, completion: { (Bool) -> Void in
                    self.rescheduleView.alpha = 1
//                    self.dismissCell()
                })
                
            }
                
            
                //Show the listView
            else if messageView.center.x < initialCenter.x - 240 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.backgroundColor = UIColor.brownColor()
                    self.messageView.center.x = self.initialCenter.x - 400
                    self.listIconView.center.x = CGFloat(self.messageView.center.x + 200)

                }, completion: { (Bool) -> Void in
                    self.listView.alpha = 1
                    
                })
                
            }
            
            //Archive the message
            else if messageView.center.x > initialCenter.x + 60 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.backgroundColor = UIColor.greenColor()
                    self.messageView.center.x = self.initialCenter.x + 400
                    self.deleteIconView.center.x = CGFloat(self.messageView.center.x - 200)
                    self.archiveIconView.center.x = CGFloat(self.messageView.center.x - 200)

                }, completion: { (Bool) -> Void in
                    self.dismissCell()
                    
                })
                
            }
            
            else {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center.x = self.initialCenter.x
                })
                
            }
            
        }
        
    }
    
    @IBAction func didTapReschedule(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.rescheduleView.alpha = 0
        })
        
        self.dismissCell()

    }
    
    @IBAction func didTapList(sender: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.listView.alpha = 0
        })
        
        self.dismissCell()
        
    }
    
    func dismissCell() {
        println("dismissCell")
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.messageView.center.x = self.messageView.center.x + 500
            self.archiveIconView.center.x = CGFloat(self.messageView.center.x - 200)
            self.feedView.center.y = self.feedView.center.y - 90
        })
        
    }
    
    @IBAction func didReset(sender: AnyObject) {
        println("reset")
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.messageView.center.x = self.initialCenter.x
            self.feedView.center.y = self.feedView.center.y + 90
        
        })
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
