//
//  main.m
//  ObjC_Cards(v.3)
//
//  Created by Георгий Зубков on 19.04.2018.
//  Copyright © 2018 Георгий Зубков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameConsoleInterface.h"
#import "Card.h"

#define WIGHT 3
#define HEIGHT 3
#define EXIT_COMMAND 10

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        GameConsoleInterface *interface=[[GameConsoleInterface alloc]init];
        Cards *cards=[Cards sharedInstance];
        [cards fillWithRandomCardsWithCapasityHeight:WIGHT Widht:HEIGHT];
        int k=EXIT_COMMAND;
        while(TRUE){
            printf("1.Начать игру.\n");
            printf("2.Открыть карту.\n");
            printf("10.Выход.\n");
            printf("Введите номер действия:");
            scanf("%d",&k);
            switch(k){
                case 1:{
                    [interface printCards:cards];
                }break;
                case 2:{
                    int number=0;
                    printf("Введите номер карты:");
                    scanf("%d",&number);
                    [cards openCard:number :true];
                    [interface printCards:cards];
                    switch([cards getGameState]){
                        case GameStateTwoCardsOpen:{
                            Card *first=[[cards map]getMapElementWithIndext:[cards firstCardOpen]];
                            Card *second=[[cards map]getMapElementWithIndext:[cards secondCardOpen]];
                            if(![first isEqual:second]){
                                [cards openCard:[cards firstCardOpen] :false];
                                [cards openCard:[cards secondCardOpen] :false];
                                [interface printCards:cards];
                            }
                            [cards setFirstCardOpen:GameStateCloseFirstCard];
                            [cards setSecondCardOpen:GameStateCloseFirstCard];
                        }break;
                        case GameStateEnd:
                            printf("Победа!\n");
                            break;
                        case GameStateError:
                            printf("Error.\n");
                    }
                }break;
                    
                case EXIT_COMMAND:
                return 0; // exit game cicle
            }
        };
    }
    return 0;
}
