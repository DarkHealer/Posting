pragma solidity ^0.4.0;
contract RecPost {
    
    string public _aRef; 
    string public _aQuantite; 
    string public _aMontant;
    string public _aBareme; 
    string public _aValeur; 
    uint public _numOffre; 
    
    uint public result; 
    
    struct Offre{
        string aQuant; 
        string aValue; 
    }
    
    mapping(uint=>Offre) _Execution; 
    
    enum stateContract {BBAO, BBACC, BBREF}
    
    stateContract public _state; 
    stateContract constant defaultState = stateContract.BBAO; 
    
    //constructeur
    function RecPost(string vRef, string vQuantite, string vMontant){
        _aRef = strConcat(vRef, " 01B","","","");
        _aQuantite = vQuantite;
        _aMontant =vMontant;
        _state = defaultState; 
    }
    
    function getState()returns (stateContract truc){
        truc = _state; 
    }
    
    function setState(uint8 state, string message)returns(string mess){
        if(state == 1){
            _state = stateContract.BBACC;  
            mess = " ";
        } 
        else if(state == 2) {
            _state = stateContract.BBREF;
            mess = message;
        }
    }
    

    //permet d'ajouter une offre
    function addOffre(string vQuantite, string vMontant){
        Offre newOffre = _Execution[_numOffre];
        newOffre.aQuant = vQuantite;
        newOffre.aValue =vMontant;
        _numOffre++;
    }

    
    function avisOperer()returns(string message){
        message = strConcat(_aRef,_aQuantite,_aMontant,_aBareme,_aValeur);
        
    }
    
    function getOffre(uint val)returns(string Valeur){
        Valeur = _Execution[val].aValue;
    }
    
    function calcul(uint coursCot, uint plCot)returns(uint result){
        result = stringToUint(_aQuantite)*coursCot+plCot;
    }
    
    
    //Convertion d'un string en une uint
    function stringToUint(string s) internal returns (uint result) {
        bytes memory b = bytes(s);
        uint i;
        result = 0;
        for (i = 0; i < b.length; i++) {
            uint c = uint(b[i]);
            if (c >= 48 && c <= 57) {
                result = result * 10 + (c - 48);
            }
        }
    }
    
    
    //Permet de concaténer deux string
    function strConcat(string _a, string _b, string _c, string _d, string _e) internal returns (string){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        bytes memory _bd = bytes(_d);
        bytes memory _be = bytes(_e);
        string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
        bytes memory babcde = bytes(abcde);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
        for (i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];
        for (i = 0; i < _bc.length; i++) babcde[k++] = _bc[i];
        for (i = 0; i < _bd.length; i++) babcde[k++] = _bd[i];
        for (i = 0; i < _be.length; i++) babcde[k++] = _be[i];
        return string(babcde);
    
    }
    
}