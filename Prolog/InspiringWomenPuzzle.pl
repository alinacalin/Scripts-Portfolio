%Using Prolog to solve puzzles similar to eistain's 5 houses problem (or zebra puzzles).
%https://www.brainzilla.com/logic/zebra/inspiring-women/

%Five girls are side by side talking about their inspirations. 
%Each girl has a woman in their family that they consider a role model. 
%Follow the clues to find out which girl was inspired by her sister.

/*
	1.Jessie is exactly to the left of the girl that wants to become a Nurse.
	2.At the second position is the girl inspired by her Grandmother.
	3.Sabrina is 10 years old.
	4.Amy is next to the girl inspired by her Grandmother.
	5.The girl wearing the Green shirt is exactly to the left of the girl inspired by her Mother.
	6.The girl inspired by her Mother likes Grapefruit juice.
	7.The girl wearing the Red shirt is somewhere between the girl who likes Lemon juice and Amy, in that order.
	8.The girl that likes Pineapple juice is somewhere to the right of the girl wearing the Red shirt.
	9.The youngest girl is next to the girl who likes Orange juice.
	10.The girl inspired by her Cousin is exactly to the left of the girl wearing the Red shirt.
	11.The oldest girl is next to the girl wearing the Blue shirt.
	12.At one of the ends is the girl that likes Cranberry juice.
	13.The girl inspired by her Aunt is exactly to the right of the 11-year-old girl.
	14.Lindy is 11 years old.
	15.The 10-year-old girl is exactly to the right of the 8-year-old girl.
	16.The girl that wants to become a Nurse was inspired by her Grandmother.
	17.The girl wearing the Red shirt is somewhere between the girl that likes Lemon juice and the girl wearing the Yellow shirt, in that order.
	18.At the fifth position is the girl who wants to become a Writer.
	19.Lindy is exactly to the right of the 9-year-old girl.
	20.The girl that likes Pineapple juice is next to the girl that wants to become a Teacher.
	21.At the third position is the girl who wants to be a Journalist.
	22.The youngest girl is exactly to the right of Lindy.
*/
:- use_rendering(table,
		 [header(girl('Shirt','Name','Profession','Inspiration','Age','Juice' ))]).

nextToLeft(A, B, Ls) :- append(_, [A,B|_], Ls).

nextTo(A,B, Ls):-append(_,[B,A|_], Ls).
nextTo(A,B, Ls):-append(_,[A,B|_], Ls).

atAnyEnd(A, Ls):- Ls=[A|_].
atAnyEnd(A, Ls):- Ls=[_,_,_,_,A].
    
somewhereLeft(A,B, Ls):- append(_, [A, B|_], Ls).
somewhereLeft(A,B, Ls):- append(_, [A,_, B|_], Ls).
somewhereLeft(A,B, Ls):- append(_, [A,_,_, B|_], Ls).
somewhereLeft(A,B, Ls):- append(_, [A,_,_,_, B|_], Ls).

somewhereBetween(A, B, C, Ls):- somewhereLeft(A, B, Ls), somewhereLeft(B,C, Ls).

  

girls(Girls) :-
	% each girl in the group is represented as:
	%      girl('Shirt','Name','Profession','Inspiration','Age','Juice')
	length(Girls, 5),                                            
    nextToLeft(girl(_,jessie,_,_,_,_), girl(_,_,nurse,_,_,_), Girls),                               %  1
    Girls=[_,girl(_,_,_,gma,_,_),_,_,_],                                                            %  2
    member(girl(_,sabrina,_,_, 10,_), Girls),                                                       %  3
    nextTo(girl(_,amy,_,_,_,_), girl(_,_,_,gma,_,_), Girls),                                        %  4
    nextToLeft(girl(green,_,_,_,_,_), girl(_,_,_,mother,_,grapefruit), Girls),                      %  5, 6
    Youngest=girl(_,_,_,_,8,_),
    nextTo(Youngest, girl(_,_,_,_,_,orange), Girls),                                                %  9
    nextToLeft(girl(_,_,_, cousin,_,_), girl(red, _,_,_,_,_), Girls),                               % 10
    Oldest=girl(_,_,_,_,12,_),
    nextTo(Oldest, girl(blue, _,_,_,_,_), Girls),                                                   % 11
    atAnyEnd(girl(_,_,_,_,_,cranberry), Girls),                                                     % 12
    nextToLeft(girl(_,lindy,_,_,11,_), girl(_,_,_,aunt,_,_), Girls),                                % 13, 14 
    nextToLeft(girl(_,_,_,_,8,_), girl(_,_,_,_,10,_), Girls),                                       % 15
    member(girl(_,_,nurse,gma,_,_), Girls),                                                         % 16
    Girls=[_,_,_,_,girl(_,_,writer,_,_,_)],                                                         % 18
    nextToLeft(girl(_,_,_,_,9,_), girl(_,lindy,_,_,_,_), Girls),                                    % 19
    nextTo(girl(_,_,_,_,_,pineapple), girl(_,_,teacher,_,_,_), Girls),                              % 20
    Girls=[_,_,girl(_,_,journalist,_,_,_),_,_],                                                     % 21
    nextToLeft(girl(_, lindy,_,_,_,_), Youngest, Girls),                                            % 22
    somewhereBetween(girl(_,_,_,_,_,lemon), girl(red, _,_,_,_,_), girl(yellow,_, _,_,_,_), Girls),  % 17
    somewhereBetween(girl(_,_,_,_,_,lemon), girl(red, _,_,_,_,_), girl(_,amy, _,_,_,_), Girls),     %  7
    somewhereLeft(girl(red, _,_,_,_,_), girl(_,_,_,_,_, pineapple), Girls),                         %  8
    member(girl(white,_,_,_,_,_), Girls),	                                                    % one girl has a white shirt
    member(girl(_,helen,_,_,_,_), Girls),	                                                    % one is called Helen
    member(girl(_,_,engineer,_,_,_), Girls),	                                                    % one of them is engineer
    member(girl(_,_,_,sister,_,_), Girls).		                                            % one of them is inspired by her sister


sister_inspired(Girl) :-
	girls(GirlsList),
	member(girl(_,Girl,_,sister,_,_), GirlsList),!.

/*
Examples:

girls(G).
G = [girl(white,jessie,engineer,cousin,9,lemon), 
     girl(red,lindy,nurse,gma,11,orange), 
     girl(green,amy,journalist,aunt,8,pineapple), 
     girl(blue,sabrina,teacher,mother,10,grapefruit), 
     girl(yellow,helen,writer,sister,12,cranberry)]

sister_inspired(Girl).
Girl = helen

*/
