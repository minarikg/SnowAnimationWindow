import UIKit

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func stopTapped(_ sender: UIButton) {
        SnowfallController.shared.hide()
    }
}

