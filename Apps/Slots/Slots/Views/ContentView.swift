//
//  ContentView.swift
//  Slots
//
//  Created by Fabian Kuschke on 14.09.22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Properties
    
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    let haptics = UINotificationFeedbackGenerator()
    
    @State private var highscore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var reels: Array = [0, 1, 2]
    @State private var showingInfoView: Bool = false
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showingModal: Bool = false
    @State private var animatingSymbol: Bool = false
    @State private var animatingModal: Bool = false
    
    
    //MARK: Functions
    
    //Spin the reels
    func spinReels() {
        //reels[0] = Int.random(in: 0...symbols.count-1)
        //reels[1] = Int.random(in: 0...symbols.count-1)
        //reels[2] = Int.random(in: 0...symbols.count-1)
        reels = reels.map({ _ in // MARK: to learn map
            Int.random(in: 0...symbols.count - 1)
        })
    }
    //Check the winning
    func checkWinning(){
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[2] == reels[0] {
            //Player wins
            playerWins()
            //New Highscore
            if coins > highscore {
                newHighScore()
            }
        }else{
            //Player loses
            playerLoses()
        }
    }

    func playerWins(){
        coins += betAmount * 10
    }
    
    func newHighScore(){
        highscore = coins
        UserDefaults.standard.set(highscore, forKey: "HighScore")
    }
    
    func playerLoses(){
        coins -= betAmount
    }
    
    func activateBet20(){
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
    }
    func activateBet10(){
        betAmount = 10
        isActiveBet20 = false
        isActiveBet10 = true
    }
  
    //Game is over
    func isGameOver(){
        if coins <= 0 {
            showingModal = true
        }
    }
    
    func resetGame(){
        UserDefaults.standard.set(0, forKey: "HighScore")
        highscore = 0
        coins = 100
        activateBet10()
    }
    
    //MARK: Body
    var body: some View {
        ZStack {
            //MARK: Background
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            //MARK: Interface
            VStack(alignment: .center, spacing: 5) {
                //MARK: Header
                LogoView()
                Spacer()
                //MARK: Score
                HStack {
                    HStack{
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        Text("\(coins)")
                            .scoreNumberSytle()
                            .modifier(ScoreNumberModifier())
                        
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    HStack{
                        Text("\(highscore)")
                            .scoreNumberSytle()
                            .modifier(ScoreNumberModifier())
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    }
                    .modifier(ScoreContainerModifier())
                }
                //MARK: Slot machine
                VStack(alignment: .center, spacing: 0) {
                    //MARK: Reel 1
                    ZStack{
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    HStack(alignment: .center,spacing: 0) {
                        //MARK: Reel 2
                        ZStack{
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        Spacer()
                        
                        //MARK: Reel 3
                        ZStack{
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                    //MARK: Spin Button
                    Button {
                        //spin the reels
                        self.spinReels()
                        //check winning
                        self.checkWinning()
                        
                        //Game is Over
                        self.isGameOver()
                    } label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                }//Slot machine
                .layoutPriority(2)
                
                //MARK: Footer

                Spacer()
                HStack{
                    //MARK: Bet 20
                    HStack(alignment: .center, spacing: 10) {
                        Button {
                            self.activateBet20()
                        } label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet20 ? Color("ColorYellow") : .white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }
                    //MARK: Bet 10
                    HStack(alignment: .center, spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        Button {
                            self.activateBet10()
                        } label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet10 ? Color("ColorYellow") : .white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                        

                    }
                }
            }
            //MARK: Buttons
            .overlay(
                //Resete
                Button(action: {
                    self.resetGame()
                }) {
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                    .modifier(ButtonModifier()),
                alignment: .topLeading
            )
            .overlay(
                //Info
                Button(action: {
                    self.showingInfoView = true
                }) {
                    Image(systemName: "info.circle")
                }
                    .modifier(ButtonModifier()),
                alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
            //MARK: Popup
            if $showingModal.wrappedValue {
                ZStack{
                    Color(uiColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.7))
                        .edgesIgnoringSafeArea(.all)
                    
                    //Modal
                    VStack(spacing: 0) {
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        //Message
                        VStack(alignment: .center, spacing: 16) {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            Text("Bad luck! You lost all of the coins. \n Lets play again!")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            
                            Button (action: {
                                self.showingModal = false
                                self.coins = 100
                            }) {
                                Text("New Game")
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                            }
                            Spacer()
                        }
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                }
            }
        }//Zstack
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

//MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
