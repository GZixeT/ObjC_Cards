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
#define CARD_DECK_NUMBER 3
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
            switch(menuSwitcher)
            {
                case GameMenuBegin:{
                    [interface printCards];
                }break;
                case GameMenuOpenCard:{
                    int index=0;
                    printf("Введите номер карты:");
                    scanf("%d",&index);
                    if([cards makeTaskWhithCardAtIndex:index :true])
                    {
                        [interface printCards];
                        //NSLog(@"%d",[cards getGameState:index]);
                        switch([cards getGameState:index])
                        {
                            case GameStateFalse:
                                if([cards firstCard]!=-1 && [cards firstCard]!=index){
                                    [cards makeTaskWhithCardAtIndex:index :false];
                                    [cards makeTaskWhithCardAtIndex:[cards firstCard] :false];
                                    [cards setFirstCard:-1];
                                    [interface printCards];
                                }
                                else [cards setFirstCard:index];
                                break;
                            case GameStateEnd:
                                printf("Победа!\n");
                                break;
                            case GameStateError:
                                printf("Error.\n");
                                break;
                            case GameStateTrue:
                                [cards setFirstCard:-1];
                                break;
                            default:
                                printf("Error.\n");
                                break;
                        }
                    }//if
                    
                }break;
                    
                case GameMenuExit:
                return 0; // exit game cicle
                    
                default:
                    printf("Error.\n");
                    break;
            }//switch
        };
    }
    return 0;
}
