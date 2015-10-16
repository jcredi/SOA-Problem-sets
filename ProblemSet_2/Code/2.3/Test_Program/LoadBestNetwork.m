function bestNetwork = LoadBestNetwork

weightsInputToHidden = ...
  [-6.22480509379100,2.21579154990421,6.41066767565462,5.45932334391208;...
   -0.484287468609349,-1.49138157751249,1.45942734540968,0.305906596001475;...
   -2.02443083137066,1.43929208745831,6.42073452300936,1.56698065846620;...
   6.37525796226490,7.14438923307571,-4.47309367403553,8.09332959380250;...
   6.01045531607702,4.84939513974560,0.689884619491284,7.68777877019721;...
   -7.25296885934935,6.69251484647051,1.76723369227078,-1.22020666388820;...
   -2.40558601696907,-1.98926218216053,8.90923357430172,5.42158866546142;...
   1.01597891728967,10.7067826966121,-4.60458415088978,-12.9392794397942];

weightsHiddenToOutput = ...
    [-0.530829908797112,2.68923393540881,1.84888658847322,6.70456875331055,...
    7.61599085722684,0.230581843988517,-7.54769355930042,-3.58974311703923,6.47388464105477;...
    3.42210133118479,6.52482561146116,-0.148211258368923,-2.99785011002757,...
    -10.2353662041304,8.10508522081000,4.92026681344811,3.07677987251223,3.65035633434219];

bestNetwork = {weightsInputToHidden, weightsHiddenToOutput};


end