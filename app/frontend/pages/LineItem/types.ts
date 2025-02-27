export interface LineItemType {
  id: number
  product_id: string
  cart_id: string
}

export type LineItemFormType = Omit<LineItemType, 'id'>
