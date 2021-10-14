/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct MemoryView: View {
    @Binding var memory: Double
    var geometry: GeometryProxy
    
    var body: some View {
        
        let memorySwipe = DragGesture(minimumDistance: 20)
            .onEnded { _ in
                memory = 0.0
            }
        
        let doubleTap = TapGesture(count: 2)
            .onEnded { _ in
                memory = 0.0
            }
        
        HStack {
            Spacer()
#if targetEnvironment(macCatalyst)
            DisplayTextView(text: memory, geometry: geometry)
                .gesture(doubleTap)
#else
            DisplayTextView(text: memory, geometry: geometry)
                .gesture(memorySwipe)
#endif
            
            Text("M")
        }.padding(.bottom).padding(.horizontal, 5)
    }
}

struct DisplayTextView: View {
    let text: Double
    var geometry: GeometryProxy
    var body: some View {
        Text("\(text)")
            .accessibility(identifier: "memoryDisplay")
            .padding(.horizontal, 5)
            .frame(
                width: geometry.size.width * 0.85,
                alignment: .trailing
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color.gray)
            )
    }
}
