// app/providers.tsx
'use client'

import {NextUIProvider} from '@nextui-org/react'
import AuthProvider from '@/components/AuthProvider'

export function Providers({children}: { children: React.ReactNode }) {
  return (
    <AuthProvider>
      <NextUIProvider>
        {children}
      </NextUIProvider>
    </AuthProvider>
  )
}