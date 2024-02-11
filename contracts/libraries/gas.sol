library gas {

    function check (uint gasprice, uint gasleft, uint compare) public returns (bool) {
        return gasprice * gasleft > compare;
    }

}