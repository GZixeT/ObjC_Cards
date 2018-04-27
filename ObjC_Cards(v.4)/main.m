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

#define HEIGHT 3
#define CARD_DECK_NUMBER 6
typedef enum{
    GameMenuBegin=1,
    GameMenuOpenCard,
    GameMenuExit=10
} GameMenu;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int menuSwitcher;
        GameConsoleInterface *interface=[[GameConsoleInterface alloc]init];
        Cards *cards=[Cards sharedInstance];
        [cards fillWithRandomCardsWithHeightAndNumber:HEIGHT CardDeckNumber:CARD_DECK_NUMBER];
        while(TRUE){
            printf("1.Начать игру.\n");
            printf("2.Открыть карту.\n");
            printf("10.Выход.\n");
            printf("Введите номер действия:");
            scanf("%d",&menuSwitcher);
            switch(menuSwitcher){
                case GameMenuBegin:{
                    [interface printCards];
                }break;
                case GameMenuOpenCard:{
                    int number=0;
                    printf("Введите номер карты:");
                    scanf("%d",&number);
                    [cards makeTaskWhithCardAtIndex:number :true];
                    [interface printCards];
                    switch([cards getGameState]){
                        case GameStateTwoCardsOpen:{
                           
                        }break;
                        case GameStateEnd:
                            printf("Победа!\n");
                            break;
                        case GameStateError:
                            printf("Error.\n");
                            break;
                        default:
                            printf("Error.\n");
                            break;
                    }
                }break;
                    
                case GameMenuExit:
                return 0; // exit game cicle
                    
                default:
                    printf("Error.\n");
                    break;
            }
        };
    }
    return 0;
}
