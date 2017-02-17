# VideoBackground
Lightweight video view

![VideoBackground](http://codingroup.com/assets/external/video-background.gif)

## Installation 
####CocoaPods:
Add `pod 'VideoBackground', '~> 0.1.0'` to Podfile and run `$ pod install`


####Manual:
Add files from `VideoBackground/Classes/*` to your project

##How to use it 
Import VideoBackground where you plan to use it then add VideoBackground as subview
 
```
let videoPath = Bundle.main.path(forResource: "videoFile", ofType: "mov")
let imagePath = Bundle.main.path(forResource: "videoFirstFrame", ofType: "jpg")
let options = VideoOptions(pathToVideo: videoPath, pathToImage: imagePath, isMuted: true, shouldLoop: true)
let videoView = VideoBackground(frame: view.frame, options: options)
view.addSubview(videoView)
```

While video is loading image is displayed, when video is ready views crossfade. To try sample project run `pod try VideoBackground` in terminal



## Requirements

Swift 3

Compatible with `iOS 9+`

##Contribution

Found a bug? Please create an [issue](https://github.com/mruvim/VideoBackground/issues) </br>
Pull requests are welcome


## Contact

Ruvim Miksanskiy 
<a href="mailto:ruva@codingroup.com">![Email](http://codingroup.com/assets/external/email-icon.png)</a>

## License (MIT)

Copyright (c) 2017 -  Ruvim Miksanksiy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
