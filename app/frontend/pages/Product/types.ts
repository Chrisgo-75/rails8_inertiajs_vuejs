export interface ProductType {
  id: number
  title: string
  description: string
  image: { filename: string; url: string }
  price: number
}

export type ProductFormType = Omit<ProductType, 'id' | 'image'> & {
  image?: File | null;
}
