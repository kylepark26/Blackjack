function [DeckShuffled] = ShuffleDeck(~)
%This function creates a 1x52 vector DeckShuffled with random nonrepeating
%numbers between 21 and 72
DeckShuffled = randperm(52)+20;
end

