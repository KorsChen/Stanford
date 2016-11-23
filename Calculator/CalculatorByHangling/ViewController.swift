import UIKit

var calculatorCount = 0

@IBDesignable

class ViewController: UIViewController
{
    @IBOutlet private weak var display: UILabel!
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var isInputing = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        calculatorCount += 1
        print("Loaded up a new Calculator (count = \(calculatorCount))")
        brain.addUnaryOperation(symbol: "√") { [weak weakSelf = self] in
            weakSelf?.display.textColor = UIColor.red
            return sqrt($0)
        }
    }
    
    deinit {
        calculatorCount -= 1
        print("Calculator left the heap (count = \(calculatorCount))")

    }
    
    @IBAction private func touchdigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if isInputing {
            display.text = display.text! + digit
        } else {
            display.text = digit
        }
        isInputing = true
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if isInputing {
            brain.setOperand(displayValue)
            isInputing = false
        }
        if let symbol = sender.currentTitle {
            brain.performOperation(symbol)
        }
        displayValue = brain.result
    }
}
