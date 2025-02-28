import UIKit

class BarGraphView: UIView {

    var progress: CGFloat = 0.7 {
        didSet { setNeedsDisplay() }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let totalBars = 15
        let barWidth = rect.width / CGFloat(totalBars * 2)
        let barHeight = rect.height
        let filledBars = Int(round(progress * CGFloat(totalBars)))

        for i in 0..<totalBars {
            let x = CGFloat(i) * barWidth * 2
            let color = i < filledBars ? UIColor.systemGray : UIColor.lightGray.withAlphaComponent(0.4)
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: x, y: 0, width: barWidth, height: barHeight))
        }
    }
}
