
import UIKit

class PasswordView: UIView, UIKeyInput {

    var text: String = ""
    var isEncrypt = false            //是否加密
    
    var textFont = UIFont.systemFont(ofSize: 30)
    var maxLength = 4
    var space = 25 as CGFloat
    var textColor = UIColor.white
    var lineColor = UIColor.white
    
    var complete: ((String)->Void)?
    
    var hasText: Bool {
        return text.count > 0
    }
    
    func insertText(_ str: String) {
        if text.count < maxLength {
            text.append(str)
            self.setNeedsDisplay()
            
            if shouldComplete() {
                complete?(text)
            }
        }
    }
    
    func deleteBackward() {
        if text.count > 0 {
            text.removeLast()
            self.setNeedsDisplay()
        }
    }
    
    func shouldComplete() -> Bool {
        return text.count == maxLength
    }
    
    var isSecureTextEntry = true
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {return}
        
        ctx.setLineWidth(1)
        //开始画底部的线
        
        let width = (rect.width - CGFloat(maxLength - 1) * space)/CGFloat(maxLength)
        
        Array(1...maxLength).forEach { (index) in
            if index <= text.count {
                ctx.setStrokeColor(textColor.cgColor)
            }
            else {
        
                ctx.setStrokeColor(textColor.withAlphaComponent(0.5).cgColor)
            }
            
            let offsetX = (width + space) * CGFloat(index - 1)
            let offsetY = rect.height - 1
            ctx.move(to: CGPoint(x: offsetX, y: offsetY))
            ctx.addLine(to: CGPoint(x: offsetX + width, y: offsetY))
            ctx.strokePath()
        }
        
        ctx.setStrokeColor(textColor.cgColor)
        ctx.translateBy(x: 0, y: rect.height)
        ctx.scaleBy(x: 1, y: -1)
        
        //开始画数字
        var index = 1
        text.forEach { (t) in
            let str = isEncrypt ? "*" : String(t)
            let attriStr = NSAttributedString(string: str, attributes:
                [NSAttributedStringKey.font: textFont,
                 NSAttributedStringKey.foregroundColor: textColor])
            let frameSetter =
                CTFramesetterCreateWithAttributedString(attriStr)
            
            var frameSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 1), nil, CGSize(width: width, height: rect.height), nil)
            frameSize.width = ceil(frameSize.width)
            frameSize.height = ceil(frameSize.height)
            
            let offsetX = (width + space) * CGFloat(index - 1)
            let path = UIBezierPath(rect: CGRect(x: offsetX + (width - frameSize.width)/2, y: (rect.height - frameSize.height)/2, width: frameSize.width, height: frameSize.height)).cgPath
            let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 1), path, nil)
            CTFrameDraw(frame, ctx)
            index = index + 1
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }

    //MARK: - public
    
    func clean() {
        if text.count > 0 {
            text.removeAll()
            self.setNeedsDisplay()
        }
    }
}


