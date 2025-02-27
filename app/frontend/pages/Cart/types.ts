export interface CartType {
  id: number
}

export type CartFormType = Omit<CartType, 'id'>
