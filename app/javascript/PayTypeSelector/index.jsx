import React, { useState, useEffect } from "react";

import NoPayType from "./NoPayType";
import CreditCardPayType from "./CreditCardPayType";
import CheckPayType from "./CheckPayType";
import PurchaseOrderPayType from "./PurchaseOrderPayType";

function PayTypeCustomComponent({ prop }) {
  switch(prop) {
    case "Credit card":
      return <CreditCardPayType />
    case "Check":
      return <CheckPayType />
    case "Purchase order":
      return <PurchaseOrderPayType />
    default: 
      return <NoPayType />
  }
}

export default function PayTypeSelector() {
  const [payType, setPayType] = useState(null);

  function onPayTypeSelectedHandler(event) {
    setPayType(event.target.value);
  }

  return (
    <div>
      <div className="field">
        <label htmlFor="order_pay_type">Pay type</label>
        <select
          onChange={onPayTypeSelectedHandler}
          id="order_pay_type"
          name="order[pay_type]"
        >
          <option value="">Select a payment method</option>
          <option value="Check">Check</option>
          <option value="Credit card">Credit card</option>
          <option value="Purchase order">Purchase order</option>
        </select>
      </div>
      <PayTypeCustomComponent prop={payType} />
    </div>
  );
}
