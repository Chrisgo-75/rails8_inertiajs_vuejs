export interface ProductType {
  id: number
  title: string
  // description: string
  // image: { filename: string; url: string }
  // price: number
}

export interface LineItemType {
  id: number
  product: ProductType
}

export interface CartType {
  id: number
  line_items: LineItemType[]
}

export type CartFormType = Omit<CartType, 'id'>
