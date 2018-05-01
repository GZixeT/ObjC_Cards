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

typedef enum{
    GameTypeWithTable=1,
    GameTypeWithFirstCard
}GameType;



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int menuSwitcher;
        int menuGameType;
        GameConsoleInterface *interface=[[GameConsoleInterface alloc]init];
        Cards *cards=[Cards sharedInstance];
        [cards fillWithRandomCardsWithHeightAndNumber:HEIGHT CardDeckNumber:CARD_DECK_NUMBER];
        [cards initTableOfStates];
        printf("1.Начать игру через таблицу\n");
        printf("2.Начать игру через FirstCard\n");
        printf("Введите номер действия:");
        scanf("%d",&menuGameType);
        switch (menuGameType)
        {
            case GameTypeWithTable:
                [interface printCards];
                while(true){
                    printf("2.Открыть карту.\n");
                    printf("10.Выход.\n");
                    printf("Введите номер действия:");
                    scanf("%d",&menuSwitcher);
                    switch(menuSwitcher){
                        case GameMenuOpenCard:
                        {
                            int index=0;
                            printf("Введите номер карты:");
                            scanf("%d",&index);
                            if([cards makeTaskWithCardAtIndexInTableOfStates:index :true])
                            {
                                [interface printCards];
                                //NSLog(@"%d",[cards getGameState:index]);
                                switch([cards getGameStateWithTable])
                                {
                                    case GameStateFalse:
                                        [interface printCards];
                                        break;
                                    case GameStateEnd:
                                        printf("Победа!\n");
                                        break;
                                    case GameStateError:
                                        printf("Error.\n");
                                        break;
                                    case GameStateTrue:
                                        break;
                                    default:
                                        printf("Error.\n");
                                        break;
                                    }
                                }//if open==true
                            }break;//GameMenuOpenCard
                            case GameMenuExit:
                                return 0; // exit game cicle
                            default:
                                printf("Error.\n");
                                break;
                        }//menu switcher table
                    };break;
                case GameTypeWithFirstCard:
                [interface printCards];
                while(true){
                    printf("2.Открыть карту.\n");
                    printf("10.Выход.\n");
                    printf("Введите номер действия:");
                    scanf("%d",&menuSwitcher);
                    switch(menuSwitcher)
                    {
                        case GameMenuOpenCard:
                        {
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
                    }//switch first card
                };break;
            default:
                printf("Ошибка\n");
                break;
        }//game type switcher
    }
    return 0;
}
