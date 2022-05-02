import React from "react";

function PurchaseOrderPayType() {
  return (
    <div>
      <div className="field">
        <label htmlFor="order_po_date">PO #</label>
        <input 
          type="password"
          name="order[po_number]"
          id="order_po_number"
        />
      </div>
    </div>
  );
}

export default PurchaseOrderPayType;
