//SPDX-License-Identifier: AdaCore-doc
library gas {

    function check (uint gasprice, uint gasleft, uint compare) public view returns (bool) {
        return gasprice * gasleft > compare;
    }

}
