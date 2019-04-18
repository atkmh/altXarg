var nav4 = (document.layers) ? 1 : 0;
var ie4 = (document.all) ? 1 : 0;
var m0s = new Array("pubs","news","mmu","forums","solctr","store","mci","resources","compinfo");
var downer = new Array(169,195,219,245,270,155,184,248,190);
var l = 149;
if (nav4) {
	wd = innerWidth;
	ht = innerHeight;
}
function makev(name){
        if (moo == "ON"){
           makei(lastone);
         }
lastone = name;
moo = "ON";		
var zztop;
	for(zztop=0; zztop<m0s.length; zztop++){
          if (name == m0s[zztop]){
           var h = zztop;
          }
        }
	if(nav4){
		document.controlpanel.document.eval(name).left=l;
		document.controlpanel.document.eval(name).top=downer[h];
		document.controlpanel.document.eval(name).visibility="visible";
	}else
            if(ie4){
		eval(name).style.left=l;
		eval(name).style.top=downer[h];
		eval(name).style.visibility="visible";
	}
}
function makei(lastone){
	if(nav4){
		document.controlpanel.document.eval(lastone).visibility="hidden";
                moo = "OFF";
	}else 
            if(ie4){
		eval(lastone).style.visibility="hidden";
                moo = "OFF";
	}
}
function reSized() {
	if (innerWidth != wd || innerHeight != ht) 
		location.reload();
}
if (nav4) onresize = reSized;

