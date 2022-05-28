% name surname
% studentid
% compiling: no
% complete: no
:- ['cmpecraft.pro'].

:- init_from_map.

% 10 points
manhattan_distance([A|[B]], [C|[D]], Distance) :-
    Distance is abs(A-C)+abs(B-D).
% 10 points
minimum_of_list(List, Minimum) :-
    min_list(List,Minimum).
% 10 points
find_x_type(State,Typee,Bag):-
    State=[A,O,T],
    findall(Obj,
            (get_dict(_,O,Obj)
                ,get_dict(type,Obj,Typee)),
            Bag).

adder([],NewOut,NewOut,CurrentLocation).

adder([H|T],Inlist,NewOut,CurrentLocation):-
    get_dict(x, H, XVal),
	get_dict(y, H, YVal),
	manhattan_distance([XVal|[YVal]],CurrentLocation,ManhattanDistance),
   	append([ManhattanDistance],Inlist,Outlist),
    adder(T, Outlist, NewOut,CurrentLocation).


shortest(Bag,CurrentLocation,MinimumLength):-
    adder(Bag,[],FinalList,CurrentLocation),
    minimum_of_list(FinalList,MinimumLength).
    
   
    

manhattanchecker(State,Distans, MainX,MainY,Hedefobje,Objegenre):-
    State=[A,O,T],
    findall(Obj,
            (get_dict(_,O,Obj),
                get_dict(x,Obj,Xeks),
                get_dict(y,Obj,Yeks),
                manhattan_distance([Xeks|[Yeks]],[MainX,[MainY]],ManhattanDist),
                get_dict(type,Obj,Objecinsi),
                Objegenre = Objecinsi,
            	ManhattanDist = Distans),
            Hedefobje).   

objeChecker(State,ArananObj,Keylistesi):-
    State=[A,O,T],
    findall(Keydegeri,
            get_dict(Keydegeri,O,ArananObj),Keylistesi). 

    
find_nearest_type(State, ObjectType, ObjKey, Object, Distance) :- 
    State= [A,O,T],
    get_dict(x, A, Xloc),    
    get_dict(y, A, Yloc),

    find_x_type(State,ObjectType,Bag),
	shortest(Bag,[Xloc,[Yloc]],Distans),
	manhattanchecker(State,Distans,Xloc,Yloc,[Object|Son],ObjectType),
	objeChecker(State, Object,[M|K]),
    Distance is Distans,
    ObjKey is M.

% 10 points
navigate_to(State,X, Y, ActionList, DepthLimit) :- 

    

    State = [Myagentdict,Myobjectdict,Mytime], 
    get_dict(x,Myagentdict,CurrentXlocation), 
    get_dict(y,Myagentdict,CurrentYlocation), 
    
    Xdiff is X - CurrentXlocation, 
    Ydiff is Y - CurrentYlocation,


    %Xdiff is X - 5,
    %Ydiff is Y - 6, 
    %print_state(State),
    q4DeciderUPDOWN(Ydiff,K),
    q4DeciderLEFTRIGHT(Xdiff,L),
    append(K,L,SonListe),
    length(SonListe, LengAction),

    not(LengAction>DepthLimit),
    append(K,L,ActionList).
    
    
q4DeciderUPDOWN(Ydiff,Listout):- 
    addGoDown(Ydiff,[],Listout).

q4DeciderUPDOWN(Ydiff,Listout):- 
    addGoUp(Ydiff,[],Listout).

q4DeciderLEFTRIGHT(Xdiff,Listout):-
    addGoLeft(Xdiff,[],Listout).

q4DeciderLEFTRIGHT(Xdiff,Listout):-
    addGoRight(Xdiff,[],Listout).
     


addGoDown(0,Liste,Liste).

addGoDown(Ydifference,Liste,Outlist):-
    Ydifference>0,
    append(Liste,[go_down],ListeDevam),
    NewYdiff is Ydifference-1,
    addGoDown(NewYdiff,ListeDevam,Outlist).


addGoUp(0,Liste,Liste).

addGoUp(Ydifference,Liste,Outlist):-
    Ydifference<0,
    append(Liste,[go_up],ListeDevam),
    NewYdiff is Ydifference+1,
    addGoUp(NewYdiff,ListeDevam,Outlist).



addGoRight(0,Liste,Liste).

addGoRight(Xdifference,Liste,Outlist):-
    Xdifference>0,
    append(Liste,[go_right],ListeDevam),
    NewYdiff is Xdifference-1,
    addGoRight(NewYdiff,ListeDevam,Outlist).


addGoLeft(0,Liste,Liste).

addGoLeft(Xdifference,Liste,Outlist):-
    Xdifference<0,
    append(Liste,[go_left],ListeDevam),
    NewYdiff is Xdifference+1,
    addGoLeft(NewYdiff,ListeDevam,Outlist).


% 10 points
chop_nearest_tree(State, ActionList) :- 
    State = [A,O,T],

    find_nearest_type(State,tree,ObjKey,Object,Distance),
    
    get_dict(x,Object,TargetXlocation), 
    get_dict(y,Object,TargetYlocation), 

    
    navigate_to(State,TargetXlocation,TargetYlocation,B1,Distance),
    

    append(B1,[left_click_c],B2),
    append(B2,[left_click_c],B3),
    append(B3,[left_click_c],B4),
    append(B4,[left_click_c],ActionList).

   
    
    
    % 10 points
mine_nearest_stone(State, ActionList) :- 
    State = [A,O,T],

    find_nearest_type(State,stone,ObjKey,Object,Distance),
    
    get_dict(x,Object,TargetXlocation), 
    get_dict(y,Object,TargetYlocation), 

    
    navigate_to(State,TargetXlocation,TargetYlocation,B1,Distance),
    

    append(B1,[left_click_c],B2),
    append(B2,[left_click_c],B3),
    append(B3,[left_click_c],B4),
    append(B4,[left_click_c],ActionList).



mine_nearest_cobblestone(State, ActionList) :- 
    State = [A,O,T],

    find_nearest_type(State,cobblestone,ObjKey,Object,Distance),
    
    get_dict(x,Object,TargetXlocation), 
    get_dict(y,Object,TargetYlocation), 

    
    navigate_to(State,TargetXlocation,TargetYlocation,B1,Distance),
    write("be11111:   "),
    write(B1),
    nl,
    append(B1,[left_click_c],B2),
    append(B2,[left_click_c],B3),
    append(B3,[left_click_c],B4),
    append(B4,[left_click_c],ActionList).





    % 10 points
gather_nearest_food(State, ActionList) :- 
    State = [A,O,T],

    find_nearest_type(State,food,ObjKey,Object,Distance),
    
    get_dict(x,Object,TargetXlocation), 
    get_dict(y,Object,TargetYlocation), 

    
    navigate_to(State,TargetXlocation,TargetYlocation,B1,Distance),
    

    append(B1,[left_click_c],ActionList).
    
    
    % 10 points
%required(urun_ismi, logsayisineeded, sticksayisineeded, cobblestonesayisineeded).
required().
required(stick, 2,0,0).
required(stone_pickaxe, 3,2,3).
required(stone_axe, 3,2,3).


collect_requirements(State, ItemType, ActionList) :- 
    State = [A,O,T],
    get_dict(inventory, A, InventoryOfA),
    collect_subfunc(State,ItemType,InventoryOfA,ActionList).
    







%%%%%%%%%%%%%%COBBLESTONE A GEREK YOK

% PICKAXE  STICK LAZIM  AGAC KESME
collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    print("sUBFUNCTION 1 calisti"),
    member(ItemType,[stone_axe,stone_pickaxe]),
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stone_pickaxe,LogReq,StickReq,TotalCobblestoneNeeded),

    NetCobblestoneNeeded is TotalCobblestoneNeeded - CobblestoneInv,
    NetLogNeeded is LogReq-LogInv,
    NetStickNeeded is StickReq-StickInv,

    NetStickNeeded>0,
    NetLogNeedednew is NetLogNeeded +2,

    NetLogNeedednew<1,
    NetCobblestoneNeeded<1,

    Boslist = [],
    append(Boslist, [craft_stick], ActionList),!.





% PICKAXE  STICK LAZIM  1 AGAC KES
collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    print("sUBFUNCTION 2 calisti"),

    member(ItemType,[stone_axe,stone_pickaxe]),
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stone_pickaxe,LogReq,StickReq,TotalCobblestoneNeeded),

    NetCobblestoneNeeded is TotalCobblestoneNeeded - CobblestoneInv,
    NetLogNeeded is LogReq-LogInv,
    NetStickNeeded is StickReq-StickInv,

    NetStickNeeded>0,
    NetLogNeedednew is NetLogNeeded +2,

    NetLogNeedednew>0,
    NetLogNeedednew<4,

    NetCobblestoneNeeded<1,

    Boslist = [],
    chop_nearest_tree(State,TreeList),
    append(TreeList, [craft_stick], ActionList),!.
    


% PICKAXE STICK LAZIM 2 AGAC KES
collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    print("sUBFUNCTION 3 calisti"),

    member(ItemType,[stone_axe,stone_pickaxe]),
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stone_pickaxe,LogReq,StickReq,TotalCobblestoneNeeded),

    NetCobblestoneNeeded is TotalCobblestoneNeeded - CobblestoneInv,
    NetLogNeeded is LogReq-LogInv,
    NetStickNeeded is StickReq-StickInv,

    NetStickNeeded>0,
    NetLogNeedednew is NetLogNeeded +2,

    NetLogNeedednew>3,
    NetCobblestoneNeeded<1,

    Boslist = [],
    chop_nearest_tree(State,TreeList),
    execute_actions(State,TreeList,FinalStatee),
    chop_nearest_tree(FinalStatee,NextTreeList),
    append(TreeList,NextTreeList,FinalList),
    append(FinalList, [craft_stick], ActionList),!.


% PICKAXE   STICK LAZIM DEGIL AGAC KESME
collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    print("sUBFUNCTION 4 calisti"),

    member(ItemType,[stone_axe,stone_pickaxe]),
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stone_pickaxe,LogReq,StickReq,TotalCobblestoneNeeded),

    NetCobblestoneNeeded is TotalCobblestoneNeeded - CobblestoneInv,
    NetLogNeeded is LogReq-LogInv,
    NetStickNeeded is StickReq-StickInv,

    NetStickNeeded<1,
    NetLogNeedednew is NetLogNeeded,

    NetLogNeedednew<1,
    NetCobblestoneNeeded<1,

    Boslist = [],
    append(Boslist, [], ActionList),!.





% PICKAXE   STICK LAZIM DEGIL 1 AGAC KES
collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    print("sUBFUNCTION 5 calisti"),

    member(ItemType,[stone_axe,stone_pickaxe]),
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stone_pickaxe,LogReq,StickReq,TotalCobblestoneNeeded),

    NetCobblestoneNeeded is TotalCobblestoneNeeded - CobblestoneInv,
    NetLogNeeded is LogReq-LogInv,
    NetStickNeeded is StickReq-StickInv,

    NetStickNeeded<1,
    NetLogNeedednew is NetLogNeeded,

    NetLogNeedednew>0,
    NetLogNeedednew<4,

    NetCobblestoneNeeded<1,

    Boslist = [],
    chop_nearest_tree(State,TreeListeo),
    append(TreeListeo, [],ActionList),!.
    
    



% PICKAXE  STICK LAZIM DEGIL 2 AGAC KES
collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    print("sUBFUNCTION 6 calisti"),

    member(ItemType,[stone_axe,stone_pickaxe]),
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stone_pickaxe,LogReq,StickReq,TotalCobblestoneNeeded),

    NetCobblestoneNeeded is TotalCobblestoneNeeded - CobblestoneInv,
    NetLogNeeded is LogReq-LogInv,
    NetStickNeeded is StickReq-StickInv,

    NetStickNeeded<1,
    NetLogNeedednew is NetLogNeeded,

    NetLogNeedednew>3,
    NetCobblestoneNeeded<1,

    Boslist = [],
    chop_nearest_tree(State,TreeList),
    execute_actions(State,TreeList,FinalStatee),
    chop_nearest_tree(FinalStatee,NextTreeList),
    append(TreeList,NextTreeList,Losfinalos),
    append(Losfinalos,[],ActionList),!.







%%%%%%%%%%%%%%%%%%%%%COBBLESTONE LAZIM

% PICKAXE  STICK LAZIM  AGAC KESME
collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    print("sUBFUNCTION 7 calisti"),

    member(ItemType,[stone_axe,stone_pickaxe]),
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stone_pickaxe,LogReq,StickReq,TotalCobblestoneNeeded),

    NetCobblestoneNeeded is TotalCobblestoneNeeded - CobblestoneInv,
    NetLogNeeded is LogReq-LogInv,
    NetStickNeeded is StickReq-StickInv,

    NetStickNeeded>0,
    NetLogNeedednew is NetLogNeeded +2,

    NetLogNeedednew<1,
    NetCobblestoneNeeded>0,

    Boslist = [],
    mine_nearest_stone(State,StoneListt), 
    append(Boslist,StoneListt,Listedos),
    append(Listedos,[craft_stick],ActionList),!.





% PICKAXE  STICK LAZIM  1 AGAC KES
collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    print("sUBFUNCTION 8 calisti"),

    member(ItemType,[stone_axe,stone_pickaxe]),
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stone_pickaxe,LogReq,StickReq,TotalCobblestoneNeeded),

    NetCobblestoneNeeded is TotalCobblestoneNeeded - CobblestoneInv,
    NetLogNeeded is LogReq-LogInv,
    NetStickNeeded is StickReq-StickInv,
    write("netlOG"),
    write(NetLogNeeded),
    NetStickNeeded>0,
    NetLogNeedednew is NetLogNeeded +2,
    write("netlOGNEWWW"),
    write(NetLogNeedednew),

    NetLogNeedednew>0,
    NetLogNeedednew<4,

    NetCobblestoneNeeded>0,

    Boslist = [],
    chop_nearest_tree(State,TreeList),
    execute_actions(State,TreeList,FinalStatee),
    print("camon"),
    mine_nearest_stone(FinalStatee,StoneListt),
    append(TreeList,StoneListt,Listedos),
    append(Listedos,[],ActionList).

    


% PICKAXE STICK LAZIM 2 AGAC KES
collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    print("sUBFUNCTION 9 calisti"),

    member(ItemType,[stone_axe,stone_pickaxe]),
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stone_pickaxe,LogReq,StickReq,TotalCobblestoneNeeded),

    NetCobblestoneNeeded is TotalCobblestoneNeeded - CobblestoneInv,
    NetLogNeeded is LogReq-LogInv,
    NetStickNeeded is StickReq-StickInv,

    NetStickNeeded>0,
    NetLogNeedednew is NetLogNeeded +2,

    NetLogNeedednew>3,
    NetCobblestoneNeeded>0,

    Boslist = [],
    chop_nearest_tree(State,TreeList),
    execute_actions(State,TreeList,FinalStatee),
    chop_nearest_tree(FinalStatee,NextTreeList),
    execute_actions(FinalStatee,NextTreeList,LastFinalState),
    mine_nearest_stone(LastFinalState,StoneListt),
    append(TreeList,NextTreeList,Listeuno),
    append(Listeuno,StoneListt,Listedos),
    append(Listedos,[craft_stick],ActionList),!.


% PICKAXE   STICK LAZIM DEGIL AGAC KESME
collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    print("sUBFUNCTION 10 calisti"),

    member(ItemType,[stone_axe,stone_pickaxe]),
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stone_pickaxe,LogReq,StickReq,TotalCobblestoneNeeded),

    NetCobblestoneNeeded is TotalCobblestoneNeeded - CobblestoneInv,
    NetLogNeeded is LogReq-LogInv,
    NetStickNeeded is StickReq-StickInv,

    NetStickNeeded<1,
    NetLogNeedednew is NetLogNeeded,

    NetLogNeedednew<1,
    NetCobblestoneNeeded>0,

    Boslist = [],
    mine_nearest_stone(LastFinalState,StoneListt),
    append(StoneListt,[],ActionList),!.






% PICKAXE   STICK LAZIM DEGIL 1 AGAC KES
collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    print("sUBFUNCTION 11 calisti"),

    member(ItemType,[stone_axe,stone_pickaxe]),
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stone_pickaxe,LogReq,StickReq,TotalCobblestoneNeeded),

    NetCobblestoneNeeded is TotalCobblestoneNeeded - CobblestoneInv,
    NetLogNeeded is LogReq-LogInv,
    NetStickNeeded is StickReq-StickInv,

    NetStickNeeded<1,
    NetLogNeedednew is NetLogNeeded,

    NetLogNeedednew>0,
    NetLogNeedednew<4,

    NetCobblestoneNeeded>0,

    Boslist = [],
    chop_nearest_tree(State,TreeList),
    execute_actions(State,TreeList,FinalStatee),
    mine_nearest_stone(FinalStatee,StoneListt),
    append(TreeList,StoneListt,Treeplusstone),
    append(Treeplusstone,[],ActionList),!.



% PICKAXE  STICK LAZIM DEGIL 2 AGAC KES
collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    print("sUBFUNCTION 12 calisti"),

    member(ItemType,[stone_axe,stone_pickaxe]),
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stone_pickaxe,LogReq,StickReq,TotalCobblestoneNeeded),

    NetCobblestoneNeeded is TotalCobblestoneNeeded - CobblestoneInv,
    NetLogNeeded is LogReq-LogInv,
    NetStickNeeded is StickReq-StickInv,

    NetStickNeeded<1,
    NetLogNeedednew is NetLogNeeded,

    NetLogNeedednew>3,
    NetCobblestoneNeeded>0,

    Boslist = [],
    chop_nearest_tree(State,TreeList),
    execute_actions(State,TreeList,FinalStatee),
    chop_nearest_tree(FinalStatee,NextTreeList),
    execute_actions(FinalStatee,NextTreeList,LastFinalState),
    mine_nearest_stone(LastFinalState,StoneListt, EndState),
    append(TreeList,NextTreeList,Listeuno),
    append(Listeuno,StoneListt,Treeplusstone),
    append(Treeplusstone,[],ActionList),!.





















% STICK

collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    Itemtype= stick,
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stick,LogRequired,StickRequired,TotalCobblestoneRequired),
    LogNeeded is LogRequired - LogInv,
    LogNeeded>0,
    Boslist = [],
    chop_nearest_tree(State, LogList),
    append(LogList, Boslist, ActionList),!.

collect_subfunc(State,Itemtype,InventoryOfA,ActionList):-
    Itemtype= stick,
    return_inventory(InventoryOfA,LogInv,StickInv,CobblestoneInv),
    required(stick,LogRequired,StickRequired,TotalCobblestoneRequired),
    LogNeeded is LogRequired - LogInv,
    Boslist = [],
    append(Boslist, Boslist, ActionList).


%collect_subfunc(Itemtype,ActionList):-
    %Itemtype= stick,
    %chop_nearest_tree(State,Actionuno),
   % chop_nearest_tree(State,Actiondos),
  %  required(Itemtype,AmountList).





return_inventory(Inventory,Log,Stick,Cobblestone):-
    get_dict(log,Inventory,Log),
    get_dict(stick,Inventory,Stick),
    get_dict(cobblestone,Inventory,Cobblestone),!.


return_inventory(Inventory,Log,Stick,Cobblestone):-
    get_dict(log,Inventory,Log),
    get_dict(stick,Inventory,Stick),
    Cobblestone is 0,!.

return_inventory(Inventory,Log,Stick,Cobblestone):-
    get_dict(log,Inventory,Log),
    get_dict(cobblestone,Inventory,Cobblestone),
    Stick is 0,!.

return_inventory(Inventory,Log,Stick,Cobblestone):-
    get_dict(stick,Inventory,Stick),
    get_dict(cobblestone,Inventory,Cobblestone),
    Log is 0,!.

return_inventory(Inventory,Log,Stick,Cobblestone):-
    get_dict(log,Inventory,Log),
    Stick is 0, Cobblestone is 0,!.

return_inventory(Inventory,Log,Stick,Cobblestone):-
    get_dict(stick,Inventory,Stick),
    Log is 0, Cobblestone is 0,!.


return_inventory(Inventory,Log,Stick,Cobblestone):-
    get_dict(cobblestone,Inventory,Cobblestone),
    Log is 0, Stick is 0,!.


return_inventory(Inventory,0,0,0).






% 5 points

finish(Xleng,Yleng,State,FinalList):-
    Xval is Xleng-2,
    Yval is Yleng-2,
	findall(K, between(1, Xval, K), Ks),
	findall(L, between(1, Yval, L), Ls),
    

    findall([H,Bas],( member(H, Ks),member(Bas, Ls),isAvailable(H,Bas,State,Lst)),FinalList).
  


isAvailable(X,Y,State,BlockingList):-
  	findall([X,Y], (    X1 is X+1,
						X2 is X+2,
                        Y1 is Y+1,
                        Y2 is Y+2,     
					 	not(tile_occupiednew(X,Y,State)),
                        not(tile_occupiednew(X1,Y,State)),
                        not(tile_occupiednew(X2,Y,State)),
						not(tile_occupiednew(X,Y1,State)),
                        not(tile_occupiednew(X1,Y1,State)),
                        not(tile_occupiednew(X2,Y1,State)),
                        not(tile_occupiednew(X,Y2,State)),
                        not(tile_occupiednew(X1,Y2,State)),
                        not(tile_occupiednew(X2,Y2,State))),BlockingList),
    length(BlockingList, Length),
    Length>0.


tile_occupiednew(X, Y, State) :-
    State = [_, StateDict, _],
    get_dict(_, StateDict, Object),
    get_dict(x, Object, Ox),
    get_dict(y, Object, Oy),
    get_dict(type, Object, Type),
    X = Ox, Y = Oy.



find_castle_location(State, XMin, YMin, XMax, YMax) :- 
    State = [_, StateDict, _],
    get_dict(_, StateDict, Object),

    width(W),
    
    height(H),
    NewW is W-2,
    NewH is H-2,

    finish(NewW,NewH,State,[[A,B]|T]),
    XMin is A,
    YMin is B,
    XMax is A+2,
    YMax is B+2.

    


    
    
% 15 points
make_castle(State, ActionList) :- 
    build(State, ActionList).

    


build(State,ActionList):-
    mine_nearest_stone(State,Actlist1),
    execute_actions(State,Actlist1,SecondState),

    mine_nearest_stone(SecondState,Actlist2),
    execute_actions(SecondState,Actlist2,ThirdState),


    mine_nearest_stone(ThirdState,Actlist3),
    execute_actions(ThirdState,Actlist3,FourthState),


    find_castle_location(FourthState,Xmin,Ymin,Xmax,Ymax),
    XNav is Xmin+1,
    YNav is Ymin+1,
    navigate_to(FourthState,XNav,YNav,ActlistNav, 10000000),
    Boslisttt= [],
    append(Boslisttt,Actlist1,Build1),
    append(Build1,Actlist2,Build2),
    append(Build2,Actlist3,Build3),
    append(Build3,ActlistNav,Build4),
    append(Build4,[place_c,place_e,place_w,place_n,place_s,place_nw,place_ne,place_se,place_sw],ActionList),!.




build(State,ActionList):-
    
    mine_nearest_cobblestone(State,Actlist1),
    write("act111"),
    write(Actlist1),
    nl,
    execute_actions(State,Actlist1,SecondState),
    mine_nearest_cobblestone(SecondState,Actlist2),
    execute_actions(SecondState,Actlist2,ThirdState),

    mine_nearest_cobblestone(ThirdState,Actlist3),
    execute_actions(ThirdState,Actlist3,FourthState),



    mine_nearest_cobblestone(FourthState,Actlist4),
    execute_actions(FourthState,Actlist4,FifthState),

    mine_nearest_cobblestone(FifthState,Actlist5),
    execute_actions(FifthState,Actlist5,SixthState),

    mine_nearest_cobblestone(SixthState,Actlist6),
    execute_actions(SixthState,Actlist6,SeventhState),


    mine_nearest_cobblestone(SeventhState,Actlist7),
    execute_actions(SeventhState,Actlist7,EighthState),

    mine_nearest_cobblestone(EighthState,Actlist8),
    execute_actions(EighthState,Actlist8,NinthState),

    mine_nearest_cobblestone(NinthState,Actlist9),
    execute_actions(NinthState,Actlist9,LastState),
    write(801),


    find_castle_location(LastState,Xmin,Ymin,Xmax,Ymax),

    XNav is Xmin+1,
    YNav is Ymin+1,

    navigate_to(LastState,XNav,YNav,ActlistNav, 10000000),
    write("actlistnavigation"),
   % write(ActlistNav),
    nl,
    Boslisttt= [],

    append(Boslisttt,Actlist1,Build1),
    append(Build1,Actlist2,Build2),
    append(Build2,Actlist3,Build3),
    append(Build3,Actlist4,Build4),
    append(Build4,Actlist5,Build5),
    append(Build5,Actlist6,Build6),

    append(Build6,Actlist7,Build7), 
    append(Build7,Actlist8,Build8),
    append(Build8,Actlist9,Build9),

    append(Build9,ActlistNav,Build10),

    append(Build10,[place_c,place_e,place_w,place_n,place_s,place_nw,place_ne,place_se,place_sw],ActionList),!.












