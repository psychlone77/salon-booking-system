// components/AuthProvider.tsx
'use client';

import { createContext, useState, useEffect, ReactNode, FC } from 'react';
import { useRouter } from 'next/navigation';
import Cookies from 'js-cookie';

interface User {
    id: string;
    name: string;
    email: string;
    // Add other user properties as needed
}

interface AuthContextType {
    user: User | null;
    login: (credentials: Record<string, string>, type: 'owner' | 'user') => Promise<Response>;
    logout: () => Promise<void>;
}

export const AuthContext = createContext<AuthContextType | undefined>(undefined);

interface AuthProviderProps {
    children: ReactNode;
}

const AuthProvider: FC<AuthProviderProps> = ({ children }) => {
    const [user, setUser] = useState<User | null>(null);
    const router = useRouter();

    // Fetch user data on mount
    useEffect(() => {
        const token = Cookies.get('auth-token');
        if (token) {
            fetchUser(token);
        }
    }, []);

    const fetchUser = async (token: string) => {
        try {
            const res = await fetch('https://your-ballerina-api.com/auth/me', {
                headers: { Authorization: `Bearer ${token}` },
            });
            if (res.ok) {
                const data = await res.json();
                setUser(data.user);
            }
        } catch (error) {
            console.error('Failed to fetch user:', error);
            logout();
        }
    };

    const login = async (credentials: Record<string, string>, type: 'owner' | 'user'): Promise<Response> => {
        const endpoint =
            type === 'owner'
                ? 'https://your-ballerina-api.com/auth/owner/login'
                : 'https://your-ballerina-api.com/auth/login';
        const res = await fetch(endpoint, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(credentials),
        });
        if (res.ok) {
            const data = await res.json();
            Cookies.set('auth-token', data.token, { expires: 1 }); // 1 day expiry
            setUser(data.user);
            router.push(type === 'owner' ? '/salonAdmin/dashboard' : '/dashboard');
        }
        return res;
    };

    const logout = async () => {
        await fetch('https://your-ballerina-api.com/auth/logout', {
            method: 'POST',
            headers: { Authorization: `Bearer ${Cookies.get('auth-token')}` },
        });
        Cookies.remove('auth-token');
        setUser(null);
        router.push('/login');
    };

    return (
        <AuthContext.Provider value={{ user, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
};

export default AuthProvider;