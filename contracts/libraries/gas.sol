library gas {

    function bool (uint gasprice, uint gasleft, uint compare) returns (bool) {
        return gasprice * gasleft > compare;
    }

}