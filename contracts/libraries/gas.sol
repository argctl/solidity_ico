library gas {

    function check (uint gasprice, uint gasleft, uint compare) returns (bool) {
        return gasprice * gasleft > compare;
    }

}