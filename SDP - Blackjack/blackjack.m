%blackjack !

clc
clear
close all

%Initalize Variables Necessary

dealerPoints = 0;
playerPoints = 0;
cardNum = 1;
counter = 2;
% This corresponds the retrocards image to the cards 'points' in blackjack,
% For simplicity we count aces as 1 always.
cardValue = [0:19,1:10,10,10,10,1:10,10,10,10,1:10,10,10,10,1:10,10,10,10];

%Starting Screen

starting_scene = simpleGameEngine('retro_cards.png', 16,16,6);
background = [21,22,23,24,25,26; 27,28,29,30,31,32];
drawScene(starting_scene, background)

%Prompt User with "Welcome to Blackjack"

fprintf('---WELCOME TO BLACKJACK---\n')
fprintf('Click anywhere to continue.\n')
fprintf('Card Values: Aces are 1, King - Queen - Jack are 10. The number cards are their respective values.\n')

%Create code that allows user to click anywhere to transition into actual playing screen.

[r,c] = getMouseInput(starting_scene);

if (r < 100 && c < 100)
    game_scene = simpleGameEngine('retro_cards.png', 16,16,6, [30,150,30]);
    game_background = [1,1,1,3,1,1,1; 1,1,1,1,1,1,1,; 1,1,1,3,1,1,1];
    drawScene(game_scene,game_background);
end

fprintf('The user''s card is the lower card. The card to the left is the deck.\n');

%Prompt the user to click the card to reveal their card

DeckShuffled = ShuffleDeck();
[r,c] = getMouseInput(game_scene);
x = DeckShuffled(1);

if (r == 3 && c ==4)
    game_background = [3,1,1,1,1,1,1; 1,1,1,1,1,1,1; x,1,1,1,1,1,1];
    drawScene(game_scene, game_background);
else
    fprintf('Hit the card!')

end

%ACTUAL GAME

while 1

    cardNum = cardNum+2;
   
    
    %Prompt the user if they want to hit or stand

    fprintf('\nClick the Y key if you want to hit, click the N key if you want to stand. \n');
        
    %Create if statements based off of user's input

    userInput = getKeyboardInput(game_scene);
    y = DeckShuffled(cardNum);

    if userInput == 'y'
        game_background(3,1) = x;
        game_background(3,counter) = DeckShuffled(cardNum);
        drawScene(game_scene, game_background);
    end
    playerValue = cardValue(game_background(3,:));
    playerPoints = sum(playerValue);

    % If the dealers cards add up to less than 17, it will hit until the
% cards value 17 or above and then stand.
    if dealerPoints < 17
        game_background(1,counter-1) = DeckShuffled(cardNum+5);
        drawScene(game_scene,game_background)
        dealerValue = cardValue(game_background(1,:));
        dealerPoints = sum(dealerValue);
        if dealerPoints > 21
            pause(2)
            game_scene = simpleGameEngine('text.png', 16,16,6, [30,150,30]);
        game_background = [81,81,25,15,21,81,81; 81,81,23,9,14,27,81,; 30,29,30,29,30,29,30];
        drawScene(game_scene,game_background);
        end
    end

% Stop the loop if the user stands
    if userInput == 'n'
        break
    end

    % Immediately lose if you go over 21 points

    if playerPoints > 21
        pause(2)
        game_scene = simpleGameEngine('text.png', 16,16,6, [30,150,30]);
        game_background = [81,81,25,15,21,81,81; 81,12,15,19,5,27,81,; 30,29,30,29,30,29,30];
        drawScene(game_scene,game_background);
        break
    end

    % Immediate win if you get exactly 21 points
    if playerPoints == 21
        pause(2)
        game_scene = simpleGameEngine('text.png', 16,16,6, [30,150,30]);
        game_background = [81,81,25,15,21,81,81; 81,81,23,9,14,27,81,; 30,29,30,29,30,29,30];
        drawScene(game_scene,game_background);
        break
    end
    counter = counter + 1;

end


% You win if both you and the dealer stand and you have more points than
% the dealer
if playerPoints < 21
        if playerPoints > dealerPoints && dealerPoints < 21
            pause(2)
            game_scene = simpleGameEngine('text.png', 16,16,6, [30,150,30]);
        game_background = [81,81,25,15 ,21,81,81; 81,81,23,9,14,27,81,; 30,29,30,29,30,29,30];
        drawScene(game_scene,game_background);
        end
end

% You lose if both you and the dealer stand and you have less points than
% the dealer
if playerPoints < 21
    if playerPoints < dealerPoints && dealerPoints < 21
        pause(2)
        game_scene = simpleGameEngine('text.png', 16,16,6, [30,150,30]);
        game_background = [81,81,25,15,21,81,81; 81,12,15,19,5,27,81,; 30,29,30,29,30,29,30];
        drawScene(game_scene,game_background);
    end
end

% Special scenario for tied game
if playerPoints < 21
    if playerPoints == dealerPoints
        pause(2)
          game_scene = simpleGameEngine('text.png', 16,16,6, [30,150,30]);
        game_background = [81,81,25,15,21,81,81; 81,81,23,9,14,27,81,; 30,29,30,29,30,29,30];
        drawScene(game_scene,game_background);
        fprintf('You tied with the dealer! Good job!!')
    end
end







